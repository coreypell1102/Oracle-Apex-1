-- login as sysdba
sqlplus $ORACLE_USER/$ORACLE_PASSWORD as sysdba @apexins sysaux sysaux temp /i/

-- alter apex public user password
alter user apex_public_user identified by $APEX_PASSWORD account unlock;

-- Create APEX Instance Administrator
begin
    apex_util.set_security_group_id(p_security_group_id => 10);
    apex_util.create_user(
        p_user_name => 'ADMIN',
        p_email_address => 'oracle@localhost',
        p_web_password => 'admin',
        p_developer_privs => 'ADMIN' );
    apex_util.set_security_group_id(null);
    commit;
end;
/

-- Run APEX RESTful Services Configuration, and set password for APEX_REST_PUBLIC_USER and APEX_LISTENER
@apex_rest_config.sql $ORACLE_USER $ORACLE_PASSWORD

-- Create network ACL for APEX
delcare
    l_acl_path varchar2(4000);
    l_apex_schema varchar2(100);
begin
    for c1 in (select schema
               from sys.dba_registry
               where comp_id = 'APEX') loop
        l_apex_schema := c1.schema;
    end loop;
    sys.dbms_network_acl_admin.append_host_ace(
        host => '*',
        ace => xs$ace_type(privilege_list => xs$name_list('connect'),
                           principal_name => l_apex_schema,
                           principal_type => xs_acl.ptype_db));
    commit;
end;
/

-- Exit
exit;

