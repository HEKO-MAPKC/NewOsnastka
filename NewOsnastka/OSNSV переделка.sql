--TODO коды корректировок и kl
--начало
--НАЧАЛО ТУТ
drop table [Osnastka].OsnastUseListJournal
drop table [Osnastka].OsnastUseList
drop table #osnsv1
create table #osnsv1
(
osnsv1ID						int not null identity(1,1),
draft							numeric(13,2) not null,
draftosn						numeric(13,2) not null,
rab_m						numeric (3,0) null,					--(rab_m)						--внешний ключ
kodop					numeric (4,0) not null,					--(kodop + kpodrt)				--внешний ключ
ksi								smallint null,						--(ksi)							--нужен ли вообще numeric или smallint
klo				numeric(2,0) null,   				--(klo)							-- Количество одновременно обрабатываемых деталей
koltex   		smallint null,						--(koltex)						--решить с типом, в оригинале был (4,1), нужен ли вообще numeric или smallint
kprk					numeric(3,0) null,				--(kprt)						--код причины корректировки технолога
dizmt				date null,						--(dizmt)
imyt					varchar (20) null,				--(imyt)
dokt				varchar (20) null,				--(dokt)
kl					bit null,							--(kl)							--null - неопределено, 0 со сдачей, 1 без сдачи
dizmk				date null,							--(dizmk)
imyk				varchar(20) null,					--(imyk)	
prim							varchar (50) null,					--(prim)
prim_an						varchar (20) null,					--(prim_an)	
trud		numeric(7,2) null default(0),	--(trud)
Constraint PK_osnsvID1	primary key(osnsv1ID)
)
insert into #osnsv1(
draft	
,draftosn
,rab_m	
,kodop	
,ksi		
,klo		
,koltex  
,kprk	
,dizmt	
,imyt	
,dokt	
,kl		
,dizmk	
,imyk	
,prim	
,prim_an	
,trud						
)
select 
draft	
,draftosn
,rab_m	
,kodop	
,ksi		
,klo		
,koltex  
,kprk	
,dizmt	
,imyt	
,dokt	
,kl		
,dizmk	
,imyk	
,prim	
,prim_an	
,trud			
from osnsv o
create table [Osnastka].OsnastUseList
(
OsnastUseListID				int not null identity(1,1),
DraftID							int not null,
OsnastID						int not null,
Workplace						numeric (3,0) null,					--(rab_m)						--внешний ключ
OperationCode					numeric (4,0) null,					--(kodop + kpodrt)				--внешний ключ

Ksi								smallint null,						--(ksi)							--нужен ли вообще numeric или smallint
AmountEquipmentInWorkTogether	numeric(2,0) null,   				--(klo)							-- Количество одновременно обрабатываемых деталей
AmountEquipmentForOper   		smallint null,						--(koltex)						--решить с типом, в оригинале был (4,1), нужен ли вообще numeric или smallint
--CorrectingCode					numeric(3,0) null,				--(kprt)						--код причины корректировки технолога
--DateChangeTechnolog				date null,						--(dizmt)
--AuthorTechnolog					varchar (20) null,				--(imyt)
--CorrectingDocument				varchar (20) null,				--(dokt)
IsHandOverDraft					bit null,							--(kl)							--null - неопределено, 0 со сдачей, 1 без сдачи
--DateChangeTechnologBeforeCorr	date null,							--(dizmk)
--AuthorConstructor				varchar(20) null,					--(imyk)
--TechOrd							smallint null default(0),		--(tzak)	
Note							varchar (50) null,					--(prim)
Analogue						varchar (20) null,					--(prim_an)	
LaborManufacturingAssume		numeric(7,2) null default(0),	--(trud)
OldOsnsvID						int not null,

Constraint FK_DraftID_DraftID_OsnastUseList									foreign key(DraftID)			references DraftInfoFull (DraftID), 
Constraint FK_OsnastkaID_DraftID_OsnastUseList								foreign key(OsnastID)			references DraftInfoFull (DraftID), 
						
Constraint FK_Workplace_oborud_OsnastUseList									foreign key(Workplace)			references oborud (rab_m), 
Constraint FK_OperationCode_s_oper_OsnastUseList								foreign key(OperationCode)		references s_oper (code), 
Constraint PK_OsnastUseListID	primary key(OsnastUseListID)
)
insert into [Osnastka].OsnastUseList(
DraftID,
OsnastID,
Workplace,				
OperationCode
,Ksi							
,AmountEquipmentInWorkTogether
,AmountEquipmentForOper   	
,IsHandOverDraft				
,Note							
,Analogue						
,LaborManufacturingAssume	
,OldOsnsvID					
)
select 
f1.draftid as DraftID	,
f2.draftid as OsnastID,
ob.rab_m as Workplace	,				
s.code as OperationCode,
cast(o.ksi as		smallint 	)				as Ksi														
,cast(o.klo as		numeric(2,0)) 				as AmountEquipmentInWorkTogether		  				
,cast(o.koltex as	smallint 	)				as AmountEquipmentForOper   								
,cast(o.kl as		bit 		)				as IsHandOverDraft											
,cast(o.prim as		varchar (50))				as Note														
,cast(o.prim_an as	varchar (20)) 				as Analogue													
,cast(o.trud as		numeric(7,2)) 				as LaborManufacturingAssume		
,o.osnsv1ID										as OldOsnsvID			
from #osnsv1 o
join DraftInfoFull f1 on o.draft = f1.draft 
join DraftInfoFull f2 on o.draftosn = f2.draft
left join oborud ob on o.rab_m = ob.rab_m
left join s_oper s on o.kodop = s.code 
--журнал
create table [Osnastka].OsnastUseListJournal --TODO поменять местами кто на что ссылается, -- не надо
(
OsnastUseListJournalID		int not null identity(1,1),
OsnastUseListID				int			 not null,
AuthorChange				varchar(20) null,					--(imyk)
DateChange date null,
TypeChange varchar (20) null,	
DraftID							int not null,
OsnastID						int not null,
Workplace						numeric (3,0) null,					--(rab_m)						--внешний ключ
OperationCode					numeric (4,0) null,					--(kodop + kpodrt)				--внешний ключ

Ksi								smallint null,						--(ksi)							--нужен ли вообще numeric или smallint
AmountEquipmentInWorkTogether	numeric(2,0) null,   				--(klo)							-- Количество одновременно обрабатываемых деталей
AmountEquipmentForOper   		smallint null,						--(koltex)						--решить с типом, в оригинале был (4,1), нужен ли вообще numeric или smallint
--CorrectingCode					numeric(3,0) null,				--(kprt)						--код причины корректировки технолога
--DateChangeTechnolog				date null,						--(dizmt)
--AuthorTechnolog					varchar (20) null,				--(imyt)
--CorrectingDocument				varchar (20) null,				--(dokt)
IsHandOverDraft					bit null,							--(kl)							--null - неопределено, 0 со сдачей, 1 без сдачи
--DateChangeTechnologBeforeCorr	date null,							--(dizmk)
--AuthorConstructor				varchar(20) null,					--(imyk)	
Note							varchar (50) null,					--(prim)
Analogue						varchar (20) null,					--(prim_an)	
LaborManufacturingAssume		numeric(7,2) null,	--(trud)					
Constraint FK_OsnastUseListID_OsnastUseListJournal_OsnastUseList									foreign key(OsnastUseListID)			references [Osnastka].OsnastUseList (OsnastUseListID), 
Constraint PK_OsnastUseListJournalID	primary key(OsnastUseListJournalID)
)
--при создании строчки
insert into [Osnastka].OsnastUseListJournal(
OsnastUseListID	
,AuthorChange
,DateChange
,TypeChange				
--,CorrectingCode					
--,DateChangeTechnolog				
--,AuthorTechnolog					
--,CorrectingDocument				
--,DateChangeTechnologBeforeCorr	
--,AuthorConstructor
		
,draftID
,OsnastID
,Workplace				
,OperationCode
,Ksi							
,AmountEquipmentInWorkTogether
,AmountEquipmentForOper   	
,IsHandOverDraft				
,Note							
,Analogue						
,LaborManufacturingAssume			
)
select 
o2.OsnastUseListID as OsnastUseListID	
,cast (imyk	as varchar(20)) as AuthorChange							--(imyk)				
,cast (dizmk as date) as		DateChange							--(dizmk)
,cast ('create'	as varchar (20)) as TypeChange							--(dokt)
,f1.draftid as DraftID	
,f2.draftid as OsnastID
,o.rab_m as Workplace					
,o.kodop as OperationCode
,cast(o.ksi as		smallint 	)				as Ksi														
,cast(o.klo as		numeric(2,0)) 				as AmountEquipmentInWorkTogether		  				
,cast(o.koltex as	smallint 	)				as AmountEquipmentForOper   								
,cast(o.kl as		bit 		)				as IsHandOverDraft											
,cast(o.prim as		varchar (50))				as Note														
,cast(o.prim_an as	varchar (20)) 				as Analogue													
,cast(o.trud as		numeric(7,2)) 				as LaborManufacturingAssume		
from #osnsv1 o
join [Osnastka].OsnastUseList o2 on o.osnsv1ID = o2.OldOsnsvID 
join DraftInfoFull f1 on o.draft = f1.draft 
join DraftInfoFull f2 on o.draftosn = f2.draft
order by OsnastUseListID
--изменения
insert into [Osnastka].OsnastUseListJournal(
OsnastUseListID	
,AuthorChange
,DateChange
,TypeChange			
--,CorrectingCode					
--,DateChangeTechnolog				
--,AuthorTechnolog					
--,CorrectingDocument				
--,DateChangeTechnologBeforeCorr	
--,AuthorConstructor
		
,draftID
,OsnastID
,Workplace				
,OperationCode
,Ksi							
,AmountEquipmentInWorkTogether
,AmountEquipmentForOper   	
,IsHandOverDraft				
,Note							
,Analogue						
,LaborManufacturingAssume			
)
select 
o2.OsnastUseListID as OsnastUseListID	
,cast (imyt	as varchar(20)) as AuthorChange							--(imyk)				
,cast (dizmt as date) as		DateChange				--(dizmk)
,cast (dokt	as varchar (20)) as TypeChange							--(dokt)

,f1.draftid as DraftID	
,f2.draftid as OsnastID
,o.rab_m as Workplace					
,o.kodop as OperationCode
,cast(o.ksi as		smallint 	)				as Ksi														
,cast(o.klo as		numeric(2,0)) 				as AmountEquipmentInWorkTogether		  				
,cast(o.koltex as	smallint 	)				as AmountEquipmentForOper   								
,cast(o.kl as		bit 		)				as IsHandOverDraft											
,cast(o.prim as		varchar (50))				as Note														
,cast(o.prim_an as	varchar (20)) 				as Analogue													
,cast(o.trud as		numeric(7,2)) 				as LaborManufacturingAssume		
from #osnsv1 o
join [Osnastka].OsnastUseList o2 on o.osnsv1ID = o2.OldOsnsvID 
join DraftInfoFull f1 on o.draft = f1.draft 
join DraftInfoFull f2 on o.draftosn = f2.draft
order by OsnastUseListID
--конец

--select * from Osnastka.OsnastUseListJournal
--select * from Osnastka.OsnastUseList
--select * from Osnsv