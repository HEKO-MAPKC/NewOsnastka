;with query1 as 
(
SELECT  distinct
	  --[draft]
   --   ,[rab_m]
   --   ,[kpodrt]
   --   ,[kodop]
   --   ,[ksi]
   --   ,[klo]
   --   ,[klg]
   --   ,[naimosn]
   --   ,[koltex]
   --   ,[kprt]
   --   ,[dizmt]
   --   ,[imyt]
   --   ,[dokt]
   --   ,[datakntr] 
   --   ,[kl]
   --   ,[kprk]
   --   ,[dizmk]
   --   ,[imyk]
   --   ,[dokk]
   --   ,[tzak]
   --   ,[tf]
   --   ,[ru]
   --   ,[prim_an]
   --   ,[prim]
   --   ,[trud]
   --   ,[gruz]
   --,count (ksi) as ct
      [draft]
  FROM [FOX].[dbo].[osnsv] group by draft,   [kodop] --order by draftosn
  )
  select draft, count(*) from query1 group by draft order by draft

  select * from osnsv where draftosn = 81133507000.40

  443317 - всего
  443117 - distinct
  433924 - без draftosn


  SELECT *
  FROM Osnastka.TechOrder z 
   join Osnastka.DraftOsnast d on d.TechOrderID = z.TechOrderID 
   where z.draft = 90304165045.00
   order by DraftOsn 

SELECT *
FROM [FOX].[dbo].[osnsv] o
where o.draft = 90304165045.00
   order by DraftOsn 

     SELECT *
  FROM Osnastka.TechOrder z 
   join Osnastka.DraftOsnast d on d.TechOrderID = z.TechOrderID 
   join osnsv o on o.draftosn = d.DraftOsn and o.draft = z.Draft and o.tzak = z.techord
   
alter table [osnsv] add osnsvID INT IDENTITY

select * from zayvka a 
join zayvka b on a.draft = b.draft and a.draftosn = b.draftosn and a.dza <> b.dza where a.draftosn <> 0

select * from osnsv
zakaz,nom,zak_1,datat
select distinct zak_1,count(*) from pl_zak_t group by zak_1 order by count(*)
select distinct zakaz,nom,count(*) from pl_zak_t group by zakaz,nom order by count(*)

select * from osnsv

--начало
--НАЧАЛО ТУТ
drop table [Osnastka].OsnastkaByDraftList
create table [Osnastka].OsnastkaByDraftList
(
OsnastkaByDraftID				int not null identity(1,1),
DraftID							int not null,
OsnastkaID						int not null,
Workplace						numeric (3,0) null,					--(rab_m)						--внешний ключ
OperationCode					numeric (4,0) null,					--(kodop + kpodrt)				--внешний ключ
Ksi								smallint null,						--(ksi)							--нужен ли вообще numeric или smallint
AmountEquipmentInWorkTogether	numeric(2,0) null,   				--(klo)							-- Количество одновременно обрабатываемых деталей
AmountEquipmentForOper   		smallint null,						--(koltex)						--решить с типом, в оригинале был (4,1), нужен ли вообще numeric или smallint
CorrectingCode					numeric(3,0) null,					--(kprt)						--код причины корректировки технолога
DateChangeTechnolog				date null,							--(dizmt)
AuthorTechnolog					varchar (20) null,					--(imyt)
CorrectingDocument				varchar (20) null,					--(dokt)
IsHandOverDraft					bit null,							--(kl)							--null - неопределено, 0 со сдачей, 1 без сдачи
DateChangeTechnologBeforeCorr	date null,							--(dizmk)
AuthorConstructor				varchar(20) null,					--(imyk)
TechOrd							smallint null default(0),			--(tzak)	
Note							varchar (50) null,					--(prim)
Analogue						varchar (20) null,					--(prim_an)	
LaborManufacturingAssume		numeric(7,2) not null default(0),	--(trud)						
Constraint FK_Workplace_oborud_OsnastkaByDraft									foreign key(Workplace)			references oborud (rab_m), 
Constraint FK_OperationCode_s_oper_OsnastkaByDraft								foreign key(OperationCode)		references s_oper (code), 
Constraint PK_OsnastkaByDraftID	primary key(OsnastkaByDraftID)
)
insert into [Osnastka].OsnastkaByDraftList(
DraftID,
OsnastkaID,
Workplace,				
OperationCode				
)
select 
f1.draftid as DraftID	,
f2.draftid as OsnastkaID,
o.rab_m as Workplace	,				
o.kodop as OperationCode							
from osnsv o
join FullDraftList f1 on o.draft = f1.draft 
join FullDraftList f2 on o.draftosn = f2.draft

select * from FullDraftList
select * from osnsv