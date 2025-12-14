-- DCL Data Control Language
-- Create User

CREATE USER 'Omkar'@'Localhost' IDENTIFIED by '123123';

CREATE USER 'Light'@'Localhost' IDENTIFIED BY '123123';

-- GRANT Permissions

GRANT SELECT,INSERT on data.* To 'Omkar'@'Localhost';

GRANT ALL PRIVILEGES ON timedb.employees to 'Omkar'@'Localhost';

GRANT ALL PRIVILEGES ON *.* To 'Light'@'Localhost';

-- REVOKE

REVOKE INSERT on data.* FROM 'Omkar'@'Localhost';

-- DROP
DROP USER 'Omkar'@'Localhost';
DROP USER 'Light'@'Localhost';