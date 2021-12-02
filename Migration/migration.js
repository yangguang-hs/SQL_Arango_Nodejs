var mysql = require('mssql');
var express = require('express');
var app = express();
var sql = require("mssql");
var sqlConfig = {
        user: 'xxx',
        password: 'xxx',
        server: 'xxx', 
        port:1433,
        database: 'xxx' ,
        options: { encrypt: false }
    };
const { Database, aql } = require("arangojs");
const arangoDB = new Database({
  url: 'http://127.0.0.1:8529/',
  database: "TestDB",
  auth: { username: "xxx", password: "xxx" },
}); 
//somehow the config for database is not working, need to useDatabase again
//arangoDB name is case sensitive, 
const dbName = 'TestDB_5M'


app.get('/', function (req, res) {
   	res.send('<html><body><h1>Migration</h1></body></html>');
});

app.get('/migrateEntity', async function (req, res) {
	let ct = await queryTotalCount('select count(*) as ct from entity');
    console.log(ct)
    let current = 0;
    let lastGuid = '00000000-0000-0000-0000-000000000000';
    arangoDB.useDatabase(dbName)
	const entityCollect = arangoDB.collection('Entity');

    while (current < ct)
    {
		
    	let entities = await queryObject('select top 100000 * from entity where entity_guid > @lastguid order by entity_guid', lastGuid);
    	if (entities.length == 0)
    		break;
    	let result = await entityCollect.import(entities);
		console.log(`Processing ${current} / ${ct} | ${(current*100/ct).toFixed(2)}%| E ${result.errors} | C ${result.created} |${new Date().toISOString()}`)
    	lastGuid = entities[entities.length-1].entity_guid;
    	current = current + entities.length;
    }
	//local import time: 6-8s for 100000 records
	//won't update existing document, will give in error count
	res.send("complete")
	 
})

app.get('/migrateRelationship', async function (req, res) {
	let ct = await queryTotalCount('select count(*) as ct from Relationship');
    console.log(ct)
    let current = 0;
    let lastGuid = '00000000-0000-0000-0000-000000000000';
    arangoDB.useDatabase(dbName)
	const relationshipCollect = arangoDB.collection('Relationship');

    while (current < ct)
    {
		
    	let relationships = await queryObject('select top 100000 * from Relationship where _key > @lastguid order by _key', lastGuid);
    	if (relationships.length == 0)
    		break;
    	let result = await relationshipCollect.import(relationships);
    	lastGuid = relationships[relationships.length-1]._key;
    	current = current + relationships.length;
    	console.log(`Processing ${current} / ${ct} | ${(current*100/ct).toFixed(2)}%| E ${result.errors} | C ${result.created} |${new Date().toISOString()}`)
    }
	//local import time: 6-8s for 100000 records
	//won't update existing document, will give in error count
	res.send("complete")
	 
})

app.get('/arangoCRUD', async function (req, res) {
   	let action = req.query.action

    let ct = await queryTotalCount('select count(*) as ct from entity');
    console.log(ct)
    let current = 0;
    let lastGuid = '00000000-0000-0000-0000-000000000000';
    let allentities = []
    while (current < ct)
    {

    	let entities = await queryObject('select top 10000 * from entity where entity_guid > @lastguid order by entity_guid', lastGuid);
    	console.log(entities[0])
    	console.log(entities[1])
    	allentities = allentities.concat(entities);
    	break;

    }

	arangoDB.useDatabase(dbName)
    const entityCollect = arangoDB.collection('Entity');
   
   	if (action == 'create'){

	   	console.log("creating")
	   	//create doc
	   	entityCollect.save(allentities[0]).then(
		  meta => console.log('Document saved:', meta._rev),
		  err => console.error('Failed to save document:', err)
		);

		//get document
		entityCollect.document(allentities[0]).then(
		  doc => console.log('Document:', JSON.stringify(doc, null, 2)),
		  err => console.error('Failed to fetch document:', err.message));

   	}
   	if (action == 'update'){
   		console.log("updating")
	   	//update
	   	entityCollect.update(allentities[0]._key, allentities[1]).then(
		  meta => console.log('Document updated:', meta._rev),
		  err => console.error('Failed to update document:', err)
		);

		//get document
		entityCollect.document(allentities[0]).then(
		  doc => console.log('Document:', JSON.stringify(doc, null, 2)),
		  err => console.error('Failed to fetch document:', err.message));

		//get document
		entityCollect.document(allentities[1]).then(
		  doc => console.log('Document:', JSON.stringify(doc, null, 2)),
		  err => console.error('Failed to fetch document:', err.message));
   	}

	if (action == 'delete'){
		console.log("deleting")
   		//delete
	   	entityCollect.remove(allentities[0]._key).then(
		  () => console.log('Document removed'),
		  err => console.error('Failed to remove document', err)
		);
	 
	 	//get document
		entityCollect.document(allentities[0]).then(
		  doc => console.log('Document:', JSON.stringify(doc, null, 2)),
		  err => console.error('Failed to fetch document:', err.message));

		//get document
		entityCollect.document(allentities[1]).then(
		  doc => console.log('Document:', JSON.stringify(doc, null, 2)),
		  err => console.error('Failed to fetch document:', err.message));

   	}
	

	
    res.send("result");
});


app.get('/arangoRadialMap', async function(req,res){
    let parameter = {key: '02CB4288-EA24-4D7F-8532-6A06566E28F0'}
    let query = `
			for en in Entity
			    filter en._key == @key
			    for v, e, p in 1..3 any en Relationship
			        filter v!=null 
			        sort length(p.edges)
			        return {
			                    related_name: v.active_name, 
			                    related_id: v._key, 
			                    source_name: en.active_name, 
			                    source_id: en._key, 
			                    distance: length(p.edges),
			                    nodes:p.vertices[*].active_name
			                }
    	`
    console.log('start query' , new Date())
    let result = await aqlQuery(query, parameter, dbName);
    console.log('end query' , new Date())


    res.send(result);

})

app.get('/arangoInterconnect', async function(req,res){
    let parameter = {
    		fromEntity: 'Entity/02CB4288-EA24-4D7F-8532-6A06566E28F0',
			toEntity: 'Entity/05CAE7BD-96DC-491B-9401-530FB2DBAC8B'
		}
    //get all the path from A->B without duplicate node, also need to indicate the length
    let query = `FOR p IN 1..10 any K_paths @fromEntity TO @toEntity Graph Radial 
					filter null not in p.vertices[*].active_name
					RETURN {
					nodes:p.vertices[*].active_name,
					distance: length(p.edges)}
					`
    console.log('start query' , new Date())
    let result = await aqlQuery(query, parameter, dbName);
    console.log('end query' , new Date())


    res.send(result);

})

async function aqlQuery(queryStr, params, dbName){
	arangoDB.useDatabase(dbName)
	let cursor = await arangoDB.query({
				  query: queryStr,
				  bindVars: params
				})
	let result = [];
    for await (const value of cursor)
    {
    	result.push(value)
    }
    return result;
}

async function queryTotalCount(queryStr){
	let pool = await sql.connect(sqlConfig);
    let data = await pool.request().query(queryStr);
   	// Store each record in an array
   	let count = data.recordset[0].ct;
	pool.close;
	sql.close;
   return count;
}

async function queryObject(queryStr, param){
	let pool = await sql.connect(sqlConfig);
    let data = await pool.request().input('lastguid', param).query(queryStr);
   	// Store each record in an array
   	let results = data.recordset;
	pool.close;
	sql.close;
   return results;
}

var server = app.listen(5000, function () {
    console.log('Server is running..');
});
