ALTER USER sys IDENTIFIED BY "1wcsites2";
CREATE USER csdb IDENTIFIED BY "1wcsites2" DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp;
GRANT CONNECT, CREATE session, CREATE table, CREATE view TO csdb;
GRANT UNLIMITED TABLESPACE to csdb;
COMMIT;