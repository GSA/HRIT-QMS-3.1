alter table aca.qms_org_status_trans add 
	column (WorkItemType_Code varchar(50) default 'CorrectiveActionRequest' NOT NULL);
alter table aca.qms_org_status_trans add
	CONSTRAINT qms_org_status_trans_workItemType_fk FOREIGN KEY (WorkItemType_Code) REFERENCES qms_workitemtype (WorkItemType_Code) ON DELETE CASCADE ON UPDATE CASCADE;

drop VIEW aca.z_test_qms_status_transition_matrix;
CREATE VIEW aca.z_test_qms_status_transition_matrix AS 
select ost.org_status_trans_id AS org_status_trans_id
      ,ost.status_trans_id AS status_trans_id
      ,ost.from_org_id AS from_org_id
      ,ost.to_orgtype_id AS to_orgtype_id
      ,ost.created_at AS created_at
      ,ost.deleted_at AS deleted_at
      ,ost.updated_at AS updated_at
      ,st.FromStatusId AS FromStatusId
      ,st.ToStatusId AS ToStatusId
      ,st.FromStatus AS FromStatus
      ,st.ToStatus AS ToStatus
      ,o.org_code AS FromOrg
      ,ot.orgtype_code AS ToOrgType 
      ,ost.WorkItemType_Code 'WorkItemType'
from (((aca.qms_org_status_trans ost join (select st.status_trans_id AS status_trans_id
                                                       ,s.status_id AS FromStatusId
                                                       ,s.status_label AS FromStatus
                                                       ,s1.status_id AS ToStatusId 
                                                       ,s1.status_label AS ToStatus 
                                                 from ((aca.qms_status_trans st join aca.qms_status s on((s.status_id = st.from_status_id))) 
										   join aca.qms_status s1 on((s1.status_id = st.to_status_id)))) st on((st.status_trans_id = ost.status_trans_id))) 
										   join aca.sec_org o on((o.org_id = ost.from_org_id))) 
										   join aca.qms_orgtype ot on((ot.orgtype_id = ost.to_orgtype_id)));

insert into aca.qms_status (status_code, status_label, created_at) values ('CLOSED_CONVERT_TO_CORR_ACTION','Closed - Converted to Corrective Action',now());  -- 12

update aca.qms_status_trans set
  status_trans_code = 'UNASSIGNED_TO_CLOSED_ACTION_COMPLETED'
where status_trans_id = 58;

update aca.qms_status_trans set
  deleted_at = null
where status_trans_id = 27;

insert into aca.qms_status_trans (status_trans_code,status_trans_label,from_status_id, to_status_id,created_at) values ('PENDING_REVIEW_TO_CLOSED_ACTION_COMPLETED','Closed - Correction Completed',3,11,now()); -- 60
insert into aca.qms_status_trans (status_trans_code,status_trans_label,from_status_id, to_status_id,created_at) values ('UNASSIGNED_TO_PENDING_REVIEW','Submit for Resolution',1,3,now());  -- 61
-- insert into aca.qms_status_trans (status_trans_code,status_trans_label,from_status_id, to_status_id,created_at) values ('ASSIGNED_TO_CLOSED_ACTION_COMPLETED','Close - Action Completed',2,11,now()); -- 62

insert into aca.qms_status_trans (status_trans_code,status_trans_label,from_status_id, to_status_id,created_at) values ('UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA','Closed - Convert to Corrective Action',1,12,now()); -- 63
insert into aca.qms_status_trans (status_trans_code,status_trans_label,from_status_id, to_status_id,created_at) values ('ASSIGNED_TO_CLOSED_CONVERTED_TO_CA','Closed - Convert to Corrective Action',2,12,now()); -- 64
insert into aca.qms_status_trans (status_trans_code,status_trans_label,from_status_id, to_status_id,created_at) values ('PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA','Closed - Convert to Corrective Action',3,12,now()); -- 65
insert into aca.qms_status_trans (status_trans_code,status_trans_label,from_status_id, to_status_id,created_at) values ('RETURNED_TO_CLOSED_CONVERTED_TO_CA','Closed - Convert to Corrective Action',5,12,now()); -- 66

select * from qms_status_trans where status_trans_code = 'UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA';

ALTER TABLE aca.qms_org_status_trans drop foreign key qms_org_status_trans_fk1;
ALTER TABLE aca.qms_org_status_trans drop foreign key qms_org_status_trans_fk2;
ALTER TABLE aca.qms_org_status_trans drop foreign key qms_org_status_trans_workItemType_fk;

DROP INDEX qms_org_status_trans_uk1 ON aca.qms_org_status_trans;
CREATE UNIQUE INDEX qms_org_status_trans_status_wtk_idx  ON aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id, WorkItemType_Code);

ALTER TABLE aca.qms_org_status_trans add
  CONSTRAINT qms_org_status_trans_fk1 FOREIGN KEY (status_trans_id) REFERENCES qms_status_trans (status_trans_id);
ALTER TABLE aca.qms_org_status_trans add
  CONSTRAINT qms_org_status_trans_fk2 FOREIGN KEY (to_orgtype_id) REFERENCES qms_orgtype (orgtype_id);
ALTER TABLE aca.qms_org_status_trans add
  CONSTRAINT qms_org_status_trans_workItemType_fk FOREIGN KEY (WorkItemType_Code) REFERENCES qms_workitemtype (WorkItemType_Code);

-- 4	PPRM	8
-- 5	BRC	9
-- 6	SSOSC	10