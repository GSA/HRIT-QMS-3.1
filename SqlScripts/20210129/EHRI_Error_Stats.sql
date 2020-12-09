-- build reports to store daily error counts for statistical analysis

drop table aca.qms_error_stat;
create table aca.qms_error_stat
(qms_error_stat int(10) not null auto_increment primary key
,poid varchar(4) not null
,error_code varchar(30) not null
,snapshot_date date not null
,error_count int(10) not null
) encryption="Y";

create index qms_error_status on qms_error_stat(poid, error_code, snapshot_date);

drop procedure if exists aca.Update_qms_data_error_stats;
DELIMITER $$
create procedure aca.Update_qms_data_error_stats()
BEGIN
insert into aca.qms_error_stat (poid, error_code, snapshot_date, error_count)
select gvt_poi poid
      ,qms_error_code error_code
      ,snapshot_date
      ,count(*) error_count
from new_hrdw.nhrdw_qms_empl_error_tracker_current_v
group by gvt_poi, qms_error_code, snapshot_date;
END$$
DELIMITER ;

drop procedure if exists aca.updateAllErrorTables;
DELIMITER $$
CREATE procedure aca.updateAllErrorTables()
BEGIN
 call aca.update_qms_Employee();
 call aca.Update_qms_data_items();
 call aca.Update_master_error_list();
 call aca.Update_data_errors();
 call aca.Update_qms_data_error_stats();
END$$
DELIMITER ;
