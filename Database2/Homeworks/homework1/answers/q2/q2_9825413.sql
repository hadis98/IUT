create table Trn_Des_Src (
VoucherId varchar(21) primary key,
TrnDate varchar(10),
TrnTime varchar(6),
Amount bigint,
SourceDep varchar,
DesDep varchar
);


insert into Trn_Des_Src values
(10,'2019-01-01','101000',1000,45,23),
(11,'2019-01-01','101000',1000,45,23),
(12,'2019-01-01','091000',200,345,NULL),
(14,'2019-01-02','080023',300,NULL,45),
(15,'2019-01-05','151201',700,438,259),
(16,'2019-01-05','151201',700,438,259),
(25,'2019-02-15','132022',1700,876,2000);


select *
from Trn_Des_Src
order by voucherid;

create or replace procedure mergeVoucher()
language plpgsql
as $$
begin
create table temp (
VoucherId varchar(21) primary key,
TrnDate varchar(10),
TrnTime varchar(6),
Amount bigint,
SourceDep varchar,
DesDep varchar
);

insert into temp
(
SELECT 
case 
when(min(VoucherId)<>max(VoucherId))
then (min(VoucherId)||'|'||max(VoucherId))
else
min(VoucherId)
end
,TrnDate,TrnTime,Amount,SourceDep,DesDep
FROM Trn_Des_Src
GROUP BY TrnDate,TrnTime,Amount,SourceDep,DesDep
);
truncate table Trn_Des_Src;
Insert Into Trn_des_Src
(
select *
from temp
);
drop table temp;
commit;
end;
$$;

call mergeVoucher();

select *
from Trn_Des_Src
order by voucherid;