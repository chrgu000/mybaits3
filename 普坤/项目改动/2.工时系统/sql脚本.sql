INSERT INTO MM_DICTTYPE(ID,CODE,NAME,CREATOR_ID,CREATE_DATE,MODIFIER_ID,MODIFY_DATE,USE_SCOPE_ID,IS_VALID,VERSION)
VALUES(88000008,'POSITION','职位',1001,SYSDATE,1001,SYSDATE,1032,1001,1);
INSERT INTO MM_DICTVALUE(ID,CODE,NAME,CREATOR_ID,CREATE_DATE,MODIFIER_ID,MODIFY_DATE,USE_SCOPE_ID,IS_VALID,VERSION)
VALUES(88000019,'1','部门经理',1001,SYSDATE,1001,SYSDATE,1032,1001,1);
INSERT INTO MM_DICTVALUE(ID,CODE,NAME,CREATOR_ID,CREATE_DATE,MODIFIER_ID,MODIFY_DATE,USE_SCOPE_ID,IS_VALID,VERSION)
VALUES(88000020,'1','员工',1001,SYSDATE,1001,SYSDATE,1032,1001,1);
INSERT INTO MR_DICTTYPE_DICTVALUE(ID,DICTTYPE_ID,DICTVALUE_ID,CREATOR_ID,CREATE_DATE,MODIFIER_ID,MODIFY_DATE,IS_VALID,VERSION,USE_SCOPE_ID)
VALUES(8800000018,88000008,88000019,1001,SYSDATE,1001,SYSDATE,1001,1,1032);

--在数据表添加字段
alter table CM_TIMESHEET add PM_APPROVE_ID number(22);
alter table CM_TIMESHEET add DM_APPROVE_ID number(22);
--元数据字段添加
insert into mm_field (ID, CODE, NAME, TABLE_ID, DATA_TYPE_ID, LENGTH, PPRECISION, IS_NULL, DEFAULT_VALUE, FIELD_ROLE_ID, CREATOR_ID, CREATE_DATE, MODIFIER_ID, MODIFY_DATE, IS_VALID, NOTES, SEQ, VERSION, KV_COLUMN_CLUSTER, USE_SCOPE_ID)
values (8800000171, 'PM_APPROVE_ID', '项目经理审核记录', 8800000001, 1017, 22, null, 1026, null, 1028, 1011, to_date('10-01-2017 10:00:16', 'dd-mm-yyyy hh24:mi:ss'), 1011, to_date('10-01-2017 10:00:16', 'dd-mm-yyyy hh24:mi:ss'), 1011, null, 27, 1, null, 1032);
insert into mm_field (ID, CODE, NAME, TABLE_ID, DATA_TYPE_ID, LENGTH, PPRECISION, IS_NULL, DEFAULT_VALUE, FIELD_ROLE_ID, CREATOR_ID, CREATE_DATE, MODIFIER_ID, MODIFY_DATE, IS_VALID, NOTES, SEQ, VERSION, KV_COLUMN_CLUSTER, USE_SCOPE_ID)
values (8800000172, 'DM_APPROVE_ID', '部门经理审核记录', 8800000001, 1017, 22, null, 1026, null, 1028, 1011, to_date('10-01-2017 10:00:16', 'dd-mm-yyyy hh24:mi:ss'), 1011, to_date('10-01-2017 10:00:16', 'dd-mm-yyyy hh24:mi:ss'), 1011, null, 28, 1, null, 1032);
--实体属性添加
insert into mm_spec_attribute (ID, CODE, NAME, SPEC_ID, SPEC_TYPE_ID, DICTTYPE_ID, ATTR_GROUP_ID, TABLE_CODE, FIELD_CODE, IS_VISIBLE, IS_NULL, IS_READ, IS_UPDATE, IS_BATCH_UPDATE, DEFAULT_VALUE, CREATOR_ID, CREATE_DATE, MODIFIER_ID, MODIFY_DATE, IS_VALID, ALLOW_CUSTOM, IS_MULTICHOOSE, NOTES, VERSION, KV_COLUMN_CLUSTER, SOURCE_SPEC_ID, USE_SCOPE_ID)
values (8800000171, 'PM_APPROVE_ID', '项目经理审核记录', 8810000000, 1033, null, null, 'CM_TIMESHEET', 'PM_APPROVE_ID', 1025, 1026, 1025, 1025, 1025, null, 1001, to_date('10-01-2017 11:20:05', 'dd-mm-yyyy hh24:mi:ss'), 1001, to_date('10-01-2017 11:20:05', 'dd-mm-yyyy hh24:mi:ss'), 1001, 1026, null, null, 1, null, null, 1032);
insert into mm_spec_attribute (ID, CODE, NAME, SPEC_ID, SPEC_TYPE_ID, DICTTYPE_ID, ATTR_GROUP_ID, TABLE_CODE, FIELD_CODE, IS_VISIBLE, IS_NULL, IS_READ, IS_UPDATE, IS_BATCH_UPDATE, DEFAULT_VALUE, CREATOR_ID, CREATE_DATE, MODIFIER_ID, MODIFY_DATE, IS_VALID, ALLOW_CUSTOM, IS_MULTICHOOSE, NOTES, VERSION, KV_COLUMN_CLUSTER, SOURCE_SPEC_ID, USE_SCOPE_ID)
values (8800000172, 'DM_APPROVE_ID', '部门经理审核记录', 8810000000, 1033, null, null, 'CM_TIMESHEET', 'DM_APPROVE_ID', 1025, 1026, 1025, 1025, 1025, null, 1001, to_date('10-01-2017 11:20:05', 'dd-mm-yyyy hh24:mi:ss'), 1001, to_date('10-01-2017 11:20:05', 'dd-mm-yyyy hh24:mi:ss'), 1001, 1026, null, null, 1, null, null, 1032);
--tm_attributetype
insert into tm_attributetype (ID, SPECATTRIBUTE_ID, CODE, NAME, REFERENCEKEY, PRIMARYKEY, FOREIGNKEY, PARENTPROPERTY, PARENTPROPERTYNAME, TABLETYPE, DATATYPE, LENGTH, PRECISION, ENABLE, ENUMERABLEMODELNAME)
values (8800000171, 8800000171, 'pmApproveId', '项目经理审核记录', null, null, null, null, null, 1011, 35, 22, null, 1, null);
insert into tm_attributetype (ID, SPECATTRIBUTE_ID, CODE, NAME, REFERENCEKEY, PRIMARYKEY, FOREIGNKEY, PARENTPROPERTY, PARENTPROPERTYNAME, TABLETYPE, DATATYPE, LENGTH, PRECISION, ENABLE, ENUMERABLEMODELNAME)
values (8800000172, 8800000172, 'dmApproveId', '部门经理审核记录', null, null, null, null, null, 1011, 35, 22, null, 1, null);	