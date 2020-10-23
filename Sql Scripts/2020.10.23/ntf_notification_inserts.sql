insert into aca.ntf_notificationevent(notificationevent_code, notificationevent_label,notificationeventtype_id,messagetemplate, titletemplate,createdat) 
                              values ('EHRI_Closed','EHRI Error Closed',1,'EHRI Error ID: {0}<br/>Updated on: {1}<br/>Employee: {2}-{3}','HRQMS - EHRI Error Closed ({0})',now());
insert into aca.ntf_notificationevent(notificationevent_code, notificationevent_label,notificationeventtype_id,messagetemplate, titletemplate,createdat) 
                              values ('EHRI_Returned','EHRI Error Returned',1,'EHRI Error ID: {0}<br/>Updated on: {1}<br/>Employee: {2}-{3}','HRQMS - EHRI Error Returned ({0})',now());     
insert into aca.ntf_notificationevent(notificationevent_code, notificationevent_label,notificationeventtype_id,messagetemplate, titletemplate,createdat) 
                              values ('EHRI_Submitted','EHRI Error Submitted',2,'EHRI Error ID: {0}<br/>Updated on: {1}<br/>Employee: {2}-{3}','HRQMS - EHRI Error Submitted ({0})',now());                                   
insert into aca.ntf_notificationevent(notificationevent_code, notificationevent_label,notificationeventtype_id,messagetemplate, titletemplate,createdat) 
                              values ('EHRI_PendingReview','EHRI Error Pending Review',2,'EHRI Error ID: {0}<br/>Updated on: {1}<br/>Employee: {2}-{3}','HRQMS - EHRI Error Pending Review ({0})',now());                               
insert into aca.ntf_notificationevent(notificationevent_code, notificationevent_label,notificationeventtype_id,messagetemplate, titletemplate,createdat) 
                              values ('EHRI_Assigned','EHRI Error Assigned',1,'EHRI Error ID: {0}<br/>Updated on: {1}<br/>Employee: {2}-{3}','HRQMS - EHRI Error Assigned ({0})',now());                                      