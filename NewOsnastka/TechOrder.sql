drop table [Osnastka].OsnastOrder
drop table [Osnastka].TechOrder
--create schema Osnastka
create table [Osnastka].TechOrder
(
--�������� �������
TechOrderID						int not null identity(1,1),
IsApplicationFrom				bit null,   						--0-���, 1-������������ 
DateCreateApplication			datetime null,						--(dza)
TechOrd							smallint null default(0),			--(tzak)			
YearTechOrd						varchar(7) not null default(''),	--(zak_1)
--Draft							numeric (13,2) null,				--(draft)	
DraftID							int not null,
--NameDraft						varchar(50) null,
Workplace						numeric (3,0) null,					--(rab_m)						--������� ����
OperationCode					numeric (4,0) null,					--(kodop + kpodrt)				--������� ����
FactoryOrder                    smallint not null default(0),		--(zakf - zakaz)				
FactoryNumberOrder				smallint not null default(0),		--(zakf - nom)	

WorkshopID						int not null,						--���� �� ������� ����� (Workshop)
--WorkshopReceiver				char (3) null,						--(cexpol)						--������� ����
--Larder						numeric (3,0) null,					--(kladov)						--����� �� ������ numeric ��� smallint    (������ �� � ����� �����������?)

--AmountEquipmentForOper   		smallint null,						--(koltex)						--������ � �����, � ��������� ��� (4,1), ����� �� ������ numeric ��� smallint
AuthorTechnolog					varchar (20) null,					--(imyt)
DateChangeTechnolog				datetime null,						--(dizmt)
DepartmentTechnolog				varchar(5),							--(kpod)
--Note							varchar (50) null,					--(prim)
DraftProduct					numeric (13,2) null,				--(draftiz)						-- ???
NameDraftProduct				varchar (50) null,					--(ndraftiz)					--������������ � ������������� �� ������ ������� - �������� ������ �������???
Analogue						varchar (20) null,					--(prim_an)						--� ��� ����� ����??
--NameOsnastTechnolog				varchar (50) null,					--(naosnsl)						--����� ������������ �������� �� ������������ � ���������???
--IsHandOverDraft					bit null,							--(kl)							--null - ������������, 0 �� ������, 1 ��� �����
--LaborManufacturingAssume		numeric(7,2) not null default(0),	--(trud)						--����� �� ������ numeric ��� int  --���� ������������� �������� � ������� -- ��� > 0
AuthorConstructor				varchar(20) null,					--(imyk)
AuthorBoss						varchar(20) null,					--(boss)
DateWorkChiefConstructor		datetime null,						--(dt_ko)
--proos
ReasonProduction				varchar (50) null,					--(prichina) 
DateLimitation					datetime null,						--(srok) 
IsReturnedToTechnolog			bit null,							--(back)
DateReturnedToTechnolog			datetime null,						--(dt_back)
ReasonReturnedToTechnolog		varchar (300) null,					--(why_back)
IsAtConstructor					bit null,							--(toko)
DateAtConstructor				datetime null,						--(dt_toko)
DateAtApproval					datetime null,						--(dt_iz�g)
RepairOrProduction				int null,						--(rem_izg)						--������� ����
TypeOsnast						int null,						--(nvid)						--������� ����



Grafik_id						int null,

OldProosID						int null,
OldZayvkaid						int null,


--������������ �����
--Constraint CHK_LaborManufacturingAssume							check(LaborManufacturingAssume >= 0),
Constraint CHK_FactoryOrder										check(FactoryOrder >= 0 and FactoryOrder <= 9999),
Constraint CHK_FactoryNumberOrder								check(FactoryNumberOrder >= 0 and FactoryNumberOrder <= 999),
Constraint CHK_TechOrder										check(TechOrd >= 0 and TechOrd <= 9999),

Constraint FK_DraftID_OsnastUseList								foreign key(DraftID)			references DraftInfoFull (DraftID), 
Constraint FK_Workplace_oborud									foreign key(Workplace)			references oborud (rab_m), 
Constraint FK_OperationCode_s_oper								foreign key(OperationCode)		references s_oper (code), 
Constraint FK_WorkshopID_Workshop								foreign key(WorkshopID)			references Workshop (WorkshopID), 
Constraint FK_RepairOrProduction_ReferenceInformation	        foreign key(RepairOrProduction) references ReferenceInformation (ReferenceInformationID), 
Constraint FK_TypeOsnast_ReferenceInformation					foreign key(TypeOsnast)			references ReferenceInformation (ReferenceInformationID), 

Constraint PK_RequestEquipmentID								primary key(TechOrderID)
)