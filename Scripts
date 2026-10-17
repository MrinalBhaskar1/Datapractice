/* Creating Database and Schemas

Script Purpose:
    the script creates a new database named 'datawarehouse after checking if
    it exists or not. If database exists then it is dropped to create a new one.

    And then three schemas are created: 'bronze', 'gold', 'silver'

Warning: Running script will drop  the entire 'DataWarehouse' database if it exists.
All data in the database can be destroyed
*/
USE MASTER;
go
-- drop existing DataWarehouse project
if exists (select 1 from sys.databases where name = 'DataWarehouse')
Begin
      Alter database datawarehouse set single_user with rollback immediate;
      drop database datawarehouse;
End;
go

--create a new database DataWarehouse
CREATE DATABASE DataWarehouse;
go
--using created database DataWarehouse
Use DataWarehouse;
go
--creating 3 Schemas
Create Schema bronze;
go
Create Schema silver;
go
Create Schema gold;
go
