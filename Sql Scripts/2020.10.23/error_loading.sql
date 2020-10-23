drop function if exists  aca.getAssignToOrgId;
drop PROCEDURE if exists Update_qms_data_items;
drop PROCEDURE if exists aca.Update_master_error_list;
drop PROCEDURE if exists aca.Update_ehri_errors;
drop PROCEDURE if exists aca.updateAllErrorTables;
drop PROCEDURE if exists aca.updateErrorTables;
drop procedure if exists aca.Update_data_errors;
drop table if exists aca.qms_DataError;
drop table if exists aca.qms_master_error_list;
drop table if exists aca.qms_DataErrorType;
drop table if exists aca.qms_data_item;
drop table if exists aca.qms_ErrorRoutingType;


create table aca.qms_ErrorRoutingType
(errorRoutingType_Id int(10) auto_increment primary key
,errorRoutingType_Code varchar(25) not null
,errorRoutingType_Label varchar(35) not null
,created_at datetime not null
,updated_at datetime
,deleted_at datetime
) ENCRYPTION='Y';

insert into aca.qms_ErrorRoutingType(errorRoutingType_Code,errorRoutingType_Label, created_at) values ('UN', 'Undetermined',now());  -- 1
insert into aca.qms_ErrorRoutingType(errorRoutingType_Code,errorRoutingType_Label, created_at) values ('PPRM', 'Processing Center',now()); -- 2
insert into aca.qms_ErrorRoutingType(errorRoutingType_Code,errorRoutingType_Label, created_at) values ('SC', 'Service Center',now());  -- 3
insert into aca.qms_ErrorRoutingType(errorRoutingType_Code,errorRoutingType_Label, created_at) values ('BRC', 'Benefits and Retirements Center',now()); -- 4

create table aca.qms_DataErrorType
(dataRoutingType_Id int(10) auto_increment primary key
,dataRoutingType_Code varchar(25) not null
,dataRoutingType_Label varchar(25) not null
,created_at datetime not null
,updated_at datetime
,deleted_at datetime
) ENCRYPTION='Y';

insert into aca.qms_DataErrorType(dataRoutingType_Code,dataRoutingType_Label, created_at) values ('UN', 'Undetermined',now());  -- 1
insert into aca.qms_DataErrorType(dataRoutingType_Code,dataRoutingType_Label, created_at) values ('CA', 'Corrective Action',now()); -- 2
insert into aca.qms_DataErrorType(dataRoutingType_Code,dataRoutingType_Label, created_at) values ('PP', 'Person Profile',now());  -- 3

create table aca.qms_data_item
(data_item_Id int(10) primary key
,system_name varchar(25) not null
,data_item_name varchar(100) not null
,data_item_category varchar(25) not null
,created_at datetime not null
,updated_at datetime
,deleted_at datetime
) ENCRYPTION='Y';



create table aca.qms_master_error_list
(error_list_id int(10) primary key
,data_item_id int(10) not null
,qms_error_code varchar(25) not null
,hrdw_data_load_enabled char(1) not null
,qms_data_load_enabled char(1) not null default 'N'
,errorRoutingTypeId int(11) not null default 1
,dataRoutingTypeId int(11) not null default 1
,error_message_text text not null
,created_at datetime not null
,updated_at datetime
,deleted_at datetime
) ENCRYPTION='Y';
ALTER TABLE aca.qms_master_error_list
ADD CONSTRAINT qms_error_loader_master_ErrorRoutingType_fk FOREIGN KEY (errorRoutingTypeId) REFERENCES aca.qms_ErrorRoutingType (errorRoutingType_Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aca.qms_master_error_list
ADD CONSTRAINT qms_error_loader_master_DataErrorType_fk FOREIGN KEY (dataRoutingTypeId) REFERENCES aca.qms_DataErrorType (dataRoutingType_Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aca.qms_master_error_list
ADD CONSTRAINT qms_error_loader_master_DataItem_fk FOREIGN KEY (data_item_id) REFERENCES aca.qms_data_item (data_item_id) ON DELETE CASCADE ON UPDATE CASCADE;






create table aca.qms_DataError
(DataError_Id int(10)  auto_increment primary key
,DataError_Key varchar(20) not null
,error_list_id  int(10) not null
,emplid varchar(8) not null
,qms_error_code varchar(11) not null
,AssignedToUserID int(10) unsigned
,AssignedByUserId int(10) unsigned
,AssignedToOrgId int(10) unsigned 
,CreatedByUserId int(10) unsigned default 0
,CreatedByOrgId int(10) unsigned default 1 not null
,Assigned_at datetime
,Details varchar(4000) 
,StatusId int(10) unsigned default 1
,submitted_at datetime
,qms_error_message_text text
,correctiveActionId int(10)
,created_at datetime not null
,resolved_at datetime
,updated_at datetime
,deleted_at datetime
,RowVersion tinyint(2) default 1
);

ALTER TABLE aca.qms_DataError
ADD CONSTRAINT qms_DataError_employee_fk FOREIGN KEY (emplid) REFERENCES aca.qms_employee (emplid) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aca.qms_DataError
ADD CONSTRAINT qms_DataError_AssignedToUser_fk FOREIGN KEY (AssignedToUserID) REFERENCES aca.sec_user (user_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aca.qms_DataError
ADD CONSTRAINT qms_DataError_CreatedByUser_fk FOREIGN KEY (CreatedByUserId) REFERENCES aca.sec_user (user_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aca.qms_DataError
ADD CONSTRAINT qms_DataError_AssignedByUser_fk FOREIGN KEY (AssignedByUserId) REFERENCES aca.sec_user (user_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aca.qms_DataError
ADD CONSTRAINT qms_DataError_status_fk FOREIGN KEY (statusid) REFERENCES aca.qms_status (status_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aca.qms_DataError
ADD CONSTRAINT qms_DataError_car_fk FOREIGN KEY (CorrectiveActionId) REFERENCES aca.qms_correctiveactionrequest (Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aca.qms_DataError
ADD CONSTRAINT qms_DataError_errorlist_fk FOREIGN KEY (error_list_id) REFERENCES aca.qms_master_error_list (error_list_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aca.qms_DataError
ADD CONSTRAINT qms_DataError_AssignedToOrganization_fk FOREIGN KEY (AssignedToOrgId) REFERENCES aca.sec_org (org_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aca.qms_DataError
ADD CONSTRAINT qms_DataError_CreatedByOrganization_fk FOREIGN KEY (CreatedByOrgId) REFERENCES aca.sec_org (org_id) ON DELETE CASCADE ON UPDATE CASCADE;
CREATE INDEX qms_DataErrorKey_ix ON aca.qms_DataError (DataError_Key(20));





DELIMITER $$
CREATE FUNCTION aca.getAssignToOrgId(poi varchar(4), errorRoutingTypeId int) returns int
BEGIN
    declare org_id int default 4; -- default = PPRM
    declare org_found int;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
	  BEGIN
		set org_id = 4;
	  END;
    if errorRoutingTypeId = 2 then -- PPRM
		set org_id = 4;
    ELSEIF errorRoutingTypeId = 4 THEN -- BRC
		set org_id = 5;
    else -- Find the employees service center
		set org_found = (select count(*) from qms_personnel_office_identifier where poi_id = poi);
		if org_found = 1 then
			set org_id = (select orgid from qms_personnel_office_identifier where poi_id = poi);
		else
			set org_id = 4;
		end if;
	end if;
    return org_id;
END$$
DELIMITER ;





DELIMITER $$
CREATE PROCEDURE aca.Update_qms_data_items()
BEGIN
    declare finished integer default 0;
    declare records_inserted integer default 0;
    declare records_updated integer default 0;
	declare rec_count_match integer default 0;
    declare hrdw_data_item_id integer;
    declare hrdw_system_name varchar(25);
    declare hrdw_item_name varchar(100);
    declare hrdw_data_item_category varchar(25);  

	DECLARE cur_hrdw_data_items CURSOR FOR 
						select data_item_id
						  ,system_name
						  ,data_item_name
						  ,data_item_category
						from new_hrdw.nhrdw_data_item;
                        
	DECLARE CONTINUE HANDLER 
			FOR NOT FOUND SET finished = 1;   
   
		open cur_hrdw_data_items;
        
        getDataElements : LOOP
			FETCH cur_hrdw_data_items INTO hrdw_data_item_id, hrdw_system_name, hrdw_item_name, hrdw_data_item_category;
            if finished = 1 then 
				leave getDataElements;
            end if;
			set rec_count_match = (select count(*) from aca.qms_data_item where data_item_id = hrdw_data_item_id);
			IF rec_count_match = 1 THEN -- update existing record
				set records_updated = records_updated + 1;
				update aca.qms_data_item set 
					system_name = hrdw_system_name
				   ,data_item_name = hrdw_item_name
				   ,data_item_category = hrdw_data_item_category
				   ,updated_at = now()  
				where data_item_id = hrdw_data_item_id;
			ELSE -- insert new record
				set records_inserted = records_inserted + 1;
				insert into aca.qms_data_item (data_item_id, system_name, data_item_name, data_item_category, created_at) values (hrdw_data_item_id, hrdw_system_name, hrdw_item_name, hrdw_data_item_category, now());
			END IF;
		END LOOP getDataElements;
    CLOSE cur_hrdw_data_items;
    -- select concat(records_inserted, ' records inserted, ', records_updated, ' records updated');
END$$
DELIMITER ;




DELIMITER $$
CREATE PROCEDURE aca.Update_master_error_list()
BEGIN
    declare finished integer default 0;
    declare records_inserted integer default 0;
    declare records_updated integer default 0;
	declare rec_count_match integer default 0;
    declare hrdw_error_list_id integer;
    declare hrdw_data_item_id integer;
    declare hrdw_qms_error_code varchar(25);
    declare hrdw_error_message_text text;  
    declare hrdw_qms_data_load_enabled char(1);

	DECLARE cur_hrdw_data_items CURSOR FOR 
						select error_list_id 
                          ,data_item_id
						  ,QMS_ERROR_CODE
						  ,QMS_ERROR_MESSAGE_TEXT
						  ,ENABLE_QMS
						from new_hrdw.nhrdw_qms_master_error_list;
                        
	DECLARE CONTINUE HANDLER 
			FOR NOT FOUND SET finished = 1;   
   
		open cur_hrdw_data_items;
        
        getDataElements : LOOP
			FETCH cur_hrdw_data_items INTO hrdw_error_list_id, hrdw_data_item_id, hrdw_qms_error_code, hrdw_error_message_text,hrdw_qms_data_load_enabled;
            if finished = 1 then 
				leave getDataElements;
            end if;
            
			set rec_count_match = (select count(*) from aca.qms_master_error_list where qms_error_code = hrdw_qms_error_code);
			IF rec_count_match = 1 THEN -- update existing record
				set records_updated = records_updated + 1;
				update aca.qms_master_error_list set 
                    error_list_id = hrdw_error_list_id
			       ,data_item_id = hrdw_data_item_id
				   ,error_message_text = hrdw_error_message_text
                   ,hrdw_data_load_enabled = hrdw_qms_data_load_enabled
				   ,updated_at = now()  
				where error_list_id = hrdw_error_list_id;
			ELSE -- insert new record
				set records_inserted = records_inserted + 1;
				insert into aca.qms_master_error_list (error_list_id, data_item_id, qms_error_code, error_message_text, hrdw_data_load_enabled, created_at,errorRoutingTypeId,dataRoutingTypeId) 
                                       values (hrdw_error_list_id, hrdw_data_item_id, hrdw_qms_error_code, hrdw_error_message_text,hrdw_qms_data_load_enabled, now(), 1, 1);
			END IF;
		END LOOP getDataElements;
    CLOSE cur_hrdw_data_items;
   -- select concat(records_inserted, ' records inserted, ', records_updated, ' records updated');
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE aca.Update_data_errors()
BEGIN
    declare finished integer default 0;
    declare records_inserted integer default 0;
    declare records_closed integer default 0;
	declare rec_count_match integer default 0;
    
    declare hrdw_data_error_key varchar(20);
    declare hrdw_error_list_id integer;
    declare hrdw_emplid varchar(8);
    declare hrdw_qms_error_code varchar(11);
    declare hrdw_assigned_to_org_id integer;
    declare qms_error_message_text text;


	DECLARE cur_hrdw_data_errors CURSOR FOR 
				select concat(n.emplid, n.qms_error_code) AS dataError_Key
					  ,n.error_list_id
					  ,n.emplid
					  ,n.qms_error_code
					  ,aca.getAssignToOrgId(n.gvt_poi,e.errorRoutingTypeId) AssignedToOrgId
					  ,n.qms_error_message_text
				from new_hrdw.nhrdw_qms_empl_error_tracker_current_v n join aca.qms_master_error_list e on n.error_list_id = e.error_list_id and e.qms_data_load_enabled = 'Y'
				where n.business_unit = 'GSA01';
    
	DECLARE CONTINUE HANDLER 
			FOR NOT FOUND SET finished = 1;   
   
		open cur_hrdw_data_errors;
        
       
        getDataElements : LOOP
			FETCH cur_hrdw_data_errors INTO hrdw_data_error_key, hrdw_error_list_id, hrdw_emplid, hrdw_qms_error_code,hrdw_assigned_to_org_id,qms_error_message_text;
            if finished = 1 then 
				leave getDataElements;
            end if;
			set rec_count_match = (select count(*) from aca.qms_DataError where dataError_Key = hrdw_data_error_key and ((resolved_at > now() - 30) or resolved_at is null) and deleted_at is null);
			IF rec_count_match = 0 THEN -- create record
				set records_inserted = records_inserted + 1;
				insert into aca.qms_DataError (dataError_Key,error_list_id, emplid,qms_error_code,AssignedToOrgId,CreatedByOrgId,qms_error_message_text,created_at) 
                                       values (hrdw_data_error_key,hrdw_error_list_id,hrdw_emplid,hrdw_qms_error_code,hrdw_assigned_to_org_id,hrdw_assigned_to_org_id,qms_error_message_text,now());
            END IF;
				
		END LOOP getDataElements;
    CLOSE cur_hrdw_data_errors;

	update aca.qms_dataerror set
		   resolved_at = now() 
		  ,deleted_at = now()
		  ,statusid = 4
	where dataerror_key not in (select concat(n.emplid, n.qms_error_code) AS dataError_Key
								from new_hrdw.nhrdw_qms_empl_error_tracker_current_v n join aca.qms_master_error_list e on n.error_list_id = e.error_list_id and e.qms_data_load_enabled = 'Y'
							)
	  and resolved_at is null
	  and deleted_at is null;         
    
   -- select concat(records_inserted, ' records inserted, ', records_updated, ' records updated', records_closed, ' records closed');
END$$                 



DELIMITER $$
CREATE PROCEDURE aca.updateAllErrorTables()
BEGIN

 call aca.update_qms_Employee();

 call aca.Update_qms_data_items();

 call aca.Update_master_error_list();

 call aca.Update_data_errors();
END$$

grant execute on procedure aca.updateAllErrorTables to HRDWCORPDATA; 

-- SCHEDULE THIS IN CRON
-- call aca.updateAllErrorTables();