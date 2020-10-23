

-- All
insert into aca.sys_menuitem (module_id, display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (3,1,'MI_VDELL','All Errors',aca.getPermissionId('VIEW_ALL_EHRI_ERRORS'),'DataErrors','Index','VDEALL',now());
insert into aca.sys_menuitem (module_id, display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (3,2,'MI_VADELL','All Archived Errors',aca.getPermissionId('VIEW_ALL_ARCHIVED_EHRI_ERRORS'),'DataErrors','Index','VADEALL',now());

-- Org
insert into aca.sys_menuitem (module_id, display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (3,3,'MI_VDEFO','My Center\'s Errors ',aca.getPermissionId('VIEW_EHRI_ERRORS_FOR_ORG'),'DataErrors','Index','VDEFO',now());
insert into aca.sys_menuitem (module_id, display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (3,4,'MI_VADEFO','My Center\'s Archived Errors',aca.getPermissionId('VIEW_ARCHIVED_EHRI_ERRORS_FOR_ORG'),'DataErrors','Index','VADEFO',now());

-- User
insert into aca.sys_menuitem (module_id, display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (3,5,'MI_VDEFU','My Assigned Errors',aca.getPermissionId('VIEW_EHRI_ERRORS_FOR_USER'),'DataErrors','Index','VDEFU',now());
insert into aca.sys_menuitem (module_id, display_order, menuitem_code,menuitem_label, permission_id, controller_name, action_name,query_string, created_at) 
values (3,6,'MI_VADEFU','My Archived Assigned Errors',aca.getPermissionId('VIEW_ARCHIVED_EHRI_ERRORS_FOR_USER'),'DataErrors','Index','VADEFU',now());