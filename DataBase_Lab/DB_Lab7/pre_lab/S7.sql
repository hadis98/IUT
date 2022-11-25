--C:\Users\moham\Desktop\sql

--bulk insert dbo.[User]
--from 'C:\Users\moham\Desktop\sql\bulk.txt'
--with
--(
--	fieldterminator = ','
--)


--select * 
--from openrowset('Microsoft.ACE.OLEDB.12.0','C:\Users\moham\Desktop\sql\import.accdb';'admin';'','select Username from Users')

--exec xp_cmdshell 'bcp AdventureWorks2012.Production.Product out C:\Users\moham\Desktop\sql\product.txt -T -c -t;'
--exec xp_cmdshell 'bcp AdventureWorks2012.Production.ProductNew in C:\Users\moham\Desktop\sql\product.txt -T -c -t;'

exec xp_cmdshell 'bcp "select Name, Demographics.query(''declare default element namespace \"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey\";for $x in /StoreSurvey return <result> {$x/Brands}</result>'') as Brand from AdventureWorks2012.Sales.Store" queryout C:\Users\moham\Desktop\sql\xml.txt -T -c -q -t;'