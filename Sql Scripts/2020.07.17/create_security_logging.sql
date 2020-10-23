insert into aca.sec_user (user_id, email_address, display_name, orgid, created_at) values (0,'system.user@gsa.gov','System',1,now());
update aca.sec_user set 
 user_id = 0
where email_address = 'system.user@gsa.gov';

DROP TABLE aca.sec_SecurityLog;
drop table  aca.sec_SecurityLogType;
drop table aca.sec_SecurityItemType;

CREATE TABLE aca.sec_SecurityItemType (
  SecurityItemType_ID int(10) NOT NULL AUTO_INCREMENT,
  SecurityItemType_Code varchar(30) NOT NULL,
  SecurityItemType_Label varchar(80) NOT NULL,
  created_at datetime DEFAULT NULL,
  deleted_at datetime DEFAULT NULL,
  PRIMARY KEY (SecurityItemType_ID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ENCRYPTION='Y';

insert into aca.sec_SecurityItemType (SecurityItemType_Code,SecurityItemType_Label,created_at) values ('PERMISSION', 'Permission',now());  --  1
insert into aca.sec_SecurityItemType (SecurityItemType_Code,SecurityItemType_Label,created_at) values ('ROLE', 'Role',now());  -- 2
insert into aca.sec_SecurityItemType (SecurityItemType_Code,SecurityItemType_Label,created_at) values ('USER', 'User',now());  -- 3
insert into aca.sec_SecurityItemType (SecurityItemType_Code,SecurityItemType_Label,created_at) values ('ORGANIZATION', 'Organization',now());  -- 4


CREATE TABLE aca.sec_SecurityLogType (
  SecurityLogType_ID int(10) NOT NULL AUTO_INCREMENT,
  SecurityLogType_Code varchar(30) NOT NULL,
  SecurityLogType_Label varchar(80) NOT NULL,
  SecurityLogTemplate varchar(150) NOT NULL,
  SecurityItemType_ID int(10),
  created_at datetime DEFAULT NULL,
  deleted_at datetime DEFAULT NULL,
  PRIMARY KEY (SecurityLogType_ID),
  CONSTRAINT qms_SecurityLogType_SecurityItemType_fk FOREIGN KEY (SecurityItemType_ID) REFERENCES sec_SecurityItemType (SecurityItemType_ID) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ENCRYPTION='Y';

insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('PERM_CREATED','Permission Created',1,'Permission "{0}" Created',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('PERM_UPDATED','Permission Label Updated',1,'Permission Label "{0}" Updated to "{1}"',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('PERM_DEACTIVATED','Permission Deactivated',1,'Permission "{0}" Deactivated',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('PERM_REACTIVATED','Permission Reactivated',1,'Permission "{0}" Reactivated',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('PERM_ADDED_TO_ROLE','Permission Added to Role',1,'Permission "{0}" Added to Role "{1}"',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('PERM_REMOVED_FROM_ROLE','Permission Removed from Role',1,'Permission "{0}" Removed from Role "{1}"',now());

insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('ROLE_CREATED','Role Created',2,'Role "{0}" Created',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('ROLE_UPDATED','Role Label Updated',2,'Role Label "{0}" Updated to "{1}"',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('ROLE_DEACTIVATED','Role Deactivated',2,'Role "{0}" Deactivated',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('ROLE_REACTIVATED','Role Reactivated',2,'Role "{0}" Reactivated',now());

insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('USER_CREATED','User Created',3,'User "{0}" Created',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('USER_UPDATED','User Updated',3,'User "{0}" Updated',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('USER_DEACTIVATED','User Deactivated',3,'User "{0}" Deactivated',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('USER_REACTIVATED','User Reactivated',3,'User "{0}" Reactivated',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('USER_ASSIGNED_ROLE','Role Assigned to User',3,'User "{0}" Assigned Role "{1}"',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('USER_UNASSIGNED_ROLE','Role Removed from User',3,'User "{0}" Unassigned Role "{1}"',now());

insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('USER_LOGIN_SUCCESS','User Login Successful',3,'User "{0}" Logged in',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('USER_LOGIN_FAIL','User Login Failed',3,'User "{0}" Login Failed',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('USER_LOGIN_NAVIGATE','User Navigating Site',3,'User "{0}" Navigated Site',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('USER_LOGIN_NAVIGATE_TO_PAGE','User Navigating Site',3,'User "{0}" Navigated Page "{1}"',now());

insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('ORG_CREATED','Organization Created',4,'Organization "{0}" Created',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('ORG_UPDATED','Organization Updated',4,'Organization Label "{0}" Updated to "{1}"',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('ORG_DEACTIVATED','Organization Deactivated',4,'Organization "{0}" Deactivated',now());
insert into aca.sec_SecurityLogType (SecurityLogType_Code,SecurityLogType_Label,SecurityItemType_ID,SecurityLogTemplate,created_at) values ('ORG_REACTIVATED','Organization Reactivated',4,'Organization "{0}" Reactivated',now());


CREATE TABLE aca.sec_SecurityLog (
  SecurityLog_Id int(11) NOT NULL AUTO_INCREMENT,
  SecurityLogType_ID int (10) not null,
  ActionTakenByUserId int(11) unsigned NOT NULL,
  ActiontakenOnItemId int(10) not null,
  Description varchar(500) NOT NULL,
  created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (SecurityLog_Id)
)  ENCRYPTION='Y';

  alter table aca.sec_SecurityLog add
  CONSTRAINT sec_SecurityLog_SecurityLogType_fk FOREIGN KEY (SecurityLogType_ID) REFERENCES sec_SecurityLogType (SecurityLogType_ID);  
  alter table aca.sec_SecurityLog add
  CONSTRAINT sec_SecurityLog_User_fk FOREIGN KEY (ActionTakenByUserId) REFERENCES sec_user (User_id); 







