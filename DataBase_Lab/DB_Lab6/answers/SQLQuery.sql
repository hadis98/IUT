use AdventureWorks2012
go

----------soal1-----------
CREATE TABLE ProductLog(
	[ProductID] [int] ,
	[Name] [dbo].[Name] ,
	[ProductNumber] [nvarchar](25) ,
	[MakeFlag] [dbo].[Flag] ,
	[FinishedGoodsFlag] [dbo].[Flag] ,
	[Color] [nvarchar](15) NULL,
	[SafetyStockLevel] [smallint] ,
	[ReorderPoint] [smallint],
	[StandardCost] [money] ,
	[ListPrice] [money],
	[Size] [nvarchar](5),
	[SizeUnitMeasureCode] [nchar](3) NULL,
	[WeightUnitMeasureCode] [nchar](3) NULL,
	[Weight] [decimal](8, 2) NULL,
	[DaysToManufacture] [int],
	[ProductLine] [nchar](2) NULL,
	[Class] [nchar](2) NULL,
	[Style] [nchar](2) NULL,
	[ProductSubcategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime],
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	change varchar(10)
)


CREATE TABLE ProductTemp(
	[ProductID] [int] ,
	[Name] [dbo].[Name] ,
	[ProductNumber] [nvarchar](25) ,
	[MakeFlag] [dbo].[Flag] ,
	[FinishedGoodsFlag] [dbo].[Flag] ,
	[Color] [nvarchar](15) NULL,
	[SafetyStockLevel] [smallint] ,
	[ReorderPoint] [smallint],
	[StandardCost] [money] ,
	[ListPrice] [money],
	[Size] [nvarchar](5),
	[SizeUnitMeasureCode] [nchar](3) NULL,
	[WeightUnitMeasureCode] [nchar](3) NULL,
	[Weight] [decimal](8, 2) NULL,
	[DaysToManufacture] [int],
	[ProductLine] [nchar](2) NULL,
	[Class] [nchar](2) NULL,
	[Style] [nchar](2) NULL,
	[ProductSubcategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime],
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL
);

--drop TABLE ProductTemp;
insert into	ProductTemp
select * from Production.Product;

create trigger changes_trigger
on ProductTemp
after insert,delete ,update 
as
begin
declare @type varchar(10)
if exists(select * from inserted)
	if exists(select * from deleted)
		begin
		select @type = 'update';
		insert into ProductLog
		select ProductID,Name,ProductNumber,MakeFlag,FinishedGoodsFlag,Color,SafetyStockLevel,ReorderPoint,StandardCost,
		ListPrice,Size,SizeUnitMeasureCode,WeightUnitMeasureCode,Weight,DaysToManufacture,ProductLine,Class,Style,
		ProductSubcategoryID,ProductModelID,SellStartDate,SellEndDate,DiscontinuedDate,rowguid,ModifiedDate,@type
		from deleted
		end
	else
		begin
		select @type = 'insert';
		insert into ProductLog
		select ProductID,Name,ProductNumber,MakeFlag,FinishedGoodsFlag,Color,SafetyStockLevel,ReorderPoint,StandardCost,
		ListPrice,Size,SizeUnitMeasureCode,WeightUnitMeasureCode,Weight,DaysToManufacture,ProductLine,Class,Style,
		ProductSubcategoryID,ProductModelID,SellStartDate,SellEndDate,DiscontinuedDate,rowguid,ModifiedDate,@type
		from inserted
		end
else
	if exists (select * from deleted)
		begin
		select @type = 'delete'
		insert into ProductLog
		select ProductID,Name,ProductNumber,MakeFlag,FinishedGoodsFlag,Color,SafetyStockLevel,ReorderPoint,StandardCost,
		ListPrice,Size,SizeUnitMeasureCode,WeightUnitMeasureCode,Weight,DaysToManufacture,ProductLine,Class,Style,
		ProductSubcategoryID,ProductModelID,SellStartDate,SellEndDate,DiscontinuedDate,rowguid,ModifiedDate,@type
		from deleted
		end
	else
		begin
		select @type = 'unknown'
		end
end


select * from ProductTemp;

insert into ProductTemp 
values
(1400,'test','AR-6383',1,0,null,1000,750,0,0,null,null,null,null,
0,null,null,null,null,null,'2002-07-01',null,null,
'694215B7-08F7-4C0D-ACB1-D734BA44C0C8','2003-07-01');

delete from ProductTemp
where ProductID =320;

update ProductTemp
set MakeFlag =1
where ProductID =4;

select * from ProductLog;

---------------soal2------------------
drop table ProductLog2;
CREATE TABLE ProductLog2(
	[ProductID] [int] ,
	[Name] [dbo].[Name] ,
	[ProductNumber] [nvarchar](25) ,
	[MakeFlag] [dbo].[Flag] ,
	[FinishedGoodsFlag] [dbo].[Flag] ,
	[Color] [nvarchar](15) NULL,
	[SafetyStockLevel] [smallint] ,
	[ReorderPoint] [smallint],
	[StandardCost] [money] ,
	[ListPrice] [money],
	[Size] [nvarchar](5),
	[SizeUnitMeasureCode] [nchar](3) NULL,
	[WeightUnitMeasureCode] [nchar](3) NULL,
	[Weight] [decimal](8, 2) NULL,
	[DaysToManufacture] [int],
	[ProductLine] [nchar](2) NULL,
	[Class] [nchar](2) NULL,
	[Style] [nchar](2) NULL,
	[ProductSubcategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime],
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	change varchar(10)
);

insert into ProductLog2
select * from ProductLog;

select * from ProductLog2;


update ProductLog2
set Name ='test2'
where ProductID =1400;


update ProductLog2
set FinishedGoodsFlag =1
where ProductID =4;


--------------soal3-------------
CREATE TABLE ProductLog3(
	[ProductID] [int] ,
	[Name] [dbo].[Name] ,
	[ProductNumber] [nvarchar](25) ,
	[MakeFlag] [dbo].[Flag] ,
	[FinishedGoodsFlag] [dbo].[Flag] ,
	[Color] [nvarchar](15) NULL,
	[SafetyStockLevel] [smallint] ,
	[ReorderPoint] [smallint],
	[StandardCost] [money] ,
	[ListPrice] [money],
	[Size] [nvarchar](5),
	[SizeUnitMeasureCode] [nchar](3) NULL,
	[WeightUnitMeasureCode] [nchar](3) NULL,
	[Weight] [decimal](8, 2) NULL,
	[DaysToManufacture] [int],
	[ProductLine] [nchar](2) NULL,
	[Class] [nchar](2) NULL,
	[Style] [nchar](2) NULL,
	[ProductSubcategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime],
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	change varchar(10)
);

create procedure compareLogs
as 
begin
insert into ProductLog3
select * from ProductLog union  select * from ProductLog2
except
select * from ProductLog  intersect   select * from ProductLog2
end

execute compareLogs;
select * from ProductLog3;