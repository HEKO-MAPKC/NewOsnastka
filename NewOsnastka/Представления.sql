go
drop view Osnastka.vOsnastUseList
drop view Osnastka.vOsnastTechOrder
drop view Osnastka.vOsnastUseListJournal
go --œÂ‰ÒÚ‡‚ÎÂÌËÂ Ì‡Á‚‡ÌËÈ // TODO œŒ‘» —»“‹ ¬Œ– ÿŒœ ƒÀﬂ ¬‹ﬁ’ œŒ Œ—Õ—¬
create view vDraftNameList as
select 
d.Draft as Draft
,rd.ReferenceName as Name
from DraftInfoFull d
join ReferenceInformation rd on rd.ReferenceInformationID = d.DraftNameID
go
create view Osnastka.vOsnastUseList as
select 
o.OsnastUseListID as OsnastUseListID
,df.Draft as Draft
,osf.Draft as Osnast 
,rd.ReferenceName as DraftName
,ros.ReferenceName as OsnastName
,Workplace as WorkplaceID
,LTRIM(RTRIM(ob.code)) as WorkplaceCode
,LTRIM(RTRIM(ob.oborud)) as WorkplaceMachine
,LTRIM(RTRIM(ob.cex)) as Workshop
,LTRIM(RTRIM(wo.StoreroomOsnast)) as StoreroomOsnast
,OperationCode as OperationCodeID
,LTRIM(RTRIM(so.oper)) as Operation
,LTRIM(RTRIM(so.cex ))as OperationCex
,Ksi							
,AmountEquipmentInWorkTogether
,AmountEquipmentForOper   	
,IsHandOverDraft				
,Note							
,Analogue						
,LaborManufacturingAssume	
from Osnastka.OsnastUseList o
left join DraftInfoFull df on df.DraftID = o.DraftID
left join DraftInfoFull osf on osf.DraftID = o.OsnastID
left join ReferenceInformation rd on rd.ReferenceInformationID = df.DraftNameID
left join ReferenceInformation ros on ros.ReferenceInformationID = osf.DraftNameID
left join oborud ob on ob.rab_m = o.Workplace
left join s_oper so on so.code = o.OperationCode
left join Workshop wo on wo.Workshop = ob.cex
go
create view Osnastka.vOsnastUseListJournal as
select 
OsnastUseListJournalID
,o.OsnastUseListID as OsnastUseListID
,AuthorChange
,DateChange
,TypeChange
,df.Draft as Draft
,osf.Draft as Osnast 
,rd.ReferenceName as DraftName
,ros.ReferenceName as OsnastName
,Workplace as WorkplaceID
,ob.code as WorkplaceCode
,LTRIM(RTRIM(ob.oborud)) as WorkplaceMachine
,LTRIM(RTRIM(ob.cex)) as Workshop
,LTRIM(RTRIM(wo.StoreroomOsnast)) as StoreroomOsnast
,OperationCode as OperationCodeID
,LTRIM(RTRIM(so.oper)) as Operation
,LTRIM(RTRIM(so.cex)) as OperationCex
,Ksi							
,AmountEquipmentInWorkTogether
,AmountEquipmentForOper   	
,IsHandOverDraft				
,Note							
,Analogue						
,LaborManufacturingAssume	
from Osnastka.OsnastUseListJournal o
left join DraftInfoFull df on df.DraftID = o.DraftID
left join DraftInfoFull osf on osf.DraftID = o.OsnastID
left join ReferenceInformation rd on rd.ReferenceInformationID = df.DraftNameID
left join ReferenceInformation ros on ros.ReferenceInformationID = osf.DraftNameID
left join oborud ob on ob.rab_m = o.Workplace
left join s_oper so on so.code = o.OperationCode
left join Workshop wo on wo.Workshop = ob.cex
go
create view Osnastka.vOsnastTechOrder as
select 
o.OsnastOrderID as OsnastOrderID
,df.Draft as Draft
,osf.Draft as Osnast 
,rd.ReferenceName as DraftName
,ros.ReferenceName as OsnastName
,Workplace as WorkplaceID
,LTRIM(RTRIM(ob.code)) as WorkplaceCode
,LTRIM(RTRIM(ob.oborud)) as WorkplaceMachine
,LTRIM(RTRIM(wo.Workshop)) as Workshop
,LTRIM(RTRIM(wo.StoreroomOsnast)) as StoreroomOsnast
,OperationCode as OperationCodeID
,LTRIM(RTRIM(so.oper)) as Operation
,LTRIM(RTRIM(so.cex)) as OperationCex

,IsApplicationFrom     
,FactoryOrder
,FactoryNumberOrder 
,TechOrd
,DateCreateApplication					
,AuthorTechnolog			
,DateChangeTechnolog		
,DepartmentTechnolog			
,DraftProduct			
,NameDraftProduct		
,Analogue				
,AuthorConstructor		
,DateWorkChiefConstructor
,t.YearTechOrd as YearTechOrd

,OsnastUseListID
,Ksi
,DateEmployeeApproved
,IsStatusEmployeeApproved   
,DateEmployeeFinalApproved
,DateEmployeeApprovedProject
,ind.Draft as InterOsnast --ÚÛÚ
,rind.ReferenceName as InterOsnastName
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
,o.BalanceAccount					
,AmountEquipmentProduceFact		
,DateRecieveTechOrderSPP
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
,ReasonProduction 
,ReasonReturnedToTechnolog
,DateLimitation
,DateAtApproval
,IsAtConstructor
,IsReturnedToTechnolog
,DateReturnedToTechnolog
,DateAtConstructor
,r.ReferenceName as TypeOsnast 
,f.ReferenceName as RepairOrProduction 
from Osnastka.OsnastOrder o
left join Osnastka.TechOrder t on t.TechOrderID = o.TechOrderID
left join DraftInfoFull df on df.DraftID = t.DraftID
left join DraftInfoFull osf on osf.DraftID = o.OsnastID
left join DraftInfoFull ind on ind.DraftID = o.InterOsnastID
left join ReferenceInformation rd on rd.ReferenceInformationID = df.DraftNameID
left join ReferenceInformation ros on ros.ReferenceInformationID = osf.DraftNameID
left join ReferenceInformation rind on rind.ReferenceInformationID = ind.DraftNameID
left join ReferenceInformation r on r.ReferenceInformationID = t.TypeOsnast 
left join ReferenceInformation f on f.ReferenceInformationID = t.RepairOrProduction 
left join oborud ob on ob.rab_m = t.Workplace
left join s_oper so on so.code = t.OperationCode
left join Workshop wo on wo.WorkshopID = t.WorkshopID
go
--select * from Osnastka.OsnastOrder
--select * from oborud
--select * from s_oper
--select * from Workshop
--select * from Osnastka.vOsnastTechOrder
--select * from Osnastka.vOsnastUseList
--select * from Osnastka.vOsnastUseListJournal
--ÚË„„Â˚
go
CREATE TRIGGER OsnastUseList_INSERT
ON Osnastka.OsnastUseList
AFTER INSERT
AS
insert into [Osnastka].OsnastUseListJournal(
OsnastUseListID	
,AuthorChange
,DateChange
,TypeChange					
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
o.OsnastUseListID as OsnastUseListID	
, SUSER_SNAME() as AuthorChange								
, GETDATE() as DateChange						
, 'insert' as TypeChange						
,DraftID	
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
from inserted o
go
CREATE TRIGGER OsnastUseList_Update
ON Osnastka.OsnastUseList
AFTER update
AS
insert into [Osnastka].OsnastUseListJournal(
OsnastUseListID	
,AuthorChange
,DateChange
,TypeChange					
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
o.OsnastUseListID as OsnastUseListID	
, SUSER_SNAME() as AuthorChange								
, GETDATE() as DateChange						
, 'update' as TypeChange						
,DraftID	
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
from deleted o
go
CREATE TRIGGER OsnastUseList_delete
ON Osnastka.OsnastUseList
AFTER delete
AS
insert into [Osnastka].OsnastUseListJournal(
OsnastUseListID	
,AuthorChange
,DateChange
,TypeChange					
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
o.OsnastUseListID as OsnastUseListID	
, SUSER_SNAME() as AuthorChange								
, GETDATE() as DateChange						
, 'delete' as TypeChange						
,DraftID	
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
from deleted o