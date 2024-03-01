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
,WorkplaceCode
,WorkplaceMachine
,Workshop
,StoreroomOsnast
,OperationCodeID
,Operation
,OperationCex
,o.Ksi							
,quant as AmountEquipmentInWorkTogether
,quant as AmountEquipmentForOper  	
,IsHandOverDraft				
,Note							
,Analogue						
,LaborManufacturingAssume	
from ocomplect o
left join Osnastka.vOsnastUseList Osn on Osn.Osnast = o.kuda
 join DraftInfoFull df on df.Draft = o.what
 join DraftInfoFull osf on osf.Draft = o.kuda
 join ReferenceInformation rd on rd.ReferenceInformationID = df.DraftNameID
 join ReferenceInformation ros on ros.ReferenceInformationID = osf.DraftNameID
--left join oborud ob on ob.rab_m = Osn.WorkplaceID
--left join s_oper so on so.code = Osn.OperationCodeID
--left join Workshop wo on wo.Workshop = ob.cex
union
select 
OsnastUseListID as OsnastUseListID
,iif(Osn.Draft is not null,Osn.Draft,o.draft) as Draft
,iif(Osn.DraftName is not null,Osn.DraftName,dror.ReferenceName) as DraftName
,osf.Draft as Osnast 
,ros.ReferenceName as OsnastName
,df.Draft as ResPart 
,rd.ReferenceName as ResPartName
,Osn.WorkplaceID as WorkplaceID
,WorkplaceCode
,WorkplaceMachine
,Workshop
,StoreroomOsnast
,Osn.OperationCodeID as OperationCodeID
,Operation
,OperationCex
,Ksi							
,AmountEquipmentInWorkTogether as AmountEquipmentInWorkTogether
,AmountEquipmentForOper as AmountEquipmentForOper  	
,IsHandOverDraft				
,Note							
,Analogue						
,LaborManufacturingAssume	
from pomoika o
left join Osnastka.vOsnastUseList Osn on Osn.Osnast = o.draftosn and Osn.Draft = o.draft
left join DraftInfoFull df on df.Draft = o.draftzap
left join DraftInfoFull osf on osf.Draft = o.draftosn
left join ReferenceInformation rd on rd.ReferenceInformationID = df.DraftNameID
left join ReferenceInformation ros on ros.ReferenceInformationID = osf.DraftNameID
left join DraftInfoFull dro on dro.Draft = o.draft
left join ReferenceInformation dror on dror.ReferenceInformationID = dro.DraftNameID
	) AS MyResults
GO