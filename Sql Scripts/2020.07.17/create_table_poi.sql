create table aca.qms_personnel_office_identifier
(poi_Id int(4) primary key
,poi_code varchar(15) not null
,poi_label varchar(60) not null
,OrgID int(10) unsigned not null
,created_at datetime not null
,deleted_at datetime
);
ALTER TABLE aca.qms_personnel_office_identifier
ADD CONSTRAINT qms_poi_org_fk FOREIGN KEY (OrgID) REFERENCES aca.sec_org (org_id) ON DELETE CASCADE ON UPDATE CASCADE;

Insert into aca.qms_personnel_office_identifier (poi_id, poi_code, poi_label, created_at,OrgID) values (9999,'NO POI','MISSING POI',now(),4);
Insert into aca.qms_personnel_office_identifier (poi_id, poi_code, poi_label, created_at,OrgID) values (4177,'STAFF OFF','Staff Office Service Center',now(),6);
Insert into aca.qms_personnel_office_identifier (poi_id, poi_code, poi_label, created_at,OrgID) values (4174,'PBS SC','PBS Service Center',now(),7);
Insert into aca.qms_personnel_office_identifier (poi_id, poi_code, poi_label, created_at,OrgID) values (4019,'FAS SC','FAS Service Center',now(),8);
Insert into aca.qms_personnel_office_identifier (poi_id, poi_code, poi_label, created_at,OrgID) values (1909,'EXEC_RES','Executive Resources Services Center',now(),10);
Insert into aca.qms_personnel_office_identifier (poi_id, poi_code, poi_label, created_at,OrgID) values (4008,'CABS','CABS Service Center',now(),11);

update aca.qms_employee set PersonnelOfficeIdentifier = 9999 where emplid = '00000000';