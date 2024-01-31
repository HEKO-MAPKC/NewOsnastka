go
drop view Osnastka.vResPart
go
create view Osnastka.vResPart as
SELECT ROW_NUMBER() OVER( ORDER BY OsnastUseListID ) AS id, *
FROM(
select 
OsnastUseListID as OsnastUseListID
,Osn.Draft as Draft
,Osn.DraftName as DraftName
,osf.Draft as Osnast 
,ros.ReferenceName as OsnastName
,df.Draft as ResPart 
,rd.ReferenceName as ResPartName
,Osn.WorkplaceID as WorkplaceID
,ob.code as WorkplaceCode
,ob.oborud as WorkplaceMachine
,ob.cex as Workshop
,wo.StoreroomOsnast as StoreroomOsnast
,Osn.OperationCodeID as OperationCodeID
,so.oper as Operation
,so.cex as OperationCex
,o.Ksi							
,quant as AmountEquipmentInWorkTogether
,quant as AmountEquipmentForOper  	
,IsHandOverDraft				
,Note							
,Analogue						
,LaborManufacturingAssume	
from ocomplect o
left join Osnastka.vOsnastUseList Osn on Osn.Osnast = o.kuda
left join DraftInfoFull df on df.Draft = o.what
left join DraftInfoFull osf on osf.Draft = o.kuda
left join ReferenceInformation rd on rd.ReferenceInformationID = df.DraftNameID
left join ReferenceInformation ros on ros.ReferenceInformationID = osf.DraftNameID
left join oborud ob on ob.rab_m = Osn.WorkplaceID
left join s_oper so on so.code = Osn.OperationCodeID
left join Workshop wo on wo.Workshop = ob.cex
union
select 
OsnastUseListID as OsnastUseListID
,Osn.Draft as Draft
,Osn.DraftName as DraftName
,osf.Draft as Osnast 
,ros.ReferenceName as OsnastName
,df.Draft as ResPart 
,rd.ReferenceName as ResPartName
,Osn.WorkplaceID as WorkplaceID
,ob.code as WorkplaceCode
,ob.oborud as WorkplaceMachine
,ob.cex as Workshop
,wo.StoreroomOsnast as StoreroomOsnast
,Osn.OperationCodeID as OperationCodeID
,so.oper as Operation
,so.cex as OperationCex
,Ksi							
,AmountEquipmentInWorkTogether as AmountEquipmentInWorkTogether
,AmountEquipmentForOper as AmountEquipmentForOper  	
,IsHandOverDraft				
,Note							
,Analogue						
,LaborManufacturingAssume	
from pomoika o
left join Osnastka.vOsnastUseList Osn on Osn.Osnast = o.draftosn
left join DraftInfoFull df on df.Draft = o.draftzap
left join DraftInfoFull osf on osf.Draft = o.draftosn
left join ReferenceInformation rd on rd.ReferenceInformationID = df.DraftNameID
left join ReferenceInformation ros on ros.ReferenceInformationID = osf.DraftNameID
left join oborud ob on ob.rab_m = Osn.WorkplaceID
left join s_oper so on so.code = Osn.OperationCodeID
left join Workshop wo on wo.Workshop = ob.cex
	) AS MyResults
GO