select * from osnsv o
join 
(select 
Draft							
,DraftOsn						
,Workplace						
,OperationCode					
,Ksi								
,AmountEquipmentInWorkTogether	
,AmountEquipmentForOper   		
--,CorrectingCode					
,DateChangeTechnolog				
,AuthorTechnolog					
--,CorrectingDocument				
,IsHandOverDraft					
--,DateChangeTechnologBeforeCorr	
,AuthorConstructor				
,TechOrd							
,Note							
,Analogue						
,LaborManufacturingAssume		
from Osnastka.DraftOsnast d 
join Osnastka.TechOrder t on t.TechOrderID = d.TechOrderID) as tab
on tab.DraftOsn = o.draftosn and  tab.Draft = o.draft and tab.Workplace = o.rab_m and tab.OperationCode = o.kodop

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
--CorrectingCode					numeric(3,0) null,					--(kprt)						--код причины корректировки технолога
--DateChangeTechnolog				date null,							--(dizmt)
--AuthorTechnolog					varchar (20) null,					--(imyt)
--CorrectingDocument				varchar (20) null,					--(dokt)
IsHandOverDraft					bit null,							--(kl)							--null - неопределено, 0 со сдачей, 1 без сдачи
--DateChangeTechnologBeforeCorr	date null,							--(dizmk)
--AuthorConstructor				varchar(20) null,					--(imyk)
--TechOrd							smallint null default(0),			--(tzak)	
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
,Ksi							
,AmountEquipmentInWorkTogether
,AmountEquipmentForOper   	
,IsHandOverDraft				
,Note							
,Analogue						
,LaborManufacturingAssume						
)
select 
f1.draftid as DraftID	,
f2.draftid as OsnastkaID,
ob.rab_m as Workplace	,				
s.code as OperationCode,
cast(o.ksi as		smallint 	)				as Ksi														
,cast(o.klo as		numeric(2,0)) 				as AmountEquipmentInWorkTogether		  				
,cast(o.koltex as	smallint 	)				as AmountEquipmentForOper   								
,cast(o.kl as		bit 		)				as IsHandOverDraft											
,cast(o.prim as		varchar (50))				as Note														
,cast(o.prim_an as	varchar (20)) 				as Analogue													
,cast(o.trud as		numeric(7,2)) 				as LaborManufacturingAssume					
from osnsv o
join FullDraftList f1 on o.draft = f1.draft 
join FullDraftList f2 on o.draftosn = f2.draft
left join oborud ob on o.rab_m = ob.rab_m
left join s_oper s on o.kodop = s.code 

--конец