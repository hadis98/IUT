SELECT 
  COUNT (*) OVER (PARTITION BY CustomerID) Voucher_Count,
  ROW_NUMBER () OVER (PARTITION BY CustomerID ORDER BY TrnDate, TrnTime) Counter,
  VoucherId,
  TrnDate,
  TrnTime,
  Amount,
  CustomerID
FROM Customer_trn
ORDER BY Voucher_Count DESC;

CREATE TABLE Customer_trn(
VoucherId varchar(21) NULL,
TrnDate date NULL,
TrnTime varchar(6) NULL,
Amount bigint NULL,
CustomerID int NULL
);

insert into Customer_trn
values
  ('1',CURRENT_DATE+1, '1', 100, 1),
  ('2',CURRENT_DATE-1, '1', 200, 1),
  ('3',CURRENT_DATE+2, '2', 140, 3),
  ('4',CURRENT_DATE, '2', 300, 2),
  ('5',CURRENT_DATE-1, '2', 50, 3),
  ('6',CURRENT_DATE, '1', 120, 1),
  ('7',CURRENT_DATE-3, '1', 300, 2),
  ('8',CURRENT_DATE, '3', 200, 2),
  ('9',CURRENT_DATE+2, '1', 140, 1);
  
select *
from Customer_trn
order by CustomerID, TrnDate, TrnTime;