DROP TABLE aca.ui_menu_builder;
DROP TABLE aca.ui_menuitem;

-- DROP FUNCTION aca.getPermissionId;
DELIMITER $$
CREATE FUNCTION aca.getPermissionId(perm_code varchar(100)) RETURNS int
BEGIN
    declare perm_id int default 0;
    declare permission_found int;
	set permission_found = (select count(*) from aca.sec_permission where permission_code = perm_code);
	if permission_found = 1 then
		set perm_id = (select permission_id from aca.sec_permission where permission_code = perm_code);
	else
		set perm_id = 0;
	end if;
    return perm_id;
END;
$$
DELIMITER ;


-- DROP TABLE aca.sys_module;
CREATE TABLE aca.sys_module(
	 module_id int(10) primary key AUTO_INCREMENT
	,module_code varchar(50) not null 
	,module_label varchar(100) not null
	,controller_name varchar(100) NOT NULL
	,action_name varchar(100) NOT NULL
	,query_string varchar(100)
	,display_order tinyint(3) NOT NULL
	,created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
	,updated_at datetime DEFAULT NULL
	,deleted_at datetime DEFAULT NULL
);

insert into aca.sys_module (module_code,module_label,controller_name,action_name,display_order) values ('ADMIN','System Administration','UserAdmin','Index',99); -- 1
insert into aca.sys_module (module_code,module_label,controller_name,action_name,display_order) values ('CORRECTIVE_ACTION','Corrective Actions','CorrectiveAction','Index',1); -- 2
insert into aca.sys_module (module_code,module_label,controller_name,action_name,display_order,deleted_at) values ('EHRI','EHRI/Data Errors','DataErrors','Index',2,now()); -- 3


-- DROP TABLE aca.sys_module_role;
create table aca.sys_module_role (
 	 module_role_id int(10) primary key AUTO_INCREMENT
	,module_id int(10) not null
	,role_id int(10) unsigned not null
	,created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
	,updated_at datetime DEFAULT NULL
	,deleted_at datetime DEFAULT NULL
) ENCRYPTION='Y';
ALTER TABLE aca.sys_module_role
ADD CONSTRAINT qms_module_moduleid_fk FOREIGN KEY (module_id) REFERENCES aca.sys_module (module_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aca.sys_module_role
ADD CONSTRAINT qms_module_roleid_fk FOREIGN KEY (role_id) REFERENCES aca.sec_role (role_id) ON DELETE CASCADE ON UPDATE CASCADE;

insert into aca.sys_module_role (module_id,role_id) values (1,8);  -- sysadmin



insert into aca.sys_module_role (module_id,role_id) values (2,1);  -- CA / SC Specialist
insert into aca.sys_module_role (module_id,role_id) values (2,2);  -- CA / SC Reviewer
insert into aca.sys_module_role (module_id,role_id) values (2,3);  -- CA / PPRM Reviewer
insert into aca.sys_module_role (module_id,role_id) values (2,4);  -- CA / PPRM Specialist
insert into aca.sys_module_role (module_id,role_id) values (2,5);  -- CA / BRC Specialist
insert into aca.sys_module_role (module_id,role_id) values (2,6);  -- CA / BRC Reviewer
insert into aca.sys_module_role (module_id,role_id) values (2,7);  -- CA / CA Viewer

insert into aca.sys_module_role (module_id,role_id) values (3,1);  -- EHRI / SC Specialist
insert into aca.sys_module_role (module_id,role_id) values (3,2);  -- EHRI / SC Reviewer
insert into aca.sys_module_role (module_id,role_id) values (3,3);  -- EHRI / PPRM Reviewer
insert into aca.sys_module_role (module_id,role_id) values (3,4);  -- EHRI / PPRM Specialist
insert into aca.sys_module_role (module_id,role_id) values (3,5);  -- EHRI / BRC Specialist
insert into aca.sys_module_role (module_id,role_id) values (3,6);  -- EHRI / BRC Reviewer
insert into aca.sys_module_role (module_id,role_id) values (3,7);  -- EHRI / CA Viewer

-- DROP TABLE aca.sys_menuitem;
CREATE TABLE aca.sys_menuitem (
	 menuitem_id int(10) primary key AUTO_INCREMENT
	,module_id int(10) not null
	,menuitem_code varchar(100) NOT NULL
	,menuitem_label varchar(100) NOT NULL
	,permission_id int(10) unsigned unique
	,controller_name varchar(100) NOT NULL
	,action_name varchar(100) NOT NULL
	,query_string varchar(100)
	,display_order tinyint(3) NOT NULL
	,icon_on varchar(255)
	,icon_off varchar(255)
	,created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
	,updated_at datetime DEFAULT NULL
	,deleted_at datetime DEFAULT NULL
) ENCRYPTION='Y';
ALTER TABLE aca.sys_menuitem
ADD CONSTRAINT qms_menuitem_permission_fk FOREIGN KEY (permission_id) REFERENCES aca.sec_permission (permission_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aca.sys_menuitem
ADD CONSTRAINT qms_menuitem_module_fk FOREIGN KEY (module_id) REFERENCES aca.sys_module (module_id) ON DELETE CASCADE ON UPDATE CASCADE;



insert into aca.sys_menuitem (module_id,display_order,menuitem_code, menuitem_label, permission_id, controller_name, action_name, created_at) 
values (1,1,'USER_ADM','User Admin',aca.getPermissionId('RETRIEVE_USER'),'User2','Index',now());
insert into aca.sys_menuitem (module_id,display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name, created_at) 
values (1,2,'ROLE_ADM','Role Admin',aca.getPermissionId('RETRIEVE_ROLE'),'Role','Index',now());
insert into aca.sys_menuitem (module_id,display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name, created_at) 
values (1,3,'PERM_ADM','Permission Admin',aca.getPermissionId('RETRIEVE_PERMISSION'),'Permission','Index',now());

-- Create
insert into aca.sys_menuitem (module_id, display_order,menuitem_code, menuitem_label, permission_id, controller_name, action_name, created_at) 
values (2,1,'MI_CREATE_CA','Create Corrective Action',aca.getPermissionId('CREATE_CORRECTIVE_ACTION'),'CorrectiveActions','Create',now());

-- All
insert into aca.sys_menuitem (module_id, display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (2,2,'MI_VCALL','All Corrective Actions',aca.getPermissionId('VIEW_ALL_CORRECTIVE_ACTION_LIST'),'CorrectiveActions','Index','VCAALL',now());
insert into aca.sys_menuitem (module_id, display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (2,3,'MI_VACALL','All Archived Corrective Action',aca.getPermissionId('VIEW_ALL_ARCHIVED_CORRECTIVE_ACTIONS'),'CorrectiveActions','Index','VACAALL',now());

-- Org
insert into aca.sys_menuitem (module_id, display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (2,4,'MI_VCAFO','My Center\'s Actions ',aca.getPermissionId('VIEW_CORRECTIVE_ACTIONS_FOR_ORG'),'CorrectiveActions','Index','VCAFO',now());
insert into aca.sys_menuitem (module_id, display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (2,5,'MI_VACAFO','My Center\'s Archived Actions',aca.getPermissionId('VIEW_ARCHIVED_CORRECTIVE_ACTIONS_FOR_ORG'),'Corrective Actions','Index','VACAFO',now());

-- User
insert into aca.sys_menuitem (module_id, display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (2,6,'MI_VCAFU','My Corrective Actions',aca.getPermissionId('VIEW_CORRECTIVE_ACTIONS_FOR_USER'),'CorrectiveActions','Index','VCAFU',now());
insert into aca.sys_menuitem (module_id, display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (2,7,'MI_VACAFU','My Archived Actions',aca.getPermissionId('VIEW_ARCHIVED_CORRECTIVE_ACTIONS_FOR_USER'),'CorrectiveActions','Index','VACAFU',now());

-- POID
insert into aca.sys_menuitem (module_id, display_order,menuitem_code, menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (2,8,'MI_VCAFP','Employees We Service',aca.getPermissionId('VIEW_CORRECTIVE_ACTIONS_FOR_POID'),'CorrectiveActions','Index','VCAFP',now());
insert into aca.sys_menuitem (module_id, display_order,menuitem_code, menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (2,9,'MI_VACAFP','Employees We Service Archive',aca.getPermissionId('VIEW_ARCHIVED_CORRECTIVE_ACTIONS_FOR_POID'),'CorrectiveActions','Index','VACAFP',now());


