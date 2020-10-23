use aca;
insert into aca.sec_org (org_id, parent_org_id, org_code, org_label, created_at, orgtype_id) values (10,3,'ERSC','Executive Resources Service Center',now(),10);
insert into aca.sec_org (org_id, parent_org_id, org_code, org_label, created_at, orgtype_id) values (11,3,'CABS','Commissions and Boards',now(),10);

insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (28,10,8, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (29,10,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (31,10,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (35,10,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (36,10,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (37,10,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (38,10,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (39,10,8, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (42,10,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (44,10,8, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (47,10,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (49,10,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (50,10,8, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (28,11,8, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (29,11,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (31,11,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (35,11,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (36,11,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (37,11,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (38,11,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (39,11,8, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (42,11,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (44,11,8, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (47,11,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (49,11,10, now());
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, created_at) values (50,11,8, now());

CREATE TABLE aca.sec_userlogin (
  Id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY
 ,emailaddress varchar(255) not null
 ,login_event_type varchar(10) not null
 ,created_at datetime NOT NULL
);


ALTER TABLE aca.qms_correctiveactionrequest
MODIFY COLUMN CreatedAtOrgId int(10) unsigned;

ALTER TABLE aca.qms_correctiveactionrequest
ADD CONSTRAINT qms_correctiveactionrequest_createdatorg_fk FOREIGN KEY (CreatedAtOrgId) REFERENCES sec_org (org_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- ************************************************
-- ************************************************
--
-- Above run in prod on 3/10/2020 per RITM0711155 
-- 
-- ************************************************
-- ************************************************


update aca.sec_org set
  org_code = 'BRC'
 ,org_label = 'Benefits and Retiremements Center'
where org_id = 5;
