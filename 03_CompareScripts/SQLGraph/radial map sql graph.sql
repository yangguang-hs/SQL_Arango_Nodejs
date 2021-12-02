
SELECT f.entity_guid as from_guid, f.active_name as from_name
, t1.active_name as t1_name
FROM ENTITY_NODE f , ENTITY_RELATIONSHIP  r1, ENTITY_NODE  t1 
WHERE MATCH (f-(r1)->t1 ) 
and f.entity_guid = '02CB4288-EA24-4D7F-8532-6A06566E28F0'  

union

SELECT f.entity_guid as from_guid, f.active_name as from_name
, concat( t1.active_name, '|',t2.active_name)
FROM ENTITY_NODE f , ENTITY_RELATIONSHIP  r1, ENTITY_NODE  t1 , ENTITY_RELATIONSHIP  r2, ENTITY_NODE  t2
WHERE MATCH (f-(r1)->t1 -(r2)->t2 )
and f.entity_guid = '02CB4288-EA24-4D7F-8532-6A06566E28F0'   

union

SELECT f.entity_guid as from_guid, f.active_name as from_name
, concat( t1.active_name, '|',t2.active_name, '|',t3.active_name)
FROM ENTITY_NODE f , ENTITY_RELATIONSHIP  r1, ENTITY_NODE  t1 , ENTITY_RELATIONSHIP  r2, ENTITY_NODE  t2
 , ENTITY_RELATIONSHIP  r3, ENTITY_NODE  t3
WHERE MATCH (f-(r1)->t1 -(r2)->t2 -(r3)->t3 ) 
and f.entity_guid = '02CB4288-EA24-4D7F-8532-6A06566E28F0'   

union

SELECT f.entity_guid as from_guid, f.active_name as from_name
, concat( t1.active_name, '|',t2.active_name, '|',t3.active_name, '|',t4.active_name)
FROM ENTITY_NODE f , ENTITY_RELATIONSHIP  r1, ENTITY_NODE  t1 , ENTITY_RELATIONSHIP  r2, ENTITY_NODE  t2
 , ENTITY_RELATIONSHIP  r3, ENTITY_NODE  t3, ENTITY_RELATIONSHIP  r4, ENTITY_NODE  t4
WHERE MATCH (f-(r1)->t1 -(r2)->t2 -(r3)->t3 -(r4)->t4) 
and f.entity_guid = '02CB4288-EA24-4D7F-8532-6A06566E28F0'   

union

SELECT f.entity_guid as from_guid, f.active_name as from_name
, concat( t1.active_name, '|',t2.active_name, '|',t3.active_name, '|',t4.active_name, '|',t5.active_name)
FROM ENTITY_NODE f , ENTITY_RELATIONSHIP  r1, ENTITY_NODE  t1 , ENTITY_RELATIONSHIP  r2, ENTITY_NODE  t2
 , ENTITY_RELATIONSHIP  r3, ENTITY_NODE  t3, ENTITY_RELATIONSHIP  r4, ENTITY_NODE  t4
 , ENTITY_RELATIONSHIP  r5, ENTITY_NODE  t5
WHERE MATCH (f-(r1)->t1 -(r2)->t2 -(r3)->t3 -(r4)->t4 -(r5)->t5) 
and f.entity_guid = '02CB4288-EA24-4D7F-8532-6A06566E28F0'  


union

SELECT f.entity_guid as from_guid, f.active_name as from_name
, concat( t1.active_name, '|',t2.active_name, '|',t3.active_name, '|',t4.active_name, '|',t5.active_name
, '|',t6.active_name)
FROM ENTITY_NODE f , ENTITY_RELATIONSHIP  r1, ENTITY_NODE  t1 , ENTITY_RELATIONSHIP  r2, ENTITY_NODE  t2
 , ENTITY_RELATIONSHIP  r3, ENTITY_NODE  t3, ENTITY_RELATIONSHIP  r4, ENTITY_NODE  t4
 , ENTITY_RELATIONSHIP  r5, ENTITY_NODE  t5 , ENTITY_RELATIONSHIP  r6, ENTITY_NODE  t6
WHERE MATCH (f-(r1)->t1 -(r2)->t2 -(r3)->t3 -(r4)->t4 -(r5)->t5-(r6)->t6) 
and f.entity_guid = '02CB4288-EA24-4D7F-8532-6A06566E28F0'  

union

SELECT f.entity_guid as from_guid, f.active_name as from_name
, concat( t1.active_name, '|',t2.active_name, '|',t3.active_name, '|',t4.active_name, '|',t5.active_name
, '|',t6.active_name, '|',t7.active_name)
FROM ENTITY_NODE f , ENTITY_RELATIONSHIP  r1, ENTITY_NODE  t1 , ENTITY_RELATIONSHIP  r2, ENTITY_NODE  t2
 , ENTITY_RELATIONSHIP  r3, ENTITY_NODE  t3, ENTITY_RELATIONSHIP  r4, ENTITY_NODE  t4
 , ENTITY_RELATIONSHIP  r5, ENTITY_NODE  t5 , ENTITY_RELATIONSHIP  r6, ENTITY_NODE  t6
 , ENTITY_RELATIONSHIP  r7, ENTITY_NODE  t7
WHERE MATCH (f-(r1)->t1 -(r2)->t2 -(r3)->t3 -(r4)->t4 -(r5)->t5-(r6)->t6-(r7)->t7) 
and f.entity_guid = '02CB4288-EA24-4D7F-8532-6A06566E28F0'  

union

SELECT f.entity_guid as from_guid, f.active_name as from_name
, concat( t1.active_name, '|',t2.active_name, '|',t3.active_name, '|',t4.active_name, '|',t5.active_name
, '|',t6.active_name, '|',t7.active_name, '|',t8.active_name)
FROM ENTITY_NODE f , ENTITY_RELATIONSHIP  r1, ENTITY_NODE  t1 , ENTITY_RELATIONSHIP  r2, ENTITY_NODE  t2
 , ENTITY_RELATIONSHIP  r3, ENTITY_NODE  t3, ENTITY_RELATIONSHIP  r4, ENTITY_NODE  t4
 , ENTITY_RELATIONSHIP  r5, ENTITY_NODE  t5 , ENTITY_RELATIONSHIP  r6, ENTITY_NODE  t6
 , ENTITY_RELATIONSHIP  r7, ENTITY_NODE  t7, ENTITY_RELATIONSHIP  r8, ENTITY_NODE  t8
WHERE MATCH (f-(r1)->t1 -(r2)->t2 -(r3)->t3 -(r4)->t4 -(r5)->t5-(r6)->t6-(r7)->t7-(r8)->t8) 
and f.entity_guid = '02CB4288-EA24-4D7F-8532-6A06566E28F0'  

union

SELECT f.entity_guid as from_guid, f.active_name as from_name
, concat( t1.active_name, '|',t2.active_name, '|',t3.active_name, '|',t4.active_name, '|',t5.active_name
, '|',t6.active_name, '|',t7.active_name, '|',t8.active_name, '|',t9.active_name)
FROM ENTITY_NODE f , ENTITY_RELATIONSHIP  r1, ENTITY_NODE  t1 , ENTITY_RELATIONSHIP  r2, ENTITY_NODE  t2
 , ENTITY_RELATIONSHIP  r3, ENTITY_NODE  t3, ENTITY_RELATIONSHIP  r4, ENTITY_NODE  t4
 , ENTITY_RELATIONSHIP  r5, ENTITY_NODE  t5 , ENTITY_RELATIONSHIP  r6, ENTITY_NODE  t6
 , ENTITY_RELATIONSHIP  r7, ENTITY_NODE  t7, ENTITY_RELATIONSHIP  r8, ENTITY_NODE  t8
 , ENTITY_RELATIONSHIP  r9, ENTITY_NODE  t9
WHERE MATCH (f-(r1)->t1 -(r2)->t2 -(r3)->t3 -(r4)->t4 -(r5)->t5-(r6)->t6-(r7)->t7-(r8)->t8-(r9)->t9) 
and f.entity_guid = '02CB4288-EA24-4D7F-8532-6A06566E28F0'  
