drop TABLE ENTITY_RELATIONSHIP
drop TABLE ENTITY_NODE
go
CREATE TABLE ENTITY_NODE (
  entity_guid nvarchar(255) PRIMARY KEY,
  active_name NVARCHAR(max),
  identity_text nvarchar(max)
) AS NODE;


CREATE TABLE ENTITY_RELATIONSHIP (relationship_guid uniqueidentifier not null, relationship_subtype_uid integer not null, is_past_relationship bit not null) AS EDGE;

insert into ENTITY_NODE
select entity_guid, active_name, 
IIF(
	ISNULL(company_registration_number,'') <> '' ,
	company_registration_number,  
	IIF(
		ISNULL(nric,'') <> '' ,
		nric, passport_number
			)) from ENTITY
			

insert into ENTITY_RELATIONSHIP
select enf.$node_id, ent.$node_id, relationship_guid,  relationship_subtype_uid,is_past_relationship from RELATIONSHIP r
join ENTITY_NODE enf on enf.entity_guid = r.entity_from_guid
join ENTITY_NODE ent on ent.entity_guid = r.entity_to_guid


insert into ENTITY_RELATIONSHIP
select enf.$node_id, ent.$node_id, relationship_guid,  relationship_subtype_uid,is_past_relationship from RELATIONSHIP r
join ENTITY_NODE enf on enf.entity_guid = r.entity_to_guid
join ENTITY_NODE ent on ent.entity_guid = r.entity_from_guid

select * from 
(
SELECT f.entity_guid as from_guid, f.active_name as from_name
	,string_agg(t.entity_guid, '->') within group (GRAPH PATH) as to_guid_path
	,LAST_VALUE(t.entity_guid) WITHIN GROUP (GRAPH PATH) AS LastNode_guid
	,LAST_VALUE(t.active_name) WITHIN GROUP (GRAPH PATH) AS LastNode_name
	,LAST_VALUE(r.relationship_subtype_uid) WITHIN GROUP (GRAPH PATH) AS LastNode_type
	,COUNT(t.entity_guid) WITHIN GROUP (GRAPH PATH) AS levels
FROM ENTITY_NODE f , ENTITY_RELATIONSHIP for path as r, ENTITY_NODE for path as t
WHERE MATCH (shortest_path(f(-(r)->t){1,8})) 
and (f.entity_guid = '3E7EC5C2-3AA0-469C-A664-1EEC51CD9983'  )
union 
SELECT f.entity_guid as from_guid, f.active_name as from_name
	,string_agg(t.entity_guid, '->') within group (GRAPH PATH) as to_guid_path
	,LAST_VALUE(t.entity_guid) WITHIN GROUP (GRAPH PATH) AS LastNode_guid
	,LAST_VALUE(t.active_name) WITHIN GROUP (GRAPH PATH) AS LastNode_name
	,LAST_VALUE(r.relationship_subtype_uid) WITHIN GROUP (GRAPH PATH) AS LastNode_type
	,COUNT(t.entity_guid) WITHIN GROUP (GRAPH PATH) AS levels
FROM ENTITY_NODE f , ENTITY_RELATIONSHIP for path as r, ENTITY_NODE for path as t
WHERE MATCH (shortest_path(f(<-(r)-t){1,8})) 
and (f.entity_guid = '3E7EC5C2-3AA0-469C-A664-1EEC51CD9983'  )
) allre
order by levels 


select distinct entity_from_guid,entity_to_guid from relationship where entity_from_guid =  '3E7EC5C2-3AA0-469C-A664-1EEC51CD9983' or entity_to_guid =  '3E7EC5C2-3AA0-469C-A664-1EEC51CD9983'
select * from ENTITY_RELATIONSHIP where relationship_guid in 
(select relationship_guid from relationship where entity_from_guid =  '3E7EC5C2-3AA0-469C-A664-1EEC51CD9983' or entity_to_guid =  '3E7EC5C2-3AA0-469C-A664-1EEC51CD9983')




--select * from relationship 
--where ( entity_from_guid = '921E9C86-9992-4E8E-A4B4-851B0975AE7D' and entity_to_guid in ('EA4ADF7D-C2F7-43D4-B2B6-4D74EA6FEDB0','D455BFC8-D17E-4D93-88D1-8BD43A681F6C'))
--or (entity_from_guid = 'EA4ADF7D-C2F7-43D4-B2B6-4D74EA6FEDB0' and entity_to_guid in ('E2115B2B-8D33-4366-9F5C-B8055FB92FEA'))
--or (entity_from_guid = 'E2115B2B-8D33-4366-9F5C-B8055FB92FEA' and entity_to_guid in ('E7DBF129-6083-4979-AAD8-2FB574CD8CED',
--'F4F5D160-DA04-4F04-9051-3E95B89C93C0',
--'DF401A80-181F-4383-A00D-71F46B98243A',
--'68F44BBA-8774-4522-932F-7596E8A6E566'))
--or (entity_from_guid = 'DF401A80-181F-4383-A00D-71F46B98243A' and entity_to_guid in ('C061DF14-629C-4EB9-BE70-AA0C354E17B5','0E7CCD13-F6C6-4337-A14B-DD11E6C962B3'))
--or (entity_from_guid = 'C061DF14-629C-4EB9-BE70-AA0C354E17B5' and entity_to_guid in ('6315BF31-5884-48F4-B846-51F5B1F60C76'))



--update relationship set relationship_subtype_uid = 1 where relationship_guid = '0A9800CB-8EBE-4238-B7BF-00CFB90FC6C3'
--update relationship set relationship_subtype_uid = 2 where relationship_guid = 'C1615174-7FBA-4ECF-B0F9-1E4E7B700FD4'
--update relationship set relationship_subtype_uid = 3 where relationship_guid = 'E3CD43F7-49C1-4FE6-A4B3-3ABD32C7CB8C'
--update relationship set relationship_subtype_uid = 4 where relationship_guid = 'BEF683DC-BDEC-4BE9-9836-3CEA64008950'
--update relationship set relationship_subtype_uid = 5 where relationship_guid = '6A323725-35C6-4FBE-8728-541C2567B698'
--update relationship set relationship_subtype_uid = 6 where relationship_guid = '3E392DBC-6891-4DB6-8B43-931ABB6117D6'
--update relationship set relationship_subtype_uid = 7 where relationship_guid = 'C70A0A08-90CE-4D09-9C62-B7488CD30A06'
--update relationship set relationship_subtype_uid = 8 where relationship_guid = '55AA6312-0CA0-494F-9652-B99097CBD195'
--update relationship set relationship_subtype_uid = 9 where relationship_guid = 'A2B5833C-F82E-4472-9C32-C354934D8160'
--update relationship set relationship_subtype_uid = 10 where relationship_guid = 'E091C94C-CEF1-4610-9C8E-FC83628C09E0'



select top 10 * from RELATIONSHIP r 
where exists (select 1 from RELATIONSHIP rr where rr.entity_from_guid = r.entity_to_guid)


select * from RELATIONSHIP 
where entity_from_guid = '3E7EC5C2-3AA0-469C-A664-1EEC51CD9983' or entity_to_guid = '3E7EC5C2-3AA0-469C-A664-1EEC51CD9983'