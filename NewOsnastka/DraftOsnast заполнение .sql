--select distinct YearTechOrder from Osnastka.TechOrder group by YearTechOrder
--заполнение заявки
--нулевые zak_1
insert into Osnastka.DraftOsnast(	
OsnastkaByDraftID
 --,DraftOsn
 ,OsnastDraftID
 ,Ksi
,DateEmployeeApproved
,IsStatusEmployeeApproved   
,DateEmployeeFinalApproved
,DateEmployeeApprovedProject
--,DraftPiece 
 ,InterOsnastDraftID
,AmountEquipmentProducePlan
,DateConstructorApprove
,AuthorConstructorExecute
,DateDesignPlan					
,DateProducePlan					
,DateImplementPlan				
,DateDesignFact					
,DateProduceFact					
,DateDraftToBTD					
,DepartmentOrder			 		
,ANNTab							
,NameReciever					
,DateTechOrderOpen				
,LabourIntensivenessProducePlan
,LabourIntensivenessProduceFact
,BalanceAccount					
,AmountEquipmentProduceFact		
,DateRecieveTechOrderSPP
--,TechOrderID
,AmountEquipmentInWorkTogether
--,NameDraftOsnast				
,IsStatusEmployeeFinalApproved
,AuthorTechnologApprove		
,LabourIntensivenessDesignPlan
,LabourIntensivenessDesignFact
,OldOsproid
--,ProdID
,AddInformation
,IsMakeInMetal
,OldZayvkaid
,OldProosid
	  ,AmountEquipmentForOper	
	  ,Note		
	  ,NameOsnastTechnolog	
	  ,IsHandOverDraft				
	  ,LaborManufacturingAssume	
)
SELECT   
	OD.OsnastkaByDraftID as OsnastkaByDraftID,
	  ---------------zayvka + proos
       --iif(z.draftosn is null, cast(zay.draftosn as numeric(13,2)),cast(z.draftosn as numeric(13,2)))					as	DraftOsn
      f1.draftid																										as	OsnastDraftID
	  ,cast(zay.ksi as		smallint)																					as	Ksi		
      ,iif(z.dt_boss is null, zay.dsog,cast(z.dt_boss as date))															as	DateEmployeeApproved
      ,iif(z.sog is null, iif(zay.sog='*',1,0),cast(z.sog as bit))														as	IsStatusEmployeeApproved            
      ,cast(zay.dsog2 as date)																							as	DateEmployeeFinalApproved
	  ,cast(z.dt_ok as date)																							as  DateEmployeeApprovedProject
	  --,cast(z.draftzap as numeric(13,2))																				AS	DraftPiece 
	  ,f2.draftid																										AS	InterOsnastDraftID 
      ,iif(z.kol is null, cast(zay.kolzak as numeric (6,0)),cast(z.kol as numeric (6,0)))								as	AmountEquipmentProducePlan
      ,iif(z.dt_who is null, zay.dza,cast(z.dt_who  as date))															as	DateConstructorApprove
      ,LTRIM(RTRIM(iif(z.fioko is null, cast(zay.ispolk as varchar(20)),cast(z.fioko as varchar(20)))))					as	AuthorConstructorExecute
	  --------------------os_pro
	  ,cast(s_pr_9    as date)																							AS	DateDesignPlan					
	  ,cast(s_iz_10	as date)																							AS	DateProducePlan					
	  ,cast(s_vn_11	as date)																							AS	DateImplementPlan				
	  ,cast(d_pr_12	as date)																							AS	DateDesignFact					
	  ,cast(d_iz_13	as date)																							AS	DateProduceFact					
	  ,cast(d_vn_14	as date)																							AS	DateDraftToBTD					
	  ,LTRIM(RTRIM(cast(z_z_15	as varchar(5))))																		AS	DepartmentOrder			 		
	  ,cast(z_iz_16	as char(3))																							AS	ANNTab							
	  ,LTRIM(RTRIM(cast(mesto_18	as varchar(12))))																	AS	NameReciever					
	  ,cast(d_otk_23	as date)																						AS	DateTechOrderOpen				
	  ,cast(tr_p_24	as numeric(7,2))																					AS	LabourIntensivenessProducePlan	
	  ,cast(tr_f_34	as numeric(7,2))																					AS	LabourIntensivenessProduceFact	
	  ,cast(schet_31	as numeric(3,0))																				AS	BalanceAccount					
	  ,cast(k_f_33	as numeric(5,0))																					AS	AmountEquipmentProduceFact		
	  ,cast(d_spp	    as date)																						AS	DateRecieveTechOrderSPP
	  --,t.TechOrderID																									as	TechOrderID
	  ---------------zayvka
	 ,cast(klo as 	numeric(2,0) )   																					as	AmountEquipmentInWorkTogether	--(klo) -- Количество одновременно обрабатываемых деталей
	 --,LTRIM(RTRIM(cast(naimosn as	varchar(50))))																		as	NameDraftOsnast					--(naimosn) --Наименование оснастки (от конструктора)
	 ,cast(iif(sog2='*',1,0) as	bit )																					as	IsStatusEmployeeFinalApproved	--(sog2 + nsog2)    --IsStatusCoordinatorTechnolog
	 ,LTRIM(RTRIM(cast(imyts as	varchar(20))))																			as	AuthorTechnologApprove			--(imyts) --Технолог, согласовавший чертеж оснастки после конструктора
	 ,cast(trudpr_p as	numeric (7,2))																					as	LabourIntensivenessDesignPlan	--(trudpr_p) --Трудоемкость проектирования плановая
	 ,cast(trudpr_f as	numeric (7,2))																					as	LabourIntensivenessDesignFact	--(trudpr_f) --Трудоемкость проектирования  фактическая
	 ,s.id																												as OldOsproid
	 --,prodT.id																											as ProdID
	 ,LTRIM(RTRIM(cast((iif (z.[dop] is not null,z.[dop],zay.[dop])) as varchar(3500)))) as AddInformation   
	 ,IIF(((iif (z.[dop] is not null,z.[dop],zay.[dop])) like '%в мет. не%' or (iif (z.[dop] is not null,z.[dop],zay.[dop])) like '%в металле не изг%'),0,1)   as IsMakeInMetal

	 ,zay.predtz as OldZayvkaid
	 ,z.tzakpred as OldProosid
	 ---				
	  ,cast(koltex as	smallint)		as					AmountEquipmentForOper	
	  ,LTRIM(RTRIM(cast(prim as varchar (50))))	as						Note		
	  ,LTRIM(RTRIM(cast(naosnsl as	varchar (50))))	as					NameOsnastTechnolog	
	  ,cast(kl as bit)			as							IsHandOverDraft				
	  ,cast(iif(zay.trud<0 or zay.trud is null, 0,zay.trud )as	numeric(7,2))as			LaborManufacturingAssume	
  FROM zayvka zay
  left join os_pro s on s.zak_1 = zay.zak_1
  left join proos z on zay.zak_1 = z.zak_1 
    left join (select o.OsnastkaByDraftID,Workplace,OperationCode,df.Draft as Draft, osf.Draft as DraftOsn from Osnastka.OsnastkaByDraft o
  join FullDraftList df on df.DraftID = o.DraftID
  join FullDraftList osf on osf.DraftID = o.OsnastkaID) as OD on  
  OD.Workplace = zay.rab_m and OD.OperationCode = zay.kodop and OD.Draft = zay.Draft and
   OD.DraftOsn = iif(z.draftosn is null, cast(zay.draftosn as numeric(13,2)),cast(z.draftosn as numeric(13,2))) 
  left join FullDraftList f1 on 
	iif(z.draftosn is null, cast(zay.draftosn as numeric(13,2)),cast(z.draftosn as numeric(13,2))) = f1.draft 
  left join FullDraftList f2 on 
	cast(z.draftzap as numeric(13,2)) = f2.draft
  where z.draft is null and zay.zak_1 = ''                        --TODO ПОЧЕМУ ТУТ ДРАФТОСН 0???
--не нулевые
insert into Osnastka.DraftOsnast(	
OsnastkaByDraftID
 --DraftOsn
 ,OsnastDraftID
 ,Ksi
,DateEmployeeApproved
,IsStatusEmployeeApproved   
,DateEmployeeFinalApproved
,DateEmployeeApprovedProject
--,DraftPiece 
 ,InterOsnastDraftID
,AmountEquipmentProducePlan
,DateConstructorApprove
,AuthorConstructorExecute
,DateDesignPlan					
,DateProducePlan					
,DateImplementPlan				
,DateDesignFact					
,DateProduceFact					
,DateDraftToBTD					
,DepartmentOrder			 		
,ANNTab							
,NameReciever					
,DateTechOrderOpen				
,LabourIntensivenessProducePlan
,LabourIntensivenessProduceFact
,BalanceAccount					
,AmountEquipmentProduceFact		
,DateRecieveTechOrderSPP
--,TechOrderID
,AmountEquipmentInWorkTogether
--,NameDraftOsnast				
,IsStatusEmployeeFinalApproved
,AuthorTechnologApprove		
,LabourIntensivenessDesignPlan
,LabourIntensivenessDesignFact
,OldOsproid
--,ProdID
,AddInformation
,IsMakeInMetal
,OldZayvkaid
,OldProosid
,YearTechOrd
	  ,AmountEquipmentForOper	
	  ,Note		
	  ,NameOsnastTechnolog	
	  ,IsHandOverDraft				
	  ,LaborManufacturingAssume	
)
SELECT   
	OD.OsnastkaByDraftID as OsnastkaByDraftID,
	  ---------------zayvka + proos
       --iif(z.draftosn is null, cast(zay.draftosn as numeric(13,2)),cast(z.draftosn as numeric(13,2)))					as	DraftOsn
	  f1.draftid																										as	OsnastDraftID
	  ,cast(zay.ksi as		smallint)		as					Ksi		
      ,iif(z.dt_boss is null, zay.dsog,cast(z.dt_boss as date))															as	DateEmployeeApproved
      ,iif(z.sog is null, iif(zay.sog='*',1,0),cast(z.sog as bit))														as	IsStatusEmployeeApproved            
      ,cast(zay.dsog2 as date)																							as	DateEmployeeFinalApproved
	  ,cast(z.dt_ok as date)																							as  DateEmployeeApprovedProject
	  --,cast(z.draftzap as numeric(13,2))																				AS	DraftPiece 
	  ,f2.draftid																										AS	InterOsnastDraftID 
      ,iif(z.kol is null, cast(zay.kolzak as numeric (6,0)),cast(z.kol as numeric (6,0)))								as	AmountEquipmentProducePlan
      ,iif(z.dt_who is null, zay.dza,cast(z.dt_who  as date))															as	DateConstructorApprove
      ,LTRIM(RTRIM(iif(z.fioko is null, cast(zay.ispolk as varchar(20)),cast(z.fioko as varchar(20)))))								as	AuthorConstructorExecute
	  --------------------os_pro
	  ,cast(s_pr_9    as date)																							AS	DateDesignPlan					
	  ,cast(s_iz_10	as date)																							AS	DateProducePlan					
	  ,cast(s_vn_11	as date)																							AS	DateImplementPlan				
	  ,cast(d_pr_12	as date)																							AS	DateDesignFact					
	  ,cast(d_iz_13	as date)																							AS	DateProduceFact					
	  ,cast(d_vn_14	as date)																							AS	DateDraftToBTD					
	  ,LTRIM(RTRIM(cast(z_z_15	as varchar(5))))																							AS	DepartmentOrder			 		
	  ,cast(z_iz_16	as char(3))																							AS	ANNTab							
	  ,LTRIM(RTRIM(cast(mesto_18	as varchar(12))))																						AS	NameReciever					
	  ,cast(d_otk_23	as date)																						AS	DateTechOrderOpen			--ПОФИКСИТЬ!!!????	
	  ,cast(tr_p_24	as numeric(7,2))																							AS	LabourIntensivenessProducePlan	
	  ,cast(tr_f_34	as numeric(7,2))																							AS	LabourIntensivenessProduceFact	
	  ,cast(schet_31	as numeric(3,0))																						AS	BalanceAccount					
	  ,cast(k_f_33	as numeric(5,0))																							AS	AmountEquipmentProduceFact		
	  ,cast(d_spp	    as date)																						AS	DateRecieveTechOrderSPP
	  --,t.TechOrderID																									as	TechOrderID
	  ---------------zayvka
	 ,cast(klo as 	numeric(2,0) )   																					as	AmountEquipmentInWorkTogether	--(klo) -- Количество одновременно обрабатываемых деталей
	 --,LTRIM(RTRIM(cast(naimosn as	varchar(50))))																					as	NameDraftOsnast					--(naimosn) --Наименование оснастки (от конструктора)
	 ,cast(iif(sog2='*',1,0) as	bit )																					as	IsStatusEmployeeFinalApproved	--(sog2 + nsog2)    --IsStatusCoordinatorTechnolog
	 ,LTRIM(RTRIM(cast(imyts as	varchar(20))))																						as	AuthorTechnologApprove			--(imyts) --Технолог, согласовавший чертеж оснастки после конструктора
	 ,cast(trudpr_p as	numeric (7,2))																					as	LabourIntensivenessDesignPlan	--(trudpr_p) --Трудоемкость проектирования плановая
	 ,cast(trudpr_f as	numeric (7,2))																					as	LabourIntensivenessDesignFact	--(trudpr_f) --Трудоемкость проектирования  фактическая
	 ,s.id																												as OldOsproid
	 --,prodT.id																											as ProdID
	 ,LTRIM(RTRIM(cast((iif (z.[dop] is not null,z.[dop],zay.[dop])) as varchar(3500)))) as AddInformation   
	 ,IIF(((iif (z.[dop] is not null,z.[dop],zay.[dop])) like '%в мет. не%' or (iif (z.[dop] is not null,z.[dop],zay.[dop])) like '%в металле не изг%'),0,1)   as IsMakeInMetal

	 ,zay.predtz as OldZayvkaid
	 ,z.tzakpred as OldProosid
	 ,zay.zak_1 as YearTechOrd
	 	  ,cast(koltex as	smallint)		as					AmountEquipmentForOper	
	  ,LTRIM(RTRIM(cast(prim as varchar (50))))	as						Note		
	  ,LTRIM(RTRIM(cast(naosnsl as	varchar (50))))	as					NameOsnastTechnolog	
	  ,cast(kl as bit)			as							IsHandOverDraft				
	  ,cast(iif(zay.trud<0 or zay.trud is null, 0,zay.trud )as	numeric(7,2))as			LaborManufacturingAssume	
  FROM zayvka zay
  left join os_pro s on s.zak_1 = zay.zak_1  and zay.draft = s.draft_4 and zay.dza = s.d_otk_23 and cast(zay.draftosn as char(14)) = cast(rtrim(ltrim(s.osn_6)) as char(14)) 
  left join proos z on zay.zak_1 = z.zak_1 
      left join (select o.OsnastkaByDraftID,Workplace,OperationCode,df.Draft as Draft, osf.Draft as DraftOsn from Osnastka.OsnastkaByDraft o
  join FullDraftList df on df.DraftID = o.DraftID
  join FullDraftList osf on osf.DraftID = o.OsnastkaID) as OD on  
  OD.Workplace = zay.rab_m and OD.OperationCode = zay.kodop and OD.Draft = zay.Draft and
   OD.DraftOsn = iif(z.draftosn is null, cast(zay.draftosn as numeric(13,2)),cast(z.draftosn as numeric(13,2))) 
  left join FullDraftList f1 on 
	iif(z.draftosn is null, cast(zay.draftosn as numeric(13,2)),cast(z.draftosn as numeric(13,2))) = f1.draft 
  left join FullDraftList f2 on 
	cast(z.draftzap as numeric(13,2)) = f2.draft
  where z.zak_1 is null and zay.zak_1 <> ''
----соединение draftosnast и techorder для zak_1 пустого
update Osnastka.DraftOsnast 
set TechOrderID = g.TechOrderID
from
(
select 
T.TechOrderID, d.DraftOsnastID
from Osnastka.TechOrder T
join Osnastka.DraftOsnast D on T.OldZayvkaid = D.OldZayvkaid
) as g
where Osnastka.DraftOsnast.YearTechOrd ='' and Osnastka.DraftOsnast.DraftOsnastID = g.DraftOsnastID
--соединение draftosnast и techorder для zak_1 не пустого
update Osnastka.DraftOsnast 
set TechOrderID = g.TechOrderID
from
(
select 
T.TechOrderID, d.DraftOsnastID
from Osnastka.TechOrder T
join Osnastka.DraftOsnast D on T.YearTechOrd = D.YearTechOrd
) as g
where Osnastka.DraftOsnast.YearTechOrd <> '' and Osnastka.DraftOsnast.DraftOsnastID = g.DraftOsnastID
--вставка проос
insert into Osnastka.DraftOsnast(	
OsnastkaByDraftID
 --,DraftOsn
 ,OsnastDraftID
 ,Ksi
,DateEmployeeApproved
,IsStatusEmployeeApproved   
,DateEmployeeFinalApproved
,DateEmployeeApprovedProject
--,DraftPiece 
 ,InterOsnastDraftID
,AmountEquipmentProducePlan
,DateConstructorApprove
,AuthorConstructorExecute
,DateDesignPlan					
,DateProducePlan					
,DateImplementPlan				
,DateDesignFact					
,DateProduceFact					
,DateDraftToBTD					
,DepartmentOrder			 		
,ANNTab							
,NameReciever					
,DateTechOrderOpen				
,LabourIntensivenessProducePlan
,LabourIntensivenessProduceFact
,BalanceAccount					
,AmountEquipmentProduceFact		
,DateRecieveTechOrderSPP
,TechOrderID
,AmountEquipmentInWorkTogether
--,NameDraftOsnast				
,IsStatusEmployeeFinalApproved
,AuthorTechnologApprove		
,LabourIntensivenessDesignPlan
,LabourIntensivenessDesignFact
,OldOsproid
--,ProdID
,AddInformation
,IsMakeInMetal
	  ,AmountEquipmentForOper	
	  ,Note		
	  ,NameOsnastTechnolog	
	  ,IsHandOverDraft				
	  ,LaborManufacturingAssume	
)
SELECT   
	OD.OsnastkaByDraftID as OsnastkaByDraftID,
	  ---------------zayvka + proos
      --iif(z.draftosn is null, cast(zay.draftosn as numeric(13,2)),cast(z.draftosn as numeric(13,2)))					as	DraftOsn
	        f1.draftid																										as	OsnastDraftID
	  ,cast(zay.ksi as		smallint)		as					Ksi		
      ,iif(z.dt_boss is null, zay.dsog,cast(z.dt_boss as date))															as	DateEmployeeApproved
      ,iif(z.sog is null, iif(zay.sog='*',1,0),cast(z.sog as bit))														as	IsStatusEmployeeApproved            
      ,cast(zay.dsog2 as date)																							as	DateEmployeeFinalApproved
	  ,cast(z.dt_ok as date)																							as  DateEmployeeApprovedProject
	  --,cast(z.draftzap as numeric(13,2))																				AS	DraftPiece
	  	  ,f2.draftid																										AS	InterOsnastDraftID 
      ,iif(z.kol is null, cast(zay.kolzak as numeric (6,0)),cast(z.kol as numeric (6,0)))								as	AmountEquipmentProducePlan
      ,iif(z.dt_who is null, zay.dza,cast(z.dt_who  as date))															as	DateConstructorApprove
      ,LTRIM(RTRIM(iif(z.fioko is null, cast(zay.ispolk as varchar(20)),cast(z.fioko as varchar(20)))))					as	AuthorConstructorExecute
	  --------------------os_pro
	  ,cast(s_pr_9    as date)																							AS	DateDesignPlan					
	  ,cast(s_iz_10	as date)																							AS	DateProducePlan					
	  ,cast(s_vn_11	as date)																							AS	DateImplementPlan				
	  ,cast(d_pr_12	as date)																							AS	DateDesignFact					
	  ,cast(d_iz_13	as date)																							AS	DateProduceFact					
	  ,cast(d_vn_14	as date)																							AS	DateDraftToBTD					
	  ,LTRIM(RTRIM(cast(z_z_15	as varchar(5))))																							AS	DepartmentOrder			 		
	  ,cast(z_iz_16	as char(3))																							AS	ANNTab							
	  ,LTRIM(RTRIM(cast(mesto_18	as varchar(12))))																						AS	NameReciever					
	  ,cast(d_otk_23	as date)																						AS	DateTechOrderOpen				
	  ,cast(tr_p_24	as numeric(7,2))																							AS	LabourIntensivenessProducePlan	
	  ,cast(tr_f_34	as numeric(7,2))																							AS	LabourIntensivenessProduceFact	
	  ,cast(schet_31	as numeric(3,0))																						AS	BalanceAccount					
	  ,cast(k_f_33	as numeric(5,0))																							AS	AmountEquipmentProduceFact		
	  ,cast(d_spp	    as date)																						AS	DateRecieveTechOrderSPP
	  ,t.TechOrderID																									as	TechOrderID
	  ---------------zayvka
	  ,cast(klo as 	numeric(2,0) )   																					as	AmountEquipmentInWorkTogether	--(klo) -- Количество одновременно обрабатываемых деталей
	 -- ,LTRIM(RTRIM(cast(naimosn as	varchar(50))))																					as	NameDraftOsnast					--(naimosn) --Наименование оснастки (от конструктора)
	  ,cast(iif(sog2='*',1,0) as	bit )																					as	IsStatusEmployeeFinalApproved	--(sog2 + nsog2)    --IsStatusCoordinatorTechnolog
	  ,LTRIM(RTRIM(cast(imyts as	varchar(20))))																						as	AuthorTechnologApprove			--(imyts) --Технолог, согласовавший чертеж оснастки после конструктора
	  ,cast(trudpr_p as	numeric (7,2))																					as	LabourIntensivenessDesignPlan	--(trudpr_p) --Трудоемкость проектирования плановая
	  ,cast(trudpr_f as	numeric (7,2))																					as	LabourIntensivenessDesignFact	--(trudpr_f) --Трудоемкость проектирования  фактическая
	  ,s.id																												as OldOsproid
	 --,prodT.id																											as ProdID
	  ,LTRIM(RTRIM(cast((iif (z.[dop] is not null,z.[dop],zay.[dop])) as varchar(3500)))) as AddInformation   
	  ,IIF(((iif (z.[dop] is not null,z.[dop],zay.[dop])) like '%в мет. не%' or (iif (z.[dop] is not null,z.[dop],zay.[dop])) like '%в металле не изг%'),0,1)   as IsMakeInMetal
	  	  ,cast(koltex as	smallint)		as					AmountEquipmentForOper	
	  ,LTRIM(RTRIM(cast(prim as varchar (50))))	as						Note		
	  ,LTRIM(RTRIM(cast(naosnsl as	varchar (50))))	as					NameOsnastTechnolog	
	  ,cast(kl as bit)			as							IsHandOverDraft				
	  ,cast(iif(zay.trud<0 or zay.trud is null, 0,zay.trud )as	numeric(7,2))as			LaborManufacturingAssume	
  FROM Osnastka.TechOrder t
  join proos z on t.OldProosID = z.tzakpred 
  left join os_pro s on s.zak_1 = t.YearTechOrd
  left join zayvka zay on zay.predtz = t.OldZayvkaid 
      left join (select o.OsnastkaByDraftID,Workplace,OperationCode,df.Draft as Draft, osf.Draft as DraftOsn from Osnastka.OsnastkaByDraft o
  join FullDraftList df on df.DraftID = o.DraftID
  join FullDraftList osf on osf.DraftID = o.OsnastkaID) as OD on  
  OD.Workplace = zay.rab_m and OD.OperationCode = zay.kodop and OD.Draft = zay.Draft and
   OD.DraftOsn = iif(z.draftosn is null, cast(zay.draftosn as numeric(13,2)),cast(z.draftosn as numeric(13,2))) 
  left join FullDraftList f1 on 
	iif(z.draftosn is null, cast(zay.draftosn as numeric(13,2)),cast(z.draftosn as numeric(13,2))) = f1.draft 
  left join FullDraftList f2 on 
	cast(z.draftzap as numeric(13,2)) = f2.draft
  where t.IsApplicationFrom=1 

--объединение с osnsv --не
--select * from Osnastka.DraftOsnast
--update Osnastka.DraftOsnast 
--set OsnastkaByDraftID = g.OsnastkaByDraftID
--from
--(
--select 
--T.OsnastkaByDraftID, d.DraftOsnastID
--from Osnastka.OsnastkaByDraftList T
--join (
--select dra.DraftOsn from Osnastka.DraftOsnast dra
--join Osnastka.TechOrder tec on dra.TechOrderID = tec.TechOrderID
--) as D on T.OsnastkaID = D.DraftOsn
--) as g
--where Osnastka.DraftOsnast.YearTechOrd ='' and Osnastka.DraftOsnast.DraftOsnastID = g.DraftOsnastID
