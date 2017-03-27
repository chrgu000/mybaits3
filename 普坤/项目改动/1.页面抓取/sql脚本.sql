
--添加用于存储字段的可见性,和枚举值
ALTER TABLE TM_SYSTEM_RUNNER_COND ADD OPTIONS VARCHAR2(2000);
--删除之前用于抓头的ID
ALTER TABLE tm_system_runner DROP COLUMN input_run_id;
--增加用于存储字段类型的字段
ALTER TABLE tm_system_runner_cond ADD FIELD_TYPE VARCHAR2(255);
--增加字段来判断该字段是否为索引字段
alter table TM_RUNNERATTR_SPECATTR add  IS_INDEX number;
--由于属性映射时页面属性为可空,所以也得区分场景
alter table TM_RUNNERATTR_SPECATTR add  spec_name varchar(255);
--增加字段来标识该字段来自哪一个实体
alter table tm_system_runner_attr add spec_name varchar(255);
--映射字段类型
alter table TM_RUNNERATTR_SPECATTR add  mapping_type varchar(255);
--映射字段额外参数(字典值,关系code等)
alter table TM_RUNNERATTR_SPECATTR add  mapping_data varchar(4000);
--增加保存规格ID的字段
alter table TM_RUNNERATTR_SPECATTR add  spec_id number;
--创建关系映射表
create table c_rowkey_code as(select ID,NAME,CODE,VERSION,ID run_Id from tm_coolaction where 1 <> 1);
--添加rowkey保存字段
alter table c_rowkey_code add rowkey varchar(255);
--添加保存页面主属性字段
alter table c_rowkey_code add page_code varchar(255);
--创建序列
create sequence seq_c_rowkey_code
increment by 1
start with 1
maxvalue 99999999999999999;
--  添加映射关系上传
insert into tm_coolaction (ID, NAME, CODE, VERSION, HANDLER, PARAMETER)
values (104, '上传映射关系', 'rowkeyMappingCodeUpload', 1, null, 'actionType:rowkeyMappingCodeUpload');
insert into tm_coolbutton (ID, NAME, CODE, VERSION, ACTION_ID, SEPARATOR, ICON, TOOLBAR_ID, VISIBLE, ENABLE, ORDINAL, PARAMETER, TOOLTIP)
values (104, '上传映射关系', 'rowkeyMappingCodeUpload', 1, 104, null, 'assets/images/queryView.png', 25, 1, 1, 7, null, null);

--添加规格查询页面
insert into tm_gridpage (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, CRITERIATEMPLATE_ID, CRITERIASTATEMENT_ID, RESULTTEMPLATE_ID, COOLBAR_ID, EXPORTCRITERIASTATEMENT_ID, STATISTICS, ASYNCHRONOUS, OTHERDATASOURCE, AUTOQUERY)
values (501, '实体规格管理', null, null, 1, sysdate, 'default', sysdate, 'default', 501, 501, 502, null, null, null, null, null, null);
--添加规格查询语句
insert into tm_criteriastatement (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, STATEMENTTYPE, CRITERIASTATEMENT, PREFEREDSTATEMENT, ROWMAPPERCLASS, SUFFIXSQLCRITERIA, DETAILTABLENAME)
values (501, '实体规格查询', null, null, 1, sysdate, 'default', sysdate, 'default', 2, 'select ID, NAME, CODE, PARENT_ID, (SELECT NAME FROM MM_ENTITY_SPEC WHERE T.PARENT_ID = ID) PARENT_NAME, SPEC_LEVEL_ID, (SELECT NAME FROM MM_DICTVALUE WHERE T.SPEC_LEVEL_ID = ID) SPEC_LEVEL_NAME, IS_VALID, (SELECT NAME FROM MM_DICTVALUE WHERE T.IS_VALID = ID) IS_VALID_NAME, MODEL_DOMAIN, (SELECT NAME FROM MM_DICTVALUE WHERE T.MODEL_DOMAIN = ID) MODEL_DOMAIN_NAME, NOTES, VERSION, CREATE_DATE, CREATOR_ID, MODIFY_DATE, MODIFIER_ID from (SELECT A.*, 0 PROJECT, null OPERATIONTYPE, null CHANGEINFO FROM MM_ENTITY_SPEC A ) T WHERE 1 = 1', null, null, null, null);
--添加查询模板和结果模板
insert into tm_entitytemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ORDINAL, ENABLE)
values (501, '实体规格查询条件', null, null, 1, sysdate, 'default', sysdate, 'default', 1, 1);
insert into tm_entitytemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ORDINAL, ENABLE)
values (502, '实体规格查询结果', null, null, 1, sysdate, 'default', sysdate, 'default', 1, 1);
--添加查询条件和结果映射
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5001, '名称', 'NAME', null, 1, sysdate, 'default', sysdate, 'default', 501, null, null, 1, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5002, '编码', 'CODE', null, 1, sysdate, 'default', sysdate, 'default', 501, null, null, 2, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5008, 'ID', 'ID', null, 1, sysdate, 'default', sysdate, 'default', 502, null, null, 1, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5009, '名称', 'NAME', null, 1, sysdate, 'default', sysdate, 'default', 502, null, null, 2, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5010, '编码', 'CODE', null, 1, sysdate, 'default', sysdate, 'default', 502, null, null, 3, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5011, '父实体', 'PARENT_NAME', null, 1, sysdate, 'default', sysdate, 'default', 502, null, null, 4, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5012, '规格层级', 'SPEC_LEVEL_NAME', null, 1, sysdate, 'default', sysdate, 'default', 502, null, null, 5, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5013, '业务域', 'MODEL_DOMAIN_NAME', null, 1, sysdate, 'default', sysdate, 'default', 502, null, null, 6, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5014, '有效性', 'IS_VALID_NAME', null, 1, sysdate, 'default', sysdate, 'default', 502, null, null, 7, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5015, '作用范围', 'USE_SCOPE_NAME', null, 1, sysdate, 'default', sysdate, 'default', 502, null, null, 8, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5016, '创建日期', 'CREATE_DATE', null, 1, sysdate, 'default', sysdate, 'default', 502, null, null, 9, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5017, '创建人', 'CREATOR_ID', null, 1, sysdate, 'default', sysdate, 'default', 502, null, null, 10, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5018, '修改日期', 'MODIFY_DATE', null, 1, sysdate, 'default', sysdate, 'default', 502, null, null, 11, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5019, '修改人', 'MODIFIER_ID', null, 1, sysdate, 'default', sysdate, 'default', 502, null, null, 12, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (5020, '备注', 'NOTES', null, 1, sysdate, 'default', sysdate, 'default', 502, null, null, 13, null, 11, null, 1, null, null, null, null, null, null, null);



-- 更改菜单位置
-- 抓取系统日志
select * from tm_explorer where id = 1245;
select * from tm_gridpage where id = 605;
select * from tm_criteriastatement where id = 584;
select * from tm_entitytemplate where id = 589;
select * from tm_entitytemplate where id = 590;


-- 抓取系统详表
select * from tm_explorer where id = 1241;
select * from tm_gridpage where id = 601;
select * from tm_entitytemplate where id in(581,582);
select * from tm_criteriastatement where id = 583;
select * from tm_attributetemplate where id between 5799 and 5802;

--
--
--	imchk_100 数据库升级
--	隐藏新增按钮
update tm_coolbutton set visible=0, enable=0 where id = 76; 
--	抓取结果事件
insert into tm_coolaction (ID, NAME, CODE, VERSION, HANDLER, PARAMETER)
values (96, '同步场景信息', 'gripResult', 1, null, 'actionType:gripResult');
--	抓取结果按钮
insert into tm_coolbutton (ID, NAME, CODE, VERSION, ACTION_ID, SEPARATOR, ICON, TOOLBAR_ID, VISIBLE, ENABLE, ORDINAL, PARAMETER, TOOLTIP)
values (91, '抓取结果', 'gripResult', 1, 96, null, 'assets/images/queryView.png', 25, 1, 1, 4, null, null);
--  抓取配置详情(导航栏)
insert into tm_explorer (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, PARENTEXPLORER_ID, ORDINAL, GRIDPAGE_ID, EXPANDACTION_ID, PAGINATED, ICON, ENABLE)
values (283, '抓取配置详情', null, null, 1, sysdate, 'default', sysdate, 'default', 983, 6, 284, null, null, null, 1);
--	抓取配置详情(gridpage)
insert into tm_gridpage (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, CRITERIATEMPLATE_ID, CRITERIASTATEMENT_ID, RESULTTEMPLATE_ID, COOLBAR_ID, EXPORTCRITERIASTATEMENT_ID, STATISTICS, ASYNCHRONOUS, OTHERDATASOURCE, AUTOQUERY)
values (284, '抓取配置详情', null, null, 1, sysdate, 'default', sysdate, 'default', 328, 164, 329, null, null, null, null, null, null);
--	抓取配置详情(SQL语句)
insert into tm_criteriastatement (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, STATEMENTTYPE, CRITERIASTATEMENT, PREFEREDSTATEMENT, ROWMAPPERCLASS, SUFFIXSQLCRITERIA, DETAILTABLENAME)
values (164, '抓取配置详情', null, null, 1, sysdate, 'default', sysdate, 'default', 2, 'SELECT t1.ID,t2.NAME DOMAIN_NAME,t3.TYPE SYSTEM_NAME,t1.MONTH,t4.NAME SPEC_NAME,t1.ONEROW  FROM C_SYSTEM_RUNNER_DETAIL t1,MM_DOMAIN t2,TM_SYSTEM_RUNNER t3,TM_SPEC_MODEL t4 WHERE t1.DOMAIN_ID=t2.ID AND t1.SYSTEMRUNNER_ID=t3.ID AND t3.SPEC_ID=t4.ID
', null, null, null, null);
--	查询模板与结果模板
insert into tm_entitytemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ORDINAL, ENABLE)
values (328, '抓取配置详情查询', null, null, 1, sysdate, 'default', sysdate, 'default', 1, 1);
insert into tm_entitytemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ORDINAL, ENABLE)
values (329, '抓取详情结果', null, null, 1, sysdate, 'default', sysdate ,'default', 1, 1);
--	模板
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (3257, '省份', 'DOMAIN_NAME', null, 1, sysdate, sysdate, 'default', 329, null, null, 1, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (3258, '系统名', 'SYSTEM_NAME', null, 1, sysdate, 'default', sysdate, 'default', 329, null, null, 2, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (3259, '实体规格', 'SPEC_NAME', null, 1, sysdate, 'default', sysdate, 'default', 329, null, null, 3, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (3260, '时间(月)', 'MONTH', null, 1, sysdate, 'default', sysdate, 'default', 329, null, null, 4, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (3261, 'ONEROW', 'ONEROW', null, 1, sysdate, 'default', sysdate, 'default', 329, null, null, 5, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (3262, '省份', 't2.ID', null, 1, sysdate, 'default', sysdate, 'default', 328, null, null, 1, null, 23, null, 1, null, null, null, null, null, 'Domain', null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (3263, '系统名', 't3.TYPE', null, 1, sysdate, 'default', sysdate, 'default', 328, null, null, 2, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (3264, '实体规格', 't4.NAME', null, 1, sysdate, 'default', sysdate, 'default', 328, null, null, 3, null, 11, null, 1, null, null, null, null, null, null, null);
insert into tm_attributetemplate (ID, NAME, CODE, MEMO, VERSION, CREATEDATE, CREATOR, UPDATEDATE, UPDATER, ENTITYTEMPLATE_ID, DEFAULTVALUE, NOTNULL, ORDINAL, CRITERIASQL, DATATYPE, DICTIONARYTYPE_ID, VISIBLE, COLUMNWIDTH, STATISTICSCOLUMN, CALCEXPRESSION, PRECISEQUERY, GROUPBYCOLUMN, ENUMERABLEMODELNAME, GRIDPAGE_ID)
values (3265, '时间(月)', 'MONTH', null, 1, sysdate, 'default', sysdate, 'default', 328, null, null, 4, null, 11, null, 1, null, null, null, null, null, null, null);
--	添加序列
create sequence SEQ_C_SYSTEM_RUNNER_DETAIL
increment by 1
start with 1
maxvalue 999999999


DECLARE
  NAMES    VARCHAR(2000) := '会话ID,系统名,所属域,请求时间,状态,请求内容';
  CODES    VARCHAR(2000) := 'MSGID,RUNNERNAME,DOMAINNAME,REQYE,STATUS,REQUEST';
  TYPES    VARCHAR(2000) := '11,11,11,51,11,11';
  ENDINDEX NUMBER := 6;
  STRINDEX NUMBER := 1;
  NAME     VARCHAR(255);
  CODE     VARCHAR(255);
  CTYPE    VARCHAR(255);
  NAMEID   NUMBER;
  ENID     NUMBER := 590;
  GRID     NUMBER := 605;
  CREATOR  VARCHAR(255) := 'DEFAULT';
BEGIN
  LOOP
    SELECT REGEXP_SUBSTR(NAMES, '[^,]+', 1, STRINDEX) INTO NAME FROM DUAL;
    SELECT REGEXP_SUBSTR(CODES, '[^,]+', 1, STRINDEX) INTO CODE FROM DUAL;
    SELECT REGEXP_SUBSTR(TYPES, '[^,]+', 1, STRINDEX) INTO CTYPE FROM DUAL;
    NAMEID := SEQ_TM_ATTRIBUTETEMPLATE.NEXTVAL;
    INSERT INTO TM_ATTRIBUTETEMPLATE
      (ID,
       NAME,
       CODE,
       VRESION,
       CREATEDATE,
       CREATOR,
       UPDATEDATE,
       UPDATER,
       ENTITYTEMPLATE_ID,
       ORDINAL,
       DATATYPE,
       VISIBLE,
       GRIDPAGE_ID)
    VALUES
      (NAMEID,
       NAME,
       CODE,
       1,
       SYSDATE,
       CREATOR,
       SYSDATE,
       CREATOR,
       ENID,
       STRINDEX,
       TO_NUMBER(CTYPE),
       1,
       GRID);
    DBMS_OUTPUT.PUT_LINE('SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = ' ||
                         NAMEID || ';');
    STRINDEX := STRINDEX + 1;
    EXIT WHEN STRINDEX > ENDINDEX;
  END LOOP;
END;





