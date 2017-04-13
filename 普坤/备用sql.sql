--模型驱动
SELECT * FROM TM_EXPLORER;  --导航栏
SELECT * FROM TM_GRIDPAGE;  --通用查询页面
SELECT * FROM TM_ENTITYTEMPLATE;  --实体模板
SELECT * FROM TM_CRITERIASTATEMENT;  --查询语句
SELECT * FROM TM_COOLBAR;  --工具栏
SELECT * FROM TM_COOLBUTTON ;  --按钮
SELECT * FROM TM_COOLACTION ;  --事件
SELECT * FROM TM_COOLPERSPECTIVE ;  --布局
SELECT * FROM TM_COOLVIEW ;  --试图
SELECT * FROM TM_ATTRIBUTETEMPLATE; --条件和结果

--指标KPI
select * from tm_indication;
--指标属性
select * from tm_indication_attr;
--指标范围
select * from tm_indication_spec;
--指标算法
select * from tm_procedure;
--指标与算法的关联
select * from tm_procedure_indication;
--指标输出表配置
select * from tm_indication_table;
--流程模板配置
select * from tm_flow_template;
--附表计划
select * from TM_SCHEDULE_PLAN;
--流程的启动ID和XMl文件
select t2.name_  关联code,t1.bytes_ from act_ge_bytearray t1,act_re_deployment t2 where t1.deployment_id_ = t2.id_;


-- 添加导航栏,通用查询,模板(不包含sql语句和toolaction)
declare
  exid  number;
  grid  number;
  crid  number;
  enstr number;
  enend number;
  exname varchar(255) := '页面抓取日志';
  creator varchar(255) := 'default';
  parentexplorer_id number := 983;
  ordinal number := 8;
begin
  exid  := seq_tm_explorer.nextval;
  grid  := seq_tm_gridpage.nextval;
  crid  := seq_tm_criteriastatement.nextval;
  enstr := seq_tm_entitytemplate.nextval;
  enend := seq_tm_entitytemplate.nextval;
  --添加导航栏
  insert into tm_explorer(id,name,version,createdate,creator,updatedate,updater,parentexplorer_id,ordinal,gridpage_id,enable)
  values (exid,exname,1,sysdate,creator,sysdate,creator,parentexplorer_id,ordinal,grid,1);
  --添加通用查询页面
  insert into tm_gridpage(id,name,version,createdate,creator,updatedate,updater,criteriatemplate_id,criteriastatement_id,resulttemplate_id)
  values (grid,exname,1,sysdate,creator,sysdate,creator,enstr,crid,enend);
  --添加查询模板
  insert into tm_criteriastatement(id,name,version,createdate,creator,updatedate,updater)
  values (crid,exname,1,sysdate,creator,sysdate,creator);
  --添加查询面板
  insert into tm_entitytemplate(id,name,createdate,creator,updatedate,updater,ordinal,enable)
  values (enstr,exname||'查询',sysdate,creator,sysdate,creator,1,1);
  --添加结果面板
  insert into tm_entitytemplate(id,name,createdate,creator,updatedate,updater,ordinal,enable)
  values (enend,exname||'结果',sysdate,creator,sysdate,creator,2,1);
  --输出包含id的查询语句
  dbms_output.put_line('select * from tm_explorer where id = '||exid||';');
  dbms_output.put_line('select * from tm_gridpage where id = '||grid||';');
  dbms_output.put_line('select * from tm_criteriastatement where id = '||crid||';');
  dbms_output.put_line('select * from tm_entitytemplate where id = '||enstr||';');
  dbms_output.put_line('select * from tm_entitytemplate where id = '||enend||';');
end;


DECLARE
  NAMES    VARCHAR(2000) := '会话ID,系统名,所属域,请求时间,状态,请求内容';
  CODES    VARCHAR(2000) := 'MSGID,RUNNERNAME,DOMAINNAME,REQYE,STATUS,REQUEST';
  TYPES    VARCHAR(2000) := '11,11,11,51,11,11';
  CREATOR  VARCHAR(255) := 'DEFAULT';
  ENID     NUMBER := 590;
  GRID     NUMBER := 605;
  ENDINDEX NUMBER := 6;
  STRINDEX NUMBER := 1;
  NAME     VARCHAR(255);
  CODE     VARCHAR(255);
  CTYPE    VARCHAR(255);
  NAMEID   NUMBER;
BEGIN
  LOOP
    SELECT REGEXP_SUBSTR(NAMES, '[^,]+', 1, STRINDEX) INTO NAME FROM DUAL;
    SELECT REGEXP_SUBSTR(CODES, '[^,]+', 1, STRINDEX) INTO CODE FROM DUAL;
    SELECT REGEXP_SUBSTR(TYPES, '[^,]+', 1, STRINDEX) INTO CTYPE FROM DUAL;
    NAMEID := SEQ_TM_ATTRIBUTETEMPLATE.NEXTVAL;
    INSERT INTO TM_ATTRIBUTETEMPLATE (ID,NAME,CODE,VERSION,CREATEDATE,CREATOR,UPDATEDATE,
       UPDATER,ENTITYTEMPLATE_ID,ORDINAL,DATATYPE,VISIBLE,GRIDPAGE_ID)
    VALUES(NAMEID,NAME,CODE,1, SYSDATE,CREATOR,SYSDATE,CREATOR,ENID,STRINDEX,
       TO_NUMBER(CTYPE),1,GRID);
    DBMS_OUTPUT.PUT_LINE('SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = ' ||
                         NAMEID || ';');
    STRINDEX := STRINDEX + 1;
    EXIT WHEN STRINDEX > ENDINDEX;
  END LOOP;
END;

-- 查询指标的完成情况
 SELECT T5.NAME 规格,
        T4.NAME 指标,
        T3.NAME 省,
        T2.FAIL + T2.SUCCESS 数据量,
        ROUND(TO_NUMBER(T1.UPDATEDATE - T1.CREATEDATE) * 24 * 60) 处理时间,
        T1.CREATEDATE 开始时间,
        T1.UPDATEDATE 结束时间
   FROM C_ZW_EXEC_LOG            T1,
        DGP_DATASTATISTICS_TOTAL T2,
        MM_DOMAIN                T3,
        TM_INDICATION            T4,
        MM_ENTITY_SPEC           T5
  WHERE T1.DOMAIN_ID = T2.DOMAIN_ID
    AND T1.SPEC_ID = T2.SPEC_ID
    AND T1.INDICATION_ID = T2.INDICATION_ID
    AND T1.DOMAIN_ID = T3.ID
    AND T1.INDICATION_ID = T4.ID
    AND T1.SPEC_ID = T5.ID
    AND T2.DATE_STR BETWEEN
        TO_DATE('2017-04-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND
        TO_DATE('2017-04-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
  ORDER BY 开始时间;
  
  
  -- 判断该规格的字段和元数据是否匹配
SET SERVEROUTPUT ON
DECLARE
  CURSOR YB IS(
    SELECT T1.*
      FROM MM_SPEC_ATTRIBUTE T1, MM_TABLE T2, MM_FIELD T3
     WHERE SPEC_ID = 3010100004
       AND T1.IS_VALID = 1001
       AND T1.TABLE_CODE = T2.CODE
       AND T2.ID = T3.TABLE_ID
       AND T3.CODE = T1.FIELD_CODE
       AND T2.IS_VALID = 1001
       AND T3.IS_VALID = 1001);
  TEMP   MM_SPEC_ATTRIBUTE%ROWTYPE;
  FIELDD VARCHAR(255);
  TABLED VARCHAR(255);
BEGIN
  OPEN YB;
  LOOP
    FETCH YB
      INTO TEMP;
    BEGIN
      FIELDD := TEMP.FIELD_CODE;
      TABLED := TEMP.TABLE_CODE;
      EXECUTE IMMEDIATE 'SELECT ' || TEMP.FIELD_CODE || ' FROM ' ||
                        TEMP.TABLE_CODE;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('TABLE_CODE:' || TABLED || 'FIELD_CODE:' || FIELDD || ';');
    END;
    EXIT WHEN YB%NOTFOUND;
  END LOOP;
  CLOSE YB;
  DBMS_OUTPUT.PUT_LINE('----------END------------');
END;
