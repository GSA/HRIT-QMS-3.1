alter table aca.sec_user_org_role drop foreign key sec_user_org_role_fk2;
alter table aca.sec_user_org_role drop column org_id;
rename table aca.sec_user_org_role to aca.sec_user_role;

drop procedure aca.UpdateUser;

DELIMITER $$
CREATE procedure aca.UpdateUser(oldUserEmail varchar(100),newUserEmail varchar(100), newDisplayName varchar(100), newRoleId int, newOrgId int)
BEGIN

	Declare newUserId int;
   
    select user_id 
    into newUserId
    from aca.sec_user 
    where email_address = oldUserEmail;
    
	update aca.sec_user set
       orgId = newOrgId
      ,display_name = newDisplayName
      ,updated_at = now()
      ,email_address = newUserEmail
    where user_id = newUserId;
   
	update aca.sec_user_role set
		 role_id = newRoleId
        ,updated_at = now()
    where user_id = newUserId;
    
END$$
DELIMITER ;

drop FUNCTION aca.CreateUser;
DELIMITER $$
CREATE FUNCTION aca.CreateUser(userEmail varchar(100), userName varchar(100), roleId int, orgId int) RETURNS int(11)
BEGIN
	Declare userId int;
    
	insert into aca.sec_user (email_address, display_name, orgid, created_at) values (userEmail, userName, orgId, now());
   
    set userId = last_insert_id();
    
    insert into aca.sec_user_role (user_id, role_id, created_at) values (userId, roleId, now());
    
    return userId;
    
END$$
DELIMITER ;



