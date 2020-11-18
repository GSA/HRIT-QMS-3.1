alter table aca.qms_correctiveactionrequest modify createdat date;
alter table aca.qms_correctiveactionrequest modify updatedat date null;
alter table aca.qms_correctiveactionrequest modify resolvedat date null;
alter table aca.qms_correctiveactionrequest modify deletedat date null;
alter table aca.qms_correctiveactionrequest modify assignedat date null;

alter table aca.ntf_notification modify HasBeenRead tinyint(2);
alter table aca.ntf_notification modify SendAsEmail tinyint(2);