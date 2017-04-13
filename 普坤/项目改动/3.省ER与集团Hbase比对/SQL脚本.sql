
--省ER与集团hbase数据属性比对详表 1021 1101
select * from tm_explorer where id = 1382;
select * from tm_gridpage where id = 722;
select * from tm_criteriastatement where id = 722;
select * from tm_entitytemplate where id = 743;
select * from tm_entitytemplate where id = 744;

SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11467;
SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11468;
SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11469;
SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11470;
SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11471;
SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11472;
SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11473;
-- 查询语句
SELECT *
  FROM (SELECT T2.NAME     DOMAIN_NAME,
               T1.BATCH_NO BATCH_NO,
               T1.DATE_STR DATE_STR,
               T1.MESSAGE  MESSAGE,
               T1.GID      GID,
               T1.ROWKEY   ROWKEY,
               T3.NAME     SPEC_NAME,
               T3.ID       SPEC_ID,
               T2.ID       DOMAIN_ID
          FROM TB_DATASTATISTICS_COUNT T1, MM_DOMAIN T2, MM_ENTITY_SPEC T3
         WHERE T1.DOMAIN_ID = T2.ID
           AND T1.SPEC_ID = T3.ID)
 WHERE 1 = 1
 
 
 
 --省ER与集团hbase数据比对详表 1022 1102
select * from tm_explorer where id = 1383;
select * from tm_gridpage where id = 723;
select * from tm_criteriastatement where id = 723;
select * from tm_entitytemplate where id = 745;
select * from tm_entitytemplate where id = 746;

SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11474;
SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11475;
SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11476;
SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11477;
SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11478;
SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11479;
SELECT * FROM TM_ATTRIBUTETEMPLATE WHERE ID = 11480;

SELECT *
  FROM (SELECT T2.NAME     DOMAIN_NAME,
               T1.BATCH_NO BATCH_NO,
               T1.DATE_STR DATE_STR,
               T1.MESSAGE  MESSAGE,
               T1.GID      GID,
               T1.ROWKEY   ROWKEY,
               T3.NAME     SPEC_NAME,
               T3.ID       SPEC_ID,
               T2.ID       DOMAIN_ID
          FROM TB_DATASTATISTICS_ATTR T1, MM_DOMAIN T2, MM_ENTITY_SPEC T3
         WHERE T1.DOMAIN_ID = T2.ID
           AND T1.SPEC_ID = T3.ID)
 WHERE 1 = 1
 
 
 
 