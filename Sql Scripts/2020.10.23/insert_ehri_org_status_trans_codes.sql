drop FUNCTION if exists aca.getStatusTransCode;

DELIMITER $$
CREATE FUNCTION aca.getStatusTransCode(status_trans_code_descr varchar(100)) RETURNS int(10)
BEGIN
    declare id int default 0; 
    declare status_trans_found int;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
	  BEGIN
		set id = 4;
	  END;
		set status_trans_found = (select count(*) from aca.qms_status_trans where status_trans_code = status_trans_code_descr);
		if status_trans_found = 1 then
			set id = (select status_trans_id from aca.qms_status_trans where status_trans_code = status_trans_code_descr);
		else
			set id = -1;
		end if;
    return id;
END$$
DELIMITER ;


-- PPRM TO PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_PENDING_REVIEW'),4,8,now(),'EHRI'); -- ASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED'),4,8,now(),'EHRI'); -- ASSIGNED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED_ACTION_COMPLETED'),4,8,now(),'EHRI'); -- ASSIGNED_TO_CLOSED_ACTION_COMPLETED
-- insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),4,8,now(),'EHRI'); -- ASSIGNED_TO_CLOSED_CONVERTED_TO_CA

insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_CLOSED'),4,8,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_ASSIGNED'),4,8,now(),'EHRI'); -- PENDING_REVIEW_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_CLOSED_ACTION_COMPLETED'),4,8,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED_ACTION_COMPLETED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_RETURNED'),4,8,now(),'EHRI'); -- PENDING_REVIEW_TO_RETURNED

-- insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA'),4,8,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA

insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED_ACTION_COMPLETED'),4,8,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED_ACTION_COMPLETED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_ASSIGNED'),4,8,now(),'EHRI'); -- UNASSIGNED_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED'),4,8,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED
-- insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),4,8,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA

insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_CLOSE'),4,8,now(),'EHRI'); -- RETURNED_TO_CLOSE
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_PENDING_REVIEW'),4,8,now(),'EHRI'); -- RETURNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_CLOSED_CONVERTED_TO_CA'),4,8,now(),'EHRI'); -- RETURNED_TO_CLOSED_CONVERTED_TO_CA


/*
-- PPRM TO BRC
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_RETURNED'),4,9,now(),'EHRI'); -- ASSIGNED_TO_RETURNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_RETURNED'),4,9,now(),'EHRI'); -- PENDING_REVIEW_TO_RETURNED

-- PPRM TO SC
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_RETURNED'),4,10,now(),'EHRI'); -- ASSIGNED_TO_RETURNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_RETURNED'),4,10,now(),'EHRI'); -- PENDING_REVIEW_TO_RETURNED
*/	
	
-- BRC TO BRC    
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_ASSIGNED'),5,9,now(),'EHRI');	-- UNASSIGNED_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED'),5,9,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),5,9,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA

insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA'),5,9,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_ASSIGNED'),5,9,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_CLOSED'),5,9,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_RETURNED'),5,9,now(),'EHRI'); -- PENDING_REVIEW_TO_RETURNED



insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),5,9,now(),'EHRI'); -- ASSIGNED_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_PENDING_REVIEW'),5,9,now(),'EHRI'); -- ASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED'),5,9,now(),'EHRI'); -- ASSIGNED_TO_CLOSED

insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_CLOSE'),5,9,now(),'EHRI'); -- RETURNED_TO_CLOSE
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_PENDING_REVIEW'),5,9,now(),'EHRI'); -- RETURNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_CLOSED_CONVERTED_TO_CA'),5,9,now(),'EHRI'); -- RETURNED_TO_CLOSED_CONVERTED_TO_CA

/*
-- BRC TO PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_PENDING_REVIEW'),5,8,now(),'EHRI'); -- UNASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_UNASSIGNED'),5,8,now(),'EHRI'); -- ASSIGNED_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_ASSIGNED'),5,8,now(),'EHRI'); -- PENDING_REVIEW_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_UNASSIGNED'),5,8,now(),'EHRI'); -- PENDING_REVIEW_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_UNASSIGNED'),5,8,now(),'EHRI'); -- RETURNED_TO_UNASSIGNED

-- BRC FROM PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_RETURNED'),5,8,now(),'EHRI'); -- PENDING_REVIEW_TO_RETURNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_RETURN'),5,8,now(),'EHRI'); -- UNASSIGNED_TO_RETURN
*/




-- SC TO SC    
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_ASSIGNED'),6,10,now(),'EHRI');	-- UNASSIGNED_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED'),6,10,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),6,10,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA

insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA'),6,10,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_ASSIGNED'),6,10,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_CLOSED'),6,10,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_RETURNED'),6,10,now(),'EHRI'); -- PENDING_REVIEW_TO_RETURNED



insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),6,10,now(),'EHRI'); -- ASSIGNED_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_PENDING_REVIEW'),6,10,now(),'EHRI'); -- ASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED'),6,10,now(),'EHRI'); -- ASSIGNED_TO_CLOSED

insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_CLOSE'),6,10,now(),'EHRI'); -- RETURNED_TO_CLOSE
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_PENDING_REVIEW'),6,10,now(),'EHRI'); -- RETURNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_CLOSED_CONVERTED_TO_CA'),6,10,now(),'EHRI'); -- RETURNED_TO_CLOSED_CONVERTED_TO_CA




-- insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('REROUTED_TO_CLOSED'),6,10,now(),'EHRI'); -- REROUTED_TO_CLOSED


-- SC TO SC    
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_ASSIGNED'),7,10,now(),'EHRI');	-- UNASSIGNED_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED'),7,10,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_PENDING_REVIEW'),7,10,now(),'EHRI'); -- ASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED'),7,10,now(),'EHRI'); -- ASSIGNED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('REROUTED_TO_CLOSED'),7,10,now(),'EHRI'); -- REROUTED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_PENDING_REVIEW'),7,10,now(),'EHRI'); -- RETURNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_CLOSE'),7,10,now(),'EHRI'); -- RETURNED_TO_CLOSE
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),7,10,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),7,10,now(),'EHRI'); -- ASSIGNED_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA'),7,10,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA

-- SC TO SC    
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_ASSIGNED'),8,10,now(),'EHRI');	-- UNASSIGNED_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED'),8,10,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_PENDING_REVIEW'),8,10,now(),'EHRI'); -- ASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED'),8,10,now(),'EHRI'); -- ASSIGNED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('REROUTED_TO_CLOSED'),8,10,now(),'EHRI'); -- REROUTED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_PENDING_REVIEW'),8,10,now(),'EHRI'); -- RETURNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_CLOSE'),8,10,now(),'EHRI'); -- RETURNED_TO_CLOSE
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),8,10,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),8,10,now(),'EHRI'); -- ASSIGNED_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA'),8,10,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA


-- SC TO SC    
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_ASSIGNED'),9,10,now(),'EHRI');	-- UNASSIGNED_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED'),9,10,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_PENDING_REVIEW'),9,10,now(),'EHRI'); -- ASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED'),9,10,now(),'EHRI'); -- ASSIGNED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('REROUTED_TO_CLOSED'),9,10,now(),'EHRI'); -- REROUTED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_PENDING_REVIEW'),9,10,now(),'EHRI'); -- RETURNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_CLOSE'),9,10,now(),'EHRI'); -- RETURNED_TO_CLOSE
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),9,10,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),9,10,now(),'EHRI'); -- ASSIGNED_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA'),9,10,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA


-- SC TO SC    
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_ASSIGNED'),10,10,now(),'EHRI');	-- UNASSIGNED_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED'),10,10,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_PENDING_REVIEW'),10,10,now(),'EHRI'); -- ASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED'),10,10,now(),'EHRI'); -- ASSIGNED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('REROUTED_TO_CLOSED'),10,10,now(),'EHRI'); -- REROUTED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_PENDING_REVIEW'),10,10,now(),'EHRI'); -- RETURNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_CLOSE'),10,10,now(),'EHRI'); -- RETURNED_TO_CLOSE
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),10,10,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),10,10,now(),'EHRI'); -- ASSIGNED_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA'),10,10,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA


-- SC TO SC    
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_ASSIGNED'),11,10,now(),'EHRI');	-- UNASSIGNED_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED'),11,10,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_PENDING_REVIEW'),11,10,now(),'EHRI'); -- ASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED'),11,10,now(),'EHRI'); -- ASSIGNED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('REROUTED_TO_CLOSED'),11,10,now(),'EHRI'); -- REROUTED_TO_CLOSED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_PENDING_REVIEW'),11,10,now(),'EHRI'); -- RETURNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_CLOSE'),11,10,now(),'EHRI'); -- RETURNED_TO_CLOSE
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),11,10,now(),'EHRI'); -- UNASSIGNED_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_CLOSED_CONVERTED_TO_CA'),11,10,now(),'EHRI'); -- ASSIGNED_TO_CLOSED_CONVERTED_TO_CA
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA'),11,10,now(),'EHRI'); -- PENDING_REVIEW_TO_CLOSED_CONVERTED_TO_CA


/*
-- SC TO PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_PENDING_REVIEW'),6,8,now(),'EHRI'); -- UNASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_UNASSIGNED'),6,8,now(),'EHRI'); -- ASSIGNED_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_ASSIGNED'),6,8,now(),'EHRI'); -- PENDING_REVIEW_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_UNASSIGNED'),6,8,now(),'EHRI'); -- PENDING_REVIEW_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_UNASSIGNED'),6,8,now(),'EHRI'); -- RETURNED_TO_UNASSIGNED

-- SC FROM PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_RETURNED'),6,10,now(),'EHRI'); -- PENDING_REVIEW_TO_RETURNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_RETURN'),6,10,now(),'EHRI'); -- UNASSIGNED_TO_RETURN





-- SC TO PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_PENDING_REVIEW'),7,8,now(),'EHRI'); -- UNASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_UNASSIGNED'),7,8,now(),'EHRI'); -- ASSIGNED_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_ASSIGNED'),7,8,now(),'EHRI'); -- PENDING_REVIEW_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_UNASSIGNED'),7,8,now(),'EHRI'); -- PENDING_REVIEW_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_UNASSIGNED'),7,8,now(),'EHRI'); -- RETURNED_TO_UNASSIGNED

-- SC FROM PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_RETURNED'),7,10,now(),'EHRI'); -- PENDING_REVIEW_TO_RETURNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_RETURN'),7,10,now(),'EHRI'); -- UNASSIGNED_TO_RETURN






-- SC TO PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_PENDING_REVIEW'),8,8,now(),'EHRI'); -- UNASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_UNASSIGNED'),8,8,now(),'EHRI'); -- ASSIGNED_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_ASSIGNED'),8,8,now(),'EHRI'); -- PENDING_REVIEW_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_UNASSIGNED'),8,8,now(),'EHRI'); -- PENDING_REVIEW_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_UNASSIGNED'),8,8,now(),'EHRI'); -- RETURNED_TO_UNASSIGNED

-- SC FROM PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_RETURNED'),8,10,now(),'EHRI'); -- PENDING_REVIEW_TO_RETURNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_RETURN'),8,10,now(),'EHRI'); -- UNASSIGNED_TO_RETURN






-- SC TO PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_PENDING_REVIEW'),9,8,now(),'EHRI'); -- UNASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_UNASSIGNED'),9,8,now(),'EHRI'); -- ASSIGNED_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_ASSIGNED'),9,8,now(),'EHRI'); -- PENDING_REVIEW_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_UNASSIGNED'),9,8,now(),'EHRI'); -- PENDING_REVIEW_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_UNASSIGNED'),9,8,now(),'EHRI'); -- RETURNED_TO_UNASSIGNED

-- SC FROM PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_RETURNED'),9,10,now(),'EHRI'); -- PENDING_REVIEW_TO_RETURNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_RETURN'),9,10,now(),'EHRI'); -- UNASSIGNED_TO_RETURN






-- SC TO PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_PENDING_REVIEW'),10,8,now(),'EHRI'); -- UNASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_UNASSIGNED'),10,8,now(),'EHRI'); -- ASSIGNED_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_ASSIGNED'),10,8,now(),'EHRI'); -- PENDING_REVIEW_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_UNASSIGNED'),10,8,now(),'EHRI'); -- PENDING_REVIEW_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_UNASSIGNED'),10,8,now(),'EHRI'); -- RETURNED_TO_UNASSIGNED

-- SC FROM PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_RETURNED'),10,10,now(),'EHRI'); -- PENDING_REVIEW_TO_RETURNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_RETURN'),10,10,now(),'EHRI'); -- UNASSIGNED_TO_RETURN






-- SC TO PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_PENDING_REVIEW'),11,8,now(),'EHRI'); -- UNASSIGNED_TO_PENDING_REVIEW
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('ASSIGNED_TO_UNASSIGNED'),11,8,now(),'EHRI'); -- ASSIGNED_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_ASSIGNED'),11,8,now(),'EHRI'); -- PENDING_REVIEW_TO_ASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_UNASSIGNED'),11,8,now(),'EHRI'); -- PENDING_REVIEW_TO_UNASSIGNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('RETURNED_TO_UNASSIGNED'),11,8,now(),'EHRI'); -- RETURNED_TO_UNASSIGNED

-- SC FROM PPRM
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('PENDING_REVIEW_TO_RETURNED'),11,10,now(),'EHRI'); -- PENDING_REVIEW_TO_RETURNED
insert into aca.qms_org_status_trans (status_trans_id, from_org_id, to_orgtype_id,created_at, workitemtype_code) values (getStatusTransCode('UNASSIGNED_TO_RETURN'),11,10,now(),'EHRI'); -- UNASSIGNED_TO_RETURN
*/
