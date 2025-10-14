-- Create user

create USER "Omkar" IDENTIFIED BY "123456";

-- grand privlage

GRANT SELECT , update on emp to "Omkar";

-- REVOKE
REVOKE UPDATE on emp from "Omkar";

use data_db;

SELECT * from animelist LIMIT 10;

CREATE INDEX idx_my_status on animelist(my_status);
 
 SELECT * from animelist where my_status = 'Plan to Watch';


create index idx_dept on emp(department);

show indexes from emp;

drop index idx_dept on emp;

explain select * from emp where department = "Engineering";


create index index_name on emp(name);

show indexes from emp;

drop index index_name on emp;

explain select * from emp where name = "Simran Kaur";

explain select * from emp where age = 30;

#creating user

create user "saniya" identified by "12345";

#grant privilage

grant select, update on emp to "saniya";

revoke update on emp from "saniya";