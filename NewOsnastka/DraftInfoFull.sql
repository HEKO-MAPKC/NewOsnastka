  /*
  ��� �������

  0 - ������������
	0.1 - ��������� ������ � ReferenceCode (3) � ������������� ������
	0.2 - ��������� ������������ � ReferenceInformation � ����� 3 (��� ������� ������������ ����� � ������ ReferenceCodeID\ReferenceName)
	0.3 - FullDraftList (1 - ��, 2 - ������, 3 - ReferenceInformationID)
  1 - listdse ��������� ��� ������� ������������
  2 - �������� ������ �������� � ������������������ (complect\ocomplect\prodact\osnsv\pomoika\zayvka\proos) 
  3 - ����������� ������������ �� (listdse\olistdse\list_fr\ �� �c����� �� m_cennik \prodact\osnsv\pomoika\zayvka ) 
  4 - ���� ���������� ����� ������ (������ �� �������� �� listdse\olistdse\list_fr\prodact\osnsv\pomoika\zayvka)    
	4.1 - ��������� ��� ������� � ������ ������, ���� �� �������, �� 4.2
	4.2 - ���� ��� �������� ������ � listdse -> 
									 olistdse -> 
									 list_fr -> 
									 �� ������� � m_cennik (������ ��� COMPLECT \ OCOMPLECT) � � ���� ������������� ���������� � ������ ������.
									 ����� ������������ �� ������� ������� (��� prodact\osnsv\pomoika\zayvka\proos) 
		  ���� �� �������, �� 4.3
	4.3 - ���� ����� �� �������, �� ("��� ������������")
  */

  --������ ������ ���
insert into ReferenceCode values ('������������ �������')
  --��������� ����
drop table FullDraftNameList
drop table FullNameList
drop table DraftInfoFull
drop table #FullDraftList
--������
create table FullDraftNameList
(
Draft						decimal(13,2) not null,  
DraftName					varchar(50) null default(''),
IsShortDraft				bit not null default(1),
Constraint PK_FullDraftNameListID primary key(Draft),
)
truncate table FullDraftNameList
--list_fr
insert into FullDraftNameList(Draft, DraftName)  
select 
t1.WHAT as Draft,
t1.nm as DraftName
from list_fr t1 
left join FullDraftNameList t2 on t1.what = t2.Draft 
where t2.Draft is null and t1.nm <>''
--olistdse
insert into FullDraftNameList(Draft, DraftName)  
select 
t1.DRAFT as Draft,
t1.DSE as DraftName
from olistdse t1 
left join FullDraftNameList t2 on t1.DRAFT = t2.Draft 
where t2.Draft is null and t1.DSE <>''
--m_cennik ocen
insert into FullDraftNameList(Draft, DraftName) 
select 
max(c.what) as Draft, 
max(m.hm) as DraftName
  from (
  select distinct c.what 
  from complect c  
  where spec = 3 and ksi = 2
  group by c.what
  union
  select distinct c.what 
  from ocomplect c  
  where spec = 3 and ksi = 2
  group by c.what
  ) c
  left join FullDraftNameList t2 on c.what = t2.Draft 
  left join m_cennik m on cast(c.what as char(14)) = m.ocen
  where t2.Draft is null and m.hm <>''
  group by c.what
--m_cennik km_num comlpect
insert into FullDraftNameList(Draft, DraftName) 
select 
max(km_num) as Draft,
max(hm) as DraftName
from m_cennik t1
join complect on what = km_num --������ �� ��� ��������� � ������������?
left join FullDraftNameList t2 on t1.km_num = t2.Draft 
where t2.Draft is null and t1.hm <>'' 
and (spec*10+ksi=33 or (spec*10+ksi>=43 and spec*10+ksi<=60)) --������ �� ��� ��������� � ������������?
group by km_num
--m_cennik km_num ocomlpect
insert into FullDraftNameList(Draft, DraftName) 
select 
max(km_num) as Draft,
max(hm) as DraftName
from m_cennik t1
join ocomplect on what = km_num --������ �� ��� ��������� � ������������?
left join FullDraftNameList t2 on t1.km_num = t2.Draft 
where t2.Draft is null and t1.hm <>'' 
and (spec*10+ksi=33 or (spec*10+ksi>=43 and spec*10+ksi<=60)) --������ �� ��� ��������� � ������������?
group by km_num
--osnsv
insert into FullDraftNameList(Draft, DraftName)  
select 
max(t1.draftosn) as Draft,
max(t1.naimosn) as DraftName
from osnsv t1 
left join FullDraftNameList t2 on t1.draftosn = t2.Draft 
where t2.Draft is null and t1.naimosn <>''
group by t1.draftosn
--pomoika
insert into FullDraftNameList(Draft, DraftName)  
select 
max(t1.DRAFTzap) as Draft,
max(t1.namezap) as DraftName
from pomoika t1 
left join FullDraftNameList t2 on t1.draftzap = t2.Draft 
where t2.Draft is null and t1.namezap <>''
group by t1.DRAFTzap
--pomoika osn
insert into FullDraftNameList(Draft, DraftName)  
select 
max(t1.draftosn) as Draft,
max(t1.nameosn) as DraftName
from pomoika t1 
left join FullDraftNameList t2 on t1.draftosn = t2.Draft 
where t2.Draft is null and t1.nameosn <>''
group by t1.draftosn
--prodact
insert into FullDraftNameList(Draft, DraftName) 
select 
max(t1.draft) as Draft,
max(t1.name) as DraftName
from prodact t1
left join FullDraftNameList t2 on t1.draft = t2.Draft 
where t2.Draft is null and t1.name <>''
group by t1.draft
--zayvka
insert into FullDraftNameList(Draft, DraftName) 
select 
max(t1.draftosn) as Draft,
max(t1.naimosn) as DraftName
from zayvka t1
left join FullDraftNameList t2 on t1.draftosn = t2.Draft 
where t2.Draft is null and t1.naimosn <>''
group by t1.draftosn
--zayvka �� ���� ������ ���, �� 0 �����, ������ ����������
--insert into FullDraftNameList(Draft, DraftName) 
--select 
--max(t1.draftosn) as Draft,
--max(t1.naosnsl) as DraftName
--from zayvka t1
--left join FullDraftNameList t2 on t1.draftosn = t2.Draft 
--where t2.Draft is null and t1.naosnsl <>'' and t1.draftosn is not null
--osn_act
insert into FullDraftNameList(Draft, DraftName) 
select 
max(t1.draftosn) as Draft,
max(t1.naimosn) as DraftName
from osn_act t1
left join FullDraftNameList t2 on t1.draftosn = t2.Draft 
where t2.Draft is null and t1.naimosn <>''
group by t1.draftosn
--��������������?
--������ ������ �������:
--UPDATE FullDraftNameList
--SET DraftName=UPPER(LEFT(DraftName,1))+LOWER(SUBSTRING(DraftName,2,LEN(DraftName))) where ISNUMERIC(SUBSTRING(LTRIM(DraftName), 1, 1)) = 0
--���:
UPDATE FullDraftNameList
SET DraftName=UPPER(DraftName)

UPDATE FullDraftNameList
SET DraftName=LTRIM(RTRIM(DraftName)) 
--����������� � ���� ��������� - �������������� ������!
create table #FullDraftList
(
DraftID						int identity(1,1)not null,  
Draft						decimal(13,2) not null,  
DraftName					varchar(50) null default(''),
DraftNameID					int null,
IsRig						int null
Constraint PK_1FullDraftListID primary key(DraftID),
Constraint FK_1DraftNameID_ReferenceInformation	foreign key(DraftNameID) references ReferenceInformation (ReferenceInformationID)
)
create table DraftInfoFull
(
DraftID						int identity(1,1)not null,  
Draft						decimal(13,2) not null,  
DraftNameID					int null,
IsRig						int null
Constraint PK_DraftInfoFullID primary key(DraftID),
Constraint FK_DraftNameID_ReferenceInformation	foreign key(DraftNameID) references ReferenceInformation (ReferenceInformationID)
)
truncate table #FullDraftList
;with query1 as
  (
  select 0 as IsRig,c.what 
  from complect c  
  where spec = 6
  group by c.what
  union
  select  1 as IsRig,c.what 
  from ocomplect c  
  where spec = 6
  group by c.what
  union
  select  0 as IsRig,c.what 
  from complect c  
  where ksi = 3 or ksi = 4
  group by c.what
  union
  select  1 as IsRig,c.what 
  from ocomplect c  
  where ksi = 3 or ksi = 4
  group by c.what
  ),
  query2 as 
  (
  select  0 as IsRig,c.what 
  from complect c  
  where spec = 3 and ksi = 2
  group by c.what
  union
  select  1 as IsRig,c.what 
  from ocomplect c  
  where spec = 3 and ksi = 2
  group by c.what
  ), 
  query3 as
  (
  select c.what
        ,m.hm,c.IsRig 
  from query1 c
  left join m_cennik m on c.what = m.km_num
  union
  select c.what
        ,m.hm,c.IsRig  
  from query2 c
  left join m_cennik m on cast(c.what as char(14)) = m.ocen
  )
insert into #FullDraftList(Draft,IsRig) 
select * from 
(
select distinct what as Draft1,0 as IsRig from complect 
union
select distinct what  as Draft1,1 as IsRig from ocomplect
union
select distinct draft  as Draft1,0 as IsRig from prodact
union
select distinct draft  as Draft1,0 as IsRig from osnsv
union
select distinct draftosn  as Draft1,1 as IsRig from osnsv
union
select distinct what as Draft1,IsRig as IsRig from query3
union
select distinct draft  as Draft1,0 as IsRig from pomoika
union
select distinct draftosn  as Draft1,1 as IsRig from pomoika
union
select distinct draftosn  as Draft1,1 as IsRig from zayvka
union
select distinct z.draft  as Draft1,0 as IsRig from zayvka z
union
select distinct draft  as Draft1,0 as IsRig from proos
union
select distinct draftosn  as Draft1,1 as IsRig from proos 
union
select distinct draftzap  as Draft1,1 as IsRig from proos
union
select distinct draft_4  as Draft1,1 as IsRig from os_pro
union
select distinct draftosn  as Draft1,1 as IsRig from osn_act) f2 order by f2.Draft1

update f1 set DraftName = f2.DSE 
from	  
#FullDraftList f1
 join listdse f2 on cast(f1.Draft / 1000 as int)=f2.Draft where Ltrim(rtrim(f2.dse)) <> ''

update f1 set DraftName = f2.DraftName 
from	  
#FullDraftList f1
 join FullDraftNameList f2 on f1.Draft = f2.Draft where Ltrim(rtrim(f2.DraftName)) <> '' and Ltrim(rtrim(f1.DraftName)) = ''

 update f1 set DraftName = f2.DraftName 
from	  
#FullDraftList f1
 join FullDraftNameList f2 on f1.Draft = f2.Draft where Ltrim(rtrim(f2.DraftName)) <> '' and Ltrim(rtrim(f1.DraftName)) = ''

update f1 set DraftName = '��� ������������' 
from	  
#FullDraftList f1 where DraftName = ''
update f1 set DraftName = '������ �����������' 
from	  
#FullDraftList f1 where draft = 0

insert into ReferenceInformation(
	   [ReferenceCodeID]
      ,[ReferenceName])
select distinct 3 as [ReferenceCodeID] ,LTRIM(RTRIM(UPPER(DraftName))) as DraftName from #FullDraftList order by DraftName

update f1 set f1.DraftNameID = f2.ReferenceInformationID from
#FullDraftList f1
join ReferenceInformation f2 on LTRIM(RTRIM(UPPER(f1.DraftName))) = f2.ReferenceName where f2.ReferenceCodeID=3

update #FullDraftList set IsRig = 2 where DraftID in 
(select f1.DraftID as DraftID from #FullDraftList f1
join #FullDraftList f2 on f1.Draft=f2.Draft and f1.IsRig <> f2.IsRig 
)
insert into DraftInfoFull(Draft,DraftNameID,IsRig) 
select distinct f1.Draft as Draft,f1.DraftNameID as DraftNameID, f1.IsRig as IsRig from #FullDraftList f1
--where draft >1000  �������� ������ ��������
order by Draft asc  