go
create view vOsnastUseList as
select 
o.OsnastUseListID as OsnastUseListID
,df.Draft as Draft
,osf.Draft as Osnast 
,rd.ReferenceName as DraftName
,ros.ReferenceName as OsnastName
,Workplace as WorkplaceID
,ob.code as WorkplaceCode
,ob.oborud as WorkplaceMachine
,ob.cex as Workshop
,wo.StoreroomOsnast as StoreroomOsnast
,OperationCode as OperationCodeID
,so.oper as Operation
,so.cex as OperationCex
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
create view vOsnastTechOrder as
select 
o.OsnastOrderID as OsnastOrderID
,df.Draft as Draft
,osf.Draft as Osnast 
,rd.ReferenceName as DraftName
,ros.ReferenceName as OsnastName
,Workplace as WorkplaceID
,ob.code as WorkplaceCode
,ob.oborud as WorkplaceMachine
,ob.cex as Workshop
,wo.StoreroomOsnast as StoreroomOsnast
,OperationCode as OperationCodeID
,so.oper as Operation
,so.cex as OperationCex

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
,o.YearTechOrd

OsnastUseListID
,Ksi
,DateEmployeeApproved
,IsStatusEmployeeApproved   
,DateEmployeeFinalApproved
,DateEmployeeApprovedProject
,InterOsnastID --тут
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
from Osnastka.OsnastOrder o
left join Osnastka.TechOrder t on t.TechOrderID = o.TechOrderID
left join DraftInfoFull df on df.DraftID = t.DraftID
left join DraftInfoFull osf on osf.DraftID = o.OsnastID
left join ReferenceInformation rd on rd.ReferenceInformationID = df.DraftNameID
left join ReferenceInformation ros on ros.ReferenceInformationID = osf.DraftNameID
left join oborud ob on ob.rab_m = t.Workplace
left join s_oper so on so.code = t.OperationCode
left join Workshop wo on wo.Workshop = ob.cex
go
--drop view vOsnastUseList
select * from Osnastka.OsnastUseList
select * from vOsnastUseList
select * from oborud
select * from s_oper
select * from Workshop