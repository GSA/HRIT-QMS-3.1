-- sec_permission
insert into aca.sec_permission (permission_code, permission_label, created_at) values ('CREATE_ROLE','Create Role',now());
insert into aca.sec_permission (permission_code, permission_label, created_at) values ('RETRIEVE_ROLE','Retrieve Role',now());
insert into aca.sec_permission (permission_code, permission_label, created_at) values ('UPDATE_ROLE','Update Role',now());
insert into aca.sec_permission (permission_code, permission_label, created_at) values ('CREATE_PERMISSION','Create Permission',now());
insert into aca.sec_permission (permission_code, permission_label, created_at) values ('RETRIEVE_PERMISSION','Retrieve Permission',now());
insert into aca.sec_permission (permission_code, permission_label, created_at) values ('UPDATE_PERMISSION','Update Permission',now());
insert into aca.sec_permission (permission_code, permission_label, created_at) values ('DEACTIVATE_ROLE','Deactivate Role',now());
insert into aca.sec_permission (permission_code, permission_label, created_at) values ('REACTIVATE_ROLE','Reactivate Role',now());
insert into aca.sec_permission (permission_code, permission_label, created_at) values ('DEACTIVATE_PERMISSION','Deactivate Permission',now());
insert into aca.sec_permission (permission_code, permission_label, created_at) values ('REACTIVATE_PERMISSION','Reactivate Permission',now());

-- sec_role_permission
insert into aca.sec_role_permission (role_id, permission_id, created_at) values (8,15,now());
insert into aca.sec_role_permission (role_id, permission_id, created_at) values (8,16,now());
insert into aca.sec_role_permission (role_id, permission_id, created_at) values (8,17,now());
insert into aca.sec_role_permission (role_id, permission_id, created_at) values (8,18,now());
insert into aca.sec_role_permission (role_id, permission_id, created_at) values (8,19,now());
insert into aca.sec_role_permission (role_id, permission_id, created_at) values (8,20,now());
insert into aca.sec_role_permission (role_id, permission_id, created_at) values (8,21,now());
insert into aca.sec_role_permission (role_id, permission_id, created_at) values (8,22,now());
insert into aca.sec_role_permission (role_id, permission_id, created_at) values (8,23,now());
insert into aca.sec_role_permission (role_id, permission_id, created_at) values (8,24,now());

-- sec_user_role
insert into aca.sec_user_role (user_id, role_id, created_at) values (1,8,now());
insert into aca.sec_user_role (user_id, role_id, created_at) values (140,8,now());
