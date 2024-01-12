drop table Osnastka.DraftOsnast
create table Osnastka.DraftOsnast
(
--ОСНОВНАЯ ТАБЛИЦА
--поля от заявки
DraftOsnastID					int not null identity(1,1),
OsnastkaByDraftID					int null,
TechOrderID						int null,
AmountEquipmentInWorkTogether	numeric(2,0) null,   		--(klo) -- Количество одновременно обрабатываемых деталей
NameDraftOsnast					varchar(50) null,			--(naimosn) --Наименование оснастки (от конструктора)
DraftOsn						numeric (13,2) null,		--(draftosn) --Чертеж оснастки

Ksi								smallint null,						--(ksi)							--нужен ли вообще numeric или smallint
AmountEquipmentForOper   		smallint null,						--(koltex)						--решить с типом, в оригинале был (4,1), нужен ли вообще numeric или smallint
Note							varchar (50) null,					--(prim)
NameOsnastTechnolog				varchar (50) null,					--(naosnsl)						--зачем наименования оснастки от конструктора и технолога???
IsHandOverDraft					bit null,							--(kl)							--null - неопределено, 0 со сдачей, 1 без сдачи
LaborManufacturingAssume		numeric(7,2) not null default(0),	--(trud)						--нужен ли вообще numeric или int  --есть отрицательные значения в записях -- чек > 0

DateEmployeeApproved			date null,				--(dsog)			--DateCoordinatorConstructor
IsStatusEmployeeApproved		bit null,				--(sog + nsog)		--IsStatusCoordinatorConstructor
DateEmployeeFinalApproved		date null,				--(dsog2)			--DateCoordinatorTechnolog--(sog2) --???Согласовано
IsStatusEmployeeFinalApproved	bit null,				--(sog2 + nsog2)    --IsStatusCoordinatorTechnolog

DraftPiece 						numeric (13,2) null,		--(draftzap) -нужно лучше название
NameDraftPiece					varchar(50) null,	
											
--(dizmk) --???Первоначально=dataosn, делее дата корректировки чертежа, если пусто dsog2

AmountEquipmentProducePlan		numeric (6,0) null,			--(kolzak) --я запутался с koltex и kolzak --Количество изготовить

--(izv) --???Извещение об изменении

DateConstructorApprove			date null,					--(dt_who) --Дата ввода чертежа оснастки конструктором ЛИШНЕЕ??????????????!!!!!!
AuthorTechnologApprove			varchar(20) null,			--(imyts) --Технолог, согласовавший чертеж оснастки после конструктора
AuthorConstructorExecute		varchar(20) null,			--(ispolk) --Конструктор-исполнитель
LabourIntensivenessDesignPlan	numeric (7,2) null,			--(trudpr_p) --Трудоемкость проектирования плановая
LabourIntensivenessDesignFact	numeric (7,2) null,			--(trudpr_f) --Трудоемкость проектирования  фактическая

--поля от os_pro

--(to_2) --ПОД ВОПРОСОМ Чертеж изделие , для которого
AddInformation					varchar(3500) null,					--(dop)							--тип поля слишком тяжелый
IsMakeInMetal					bit not null default(1),											--в металле изготавливать?

DateDesignPlan					date null,					--(s_pr_9) --Срок проектирования(план)
DateProducePlan					date null,					--(s_iz_10) --Срок изготовления(план)
DateImplementPlan				date null,					--(s_vn_11) --Срок внедрения(план)
DateDesignFact					date null,					--(d_pr_12) --Дата проектирования(факт)
DateProduceFact					date null,					--(d_iz_13) --Дата изготовления(факт)
DateDraftToBTD					date null,					--(d_vn_14) --Дата сдачи чертежей в БТД
DepartmentOrder					varchar(5) null,			--(z_z_15)	--Подразделение-заказчик
ANNTab							char(3) null,				--???(z_iz_16) --Цех-изготовитель --АНН - ТАБ - в металле не изготоваливать, переделать?
NameReciever					varchar(12) null,			--(mesto_18)--ФИО принимающего чертежи  
DateTechOrderOpen				date null,					--(d_otk_23)--Дата открытия техзаказа  
LabourIntensivenessProducePlan	numeric (7,2) null,			--(tr_p_24) --Трудоемкость изготовления оснастки(план)
LabourIntensivenessProduceFact	numeric (7,2) null,			--(tr_f_34) --Трудоемкость изготовления(факт)
--numeric (2,0) null,--(ko1_27)	--???Код уточненный наименования оснастки
--numeric (3,0) null,--(kod_29)	--???Код общего наименования оснастки
BalanceAccount					numeric (3,0) null,			--(schet_31)--Балансовый счет  
AmountEquipmentProduceFact		numeric (5,0) null,			--(k_f_33)	--Количество изготовлено(факт)

--(uch_i_35)--ПОД ВОПРОСОМ Участок-изготовитель
--(osn_37)	--ПОД ВОПРОСОМ Код изготовления оснастки
--(d_zap)	--ПОД ВОПРОСОМ Дата запуска в производство

DateRecieveTechOrderSPP			date null,					--(d_spp)	--Дата получения т/з СПП(Факт БЧХ)
--IsApproved bit null,--(pr)		--Признак согласования техзаказа --ВТОРОЙ ЖЕ УЖЕ НЕ НУЖЕН

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