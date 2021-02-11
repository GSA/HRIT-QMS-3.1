use aca;
create view aca.qms_datametricsUserList as
select u.user_id
      ,u.display_name
      ,u.email_address
      ,u.created_at
      ,r.role_label
      ,o.org_label
from aca.sec_user u join aca.sec_user_role ur on u.user_id = ur.user_id
                    join aca.sec_role r on ur.role_id = r.role_id
                    join aca.sec_org o on u.orgid = o.org_id
where u.deleted_at is null
  and r.deleted_at is null
order by o.org_id, u.display_name;