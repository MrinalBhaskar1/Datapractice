/* =============================================================
DDL Script" Create Bronze Tables
================================================================
Script Purpose:
    This script creates tables in the bronze schema by dropping existing tables if there is any
    Run this script to re-define the DDL structure of the 'bronze' tables
================================================================
*/


use datawarehouse;

if object_id ('bronze.crm_cust_info','U') is not null
    drop table bronze.crm_cust_info;

create table bronze.crm_cust_info(
cst_id int,
cst_key nvarchar(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_marital_status nvarchar(50),
cst_gndr nvarchar(50),
cst_create_date date
);

if object_id ('bronze.crm_prd_info','U') is not null
    drop table bronze.crm_prd_info;
create table bronze.crm_prd_info(
prd_id int,
prd_key nvarchar(50),	
prd_nm nvarchar(50),	
prd_cost  int,	
prd_line nvarchar(50),	
prd_start_dt datetime,
prd_end_dt datetime
);

if object_id ('bronze.crm_sales_details','U') is not null
    drop table bronze.crm_sales_details;
create table bronze.crm_sales_details(
sls_ord_num	NVARCHAR(50),
sls_prd_key	NVARCHAR(50),
sls_cust_id NVARCHAR(50),
sls_order_dt NVARCHAR(50),
sls_ship_dt NVARCHAR(50),	
sls_due_dt NVARCHAR(50),	
sls_sales NVARCHAR(50),
sls_quantity NVARCHAR(50),	
sls_price NVARCHAR(50)
);

if object_id ('bronze.erp_loc_a101','U') is not null
    drop table bronze.erp_loc_a101;
Create table bronze.erp_loc_a101(
   cid nvarchar(50),
   cntry nvarchar(50)
);

if object_id ('bronze.erp_cust_az12','U') is not null
    drop table bronze.erp_cust_az12;
create table bronze.erp_cust_az12(
   CID nvarchar(50),
   BDATE nvarchar(50),
   GEN nvarchar(50)
);

if object_id ('bronze.erp_px_cat_g1v2','U') is not null
    drop table bronze.erp_px_cat_g1v2;
create table bronze.erp_px_cat_g1v2(
    ID nvarchar(50),
	CAT	nvarchar(50),
	SUBCAT nvarchar(50),
	MAINTENANCE nvarchar(50)
);

Create or Alter procedure bronze.bullk_load as 
begin
    declare @start_time_entire datetime, @start_time datetime, @end_time datetime,  @end_time_entire datetime;
    begin try
           set @start_time_entire = getdate();
           print '=================================';
           print 'loading bronze layer';
           print '=================================';
           
           print '---------------------------------'
           print 'loading crm tables'
           print '---------------------------------'
    
           set @start_time = getdate();
           print '>> Truncating table: bronze.crm_cust_info'
           truncate table bronze.crm_cust_info;
               
           print '>> bulk inserting into bronze.crm_cust_info'
           bulk insert bronze.crm_cust_info
           from 'C:\Users\Mrinal Bhaskar\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
           with (
              firstrow  =2,
              fieldterminator = ',',
              tablock
           );
           set @end_time = getdate();
           print '>> load duration :' + cast(datediff(second,@start_time, @end_time) as nvarchar(50)) + ' seconds';
           print '>> ---------------'

           print '>> Truncating table: bronze.crm_prd_info'
           truncate table bronze.crm_prd_info;
        
           set @start_time = getdate();
           print '>> bulk inserting into bbronze.crm_prd_info'
           bulk insert bronze.crm_prd_info
           from 'C:\Users\Mrinal Bhaskar\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
           with (
               firstrow  =2,
               fieldterminator = ',',
               tablock
           );
        
           set @end_time = getdate();
           print '>> load duration :' + cast(datediff(second,@start_time, @end_time) as nvarchar(50)) + ' seconds';
           print '>> ---------------'

           print '>> Truncating table: bronze.crm_sales_details'
           truncate table bronze.crm_sales_details;
    
           set @start_time = getdate();
           print '>> bulk inserting into bronze.crm_sales_details'
           bulk insert bronze.crm_sales_details
           from 'C:\Users\Mrinal Bhaskar\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
           with (
                firstrow  =2,
                fieldterminator = ',',
                tablock
            );
        
            set @end_time = getdate();
            print '>> load duration :' + cast(datediff(second,@start_time, @end_time) as nvarchar(50)) + ' seconds';
            print '>> ---------------'

            print '---------------------------'
            print 'loading erp tables'
            print '---------------------------'

            print '>> Truncating table: bronze.erp_CUST_AZ12'
            truncate table bronze.erp_CUST_AZ12;
        
            set @start_time = getdate();
            print '>> bulk inserting into bronze.erp_CUST_AZ12'
            bulk insert bronze.erp_CUST_AZ12
            from 'C:\Users\Mrinal Bhaskar\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
            with (
               firstrow  =2,
               fieldterminator = ',',
               tablock
            );
            set @end_time = getdate();
            print '>> load duration :' + cast(datediff(second,@start_time, @end_time) as nvarchar(50)) + ' seconds';
            print '>> ---------------'

            print '>> Truncating table: bronze.erp_LOC_A101'
            truncate table bronze.erp_LOC_A101;
        
            set @start_time = getdate();
            print '>> bulk inserting into bronze.erp_LOC_A101'
            bulk insert bronze.erp_LOC_A101
            from 'C:\Users\Mrinal Bhaskar\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
            with (
               firstrow  =2,
               fieldterminator = ',',
               tablock
            );
            set @end_time = getdate();
            print '>> load duration :' + cast(datediff(second,@start_time, @end_time) as nvarchar(50)) + ' seconds';
            print '>>---------------'

            print '>> Truncating table: bronze.erp_PX_CAT_G1V2'
            truncate table bronze.erp_PX_CAT_G1V2;
        
            set @start_time = getdate();
            print '>> bulk inserting into bronze.erp_PX_CAT_G1V2.csv'
            bulk insert bronze.erp_PX_CAT_G1V2
            from 'C:\Users\Mrinal Bhaskar\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
            with (
               firstrow  =2,
               fieldterminator = ',',
               tablock
            );
            set @end_time = getdate();
            print '>>---------------'
            print 'load duration :' + cast(datediff(second,@start_time, @end_time) as nvarchar(50)) + ' seconds';
            print '>>---------------'
            set @end_time_entire = getdate();
            print '>> total load duration :' + cast(datediff(second,@start_time_entire, @end_time_entire) as nvarchar(50)) + ' seconds';
            print '==============='
     end try
     begin catch
            print '============'
            print 'Error Occured during loading'
            print 'Error Message' + Error_message();
            print 'Error Message' + cast(Error_number() as nvarchar);
            print 'Error Message' + cast(Error_state() as nvarchar);
            print '============'
     end catch
  end

Select count(*) from bronze.crm_cust_info;

exec bronze.bullk_load
