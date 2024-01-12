drop table Osnastka.DraftOsnast
create table Osnastka.DraftOsnast
(
--�������� �������
--���� �� ������
DraftOsnastID					int not null identity(1,1),
OsnastkaByDraftID					int null,
TechOrderID						int null,
AmountEquipmentInWorkTogether	numeric(2,0) null,   		--(klo) -- ���������� ������������ �������������� �������
NameDraftOsnast					varchar(50) null,			--(naimosn) --������������ �������� (�� ������������)
DraftOsn						numeric (13,2) null,		--(draftosn) --������ ��������

Ksi								smallint null,						--(ksi)							--����� �� ������ numeric ��� smallint
AmountEquipmentForOper   		smallint null,						--(koltex)						--������ � �����, � ��������� ��� (4,1), ����� �� ������ numeric ��� smallint
Note							varchar (50) null,					--(prim)
NameOsnastTechnolog				varchar (50) null,					--(naosnsl)						--����� ������������ �������� �� ������������ � ���������???
IsHandOverDraft					bit null,							--(kl)							--null - ������������, 0 �� ������, 1 ��� �����
LaborManufacturingAssume		numeric(7,2) not null default(0),	--(trud)						--����� �� ������ numeric ��� int  --���� ������������� �������� � ������� -- ��� > 0

DateEmployeeApproved			date null,				--(dsog)			--DateCoordinatorConstructor
IsStatusEmployeeApproved		bit null,				--(sog + nsog)		--IsStatusCoordinatorConstructor
DateEmployeeFinalApproved		date null,				--(dsog2)			--DateCoordinatorTechnolog--(sog2) --???�����������
IsStatusEmployeeFinalApproved	bit null,				--(sog2 + nsog2)    --IsStatusCoordinatorTechnolog

DraftPiece 						numeric (13,2) null,		--(draftzap) -����� ����� ��������
NameDraftPiece					varchar(50) null,	
											
--(dizmk) --???�������������=dataosn, ����� ���� ������������� �������, ���� ����� dsog2

AmountEquipmentProducePlan		numeric (6,0) null,			--(kolzak) --� ��������� � koltex � kolzak --���������� ����������

--(izv) --???��������� �� ���������

DateConstructorApprove			date null,					--(dt_who) --���� ����� ������� �������� ������������� ������??????????????!!!!!!
AuthorTechnologApprove			varchar(20) null,			--(imyts) --��������, ������������� ������ �������� ����� ������������
AuthorConstructorExecute		varchar(20) null,			--(ispolk) --�����������-�����������
LabourIntensivenessDesignPlan	numeric (7,2) null,			--(trudpr_p) --������������ �������������� ��������
LabourIntensivenessDesignFact	numeric (7,2) null,			--(trudpr_f) --������������ ��������������  �����������

--���� �� os_pro

--(to_2) --��� �������� ������ ������� , ��� ��������
AddInformation					varchar(3500) null,					--(dop)							--��� ���� ������� �������
IsMakeInMetal					bit not null default(1),											--� ������� �������������?

DateDesignPlan					date null,					--(s_pr_9) --���� ��������������(����)
DateProducePlan					date null,					--(s_iz_10) --���� ������������(����)
DateImplementPlan				date null,					--(s_vn_11) --���� ���������(����)
DateDesignFact					date null,					--(d_pr_12) --���� ��������������(����)
DateProduceFact					date null,					--(d_iz_13) --���� ������������(����)
DateDraftToBTD					date null,					--(d_vn_14) --���� ����� �������� � ���
DepartmentOrder					varchar(5) null,			--(z_z_15)	--�������������-��������
ANNTab							char(3) null,				--???(z_iz_16) --���-������������ --��� - ��� - � ������� �� ��������������, ����������?
NameReciever					varchar(12) null,			--(mesto_18)--��� ������������ �������  
DateTechOrderOpen				date null,					--(d_otk_23)--���� �������� ���������  
LabourIntensivenessProducePlan	numeric (7,2) null,			--(tr_p_24) --������������ ������������ ��������(����)
LabourIntensivenessProduceFact	numeric (7,2) null,			--(tr_f_34) --������������ ������������(����)
--numeric (2,0) null,--(ko1_27)	--???��� ���������� ������������ ��������
--numeric (3,0) null,--(kod_29)	--???��� ������ ������������ ��������
BalanceAccount					numeric (3,0) null,			--(schet_31)--���������� ����  
AmountEquipmentProduceFact		numeric (5,0) null,			--(k_f_33)	--���������� �����������(����)

--(uch_i_35)--��� �������� �������-������������
--(osn_37)	--��� �������� ��� ������������ ��������
--(d_zap)	--��� �������� ���� ������� � ������������

DateRecieveTechOrderSPP			date null,					--(d_spp)	--���� ��������� �/� ���(���� ���)
--IsApproved bit null,--(pr)		--������� ������������ ��������� --������ �� ��� �� �����

ProdID							int null,
OldOsproid						int null,
OldZayvkaid						int null,
OldProosid						int null,
YearTechOrd                   varchar(7) not null default(''),	--(zak_1)

Constraint CHK_LaborManufacturingAssume							check(LaborManufacturingAssume >= 0),
Constraint FK_TechOrderID_TechOrder				foreign key(TechOrderID)			references Osnastka.TechOrder (TechOrderID), 
Constraint FK_ProdID_TechOrder					foreign key(ProdID)					references prod (ID), 
Constraint FK_OsnastkaByDraftID_TechOrder			foreign key(OsnastkaByDraftID)			references Osnastka.OsnastkaByDraftList (OsnastkaByDraftID), 
Constraint PK_DraftOsnastID						primary key(DraftOsnastID)
)