truncate table Osnastka.DraftOsnast
select * from Osnastka.DraftOsnast where OsnastkaByDraftID is null and DateEmployeeFinalApproved is not null and ksi = 9--8593 --6337

select a.OsnastkaByDraftID,b.OsnastkaByDraftID, a.DraftID , b.DraftID,a.OsnastkaID,b.OsnastkaID,a.Workplace,b.Workplace,a.OperationCode,b.OperationCode from Osnastka.OsnastkaByDraftList a
join Osnastka.OsnastkaByDraftList b on a.DraftID = b.DraftID and a.OsnastkaID = b.OsnastkaID and a.OsnastkaByDraftID <> b.OsnastkaByDraftID where a.OsnastkaByDraftID = 1890733

select * from Osnastka.OsnastkaByDraftList  where  OsnastkaByDraftID = 1890733 or OsnastkaByDraftID = 1890727 or OsnastkaByDraftID = 1890731 

select a.OsnastkaByDraftID, count(*)--,b.OsnastkaByDraftID, a.DraftID , b.DraftID,a.OsnastkaID,b.OsnastkaID,a.Workplace,b.Workplace,a.OperationCode,b.OperationCode 
from Osnastka.OsnastkaByDraftList a
join Osnastka.OsnastkaByDraftList b on a.DraftID = b.DraftID and a.OsnastkaID = b.OsnastkaID and a.OsnastkaByDraftID <> b.OsnastkaByDraftID 
group by a.OsnastkaByDraftID having count(*)>1

select * from proos a
left join osnsv b on a.draftosn = b.draftosn where b.draftosn is null and draftzap = 0 --говорят  что их не надо сувать в новый оснсв

select * from proos a
left join osnsv b on a.draftosn = b.draftosn where b.draftosn is null and draftzap = a.draftosn

select * from DraftInfoFull
select * from ReferenceInformation where ReferenceInformationID = 36964

select * from Osnastka.OsnastOrder
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
DraftID	,
OsnastID,
Workplace,				
OperationCode,
Ksi														
,AmountEquipmentInWorkTogether		  				
,AmountEquipmentForOper   								
,IsHandOverDraft											
,Note														
,Analogue													
,LaborManufacturingAssume		
,OldOsnsvID			
from Osnastka.OsnastUseList o
select * from osnsv
select * from Osnastka.vResPart where OsnastUseListID=1
update Osnastka.OsnastUseList set draftID = 1 where OsnastUseListID=1
select * from pomoika o where [group] <> 0
select * from vUsersInfoFull where first_name like '%Эль%'
select * from prod order by zak_1
select * from Osnastka.vResPart order by zak_1
SELECT * FROM ReferenceInformation WHERE ReferenceInformationID = 330887