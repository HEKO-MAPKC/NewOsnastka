update proos set cex ='08'	where cex= '8'
update proos set cex='14'	where cex= '014'	
update proos set cex='06�'	where cex= '6�'	
update proos set cex='10'	where cex= '010'	
update proos set cex='01�'	where cex= '013'	
update proos set cex='06'	where cex= '6'		
update proos set cex='09'	where cex= '9'		
update proos set cex='14�'	where cex= '14M'	
update proos set cex='01�'	where cex= '1�'
update proos set cex='14�'	where cex= '14X'	
update proos set cex='11'	where cex= '011'	
update proos set cex='05'  where cex=  '5'	
update proos set rem_izg='-'  where rem_izg=   ''	
update proos set rem_izg='������'  where rem_izg=   '�����'	
--draft
update zayvka set draft=(select top(1) draft from zayvka where zak_1 = '10-6700') where zak_1 = '10-6700'	
update zayvka set draft=(select top(1) draft from zayvka where zak_1 = '10-6631') where zak_1 = '10-6631'	
update zayvka set draft=(select top(1) draft from zayvka where zak_1 = '09-4320') where zak_1 = '09-4320'	
--zakaz
update zayvka set zakaz=(select top(1) zakaz from zayvka where zak_1 = '15-4359') where zak_1 = '15-4359'	
update zayvka set zakaz=(select top(1) zakaz from zayvka where zak_1 = '15-4546') where zak_1 = '15-4546'	
update zayvka set zakaz=(select top(1) zakaz from zayvka where zak_1 = '15-4419') where zak_1 = '15-4419'	
update zayvka set nom=(select top(1) nom from zayvka where zak_1 = '15-4359') where zak_1 = '15-4359'	
update zayvka set nom=(select top(1) nom from zayvka where zak_1 = '15-4546') where zak_1 = '15-4546'	
update zayvka set nom=(select top(1) nom from zayvka where zak_1 = '15-4419') where zak_1 = '15-4419'	
--AuthorTechnolog
update zayvka set imyt='�������' where zak_1 = '20-3084'	
--ndraftiz
update zayvka set ndraftiz=(select top(1) ndraftiz from zayvka where zak_1 = '19-2209' and grafik_id is not null) where zak_1 = '19-2209'	
update zayvka set ndraftiz=(select top(1) ndraftiz from zayvka where zak_1 = '13-3070' and grafik_id is not null) where zak_1 = '13-3070'	
update zayvka set ndraftiz=(select top(1) ndraftiz from zayvka where zak_1 = '14-3457' and grafik_id is not null) where zak_1 = '14-3457'	
update zayvka set ndraftiz='����� ����������' where zak_1 = '12-1342'	
--prim_an
update zayvka set prim_an=(select top(1) prim_an from zayvka where zak_1 = '13-2460') where zak_1 = '13-2460'	
update zayvka set prim_an=(select top(1) prim_an from zayvka where zak_1 = '13-2545') where zak_1 = '13-2545'	
update zayvka set prim_an=(select top(1) prim_an from zayvka where zak_1 = '09-5102') where zak_1 = '09-5102'	
update zayvka set prim_an=(select top(1) prim_an from zayvka where zak_1 = '11-1042') where zak_1 = '11-1042'	
update zayvka set prim_an=(select top(1) prim_an from zayvka where zak_1 = '09-5210') where zak_1 = '09-5210'	
update zayvka set prim_an=(select top(1) prim_an from zayvka where zak_1 = '10-5733') where zak_1 = '10-5733'	
--imyk
update zayvka set imyk='�������' where zak_1 = '15-4359'	
update zayvka set imyk='������' where zak_1 = '19-1250'	
update zayvka set imyk='�������' where zak_1 = '16-6004'	
update zayvka set imyk=(select top(1) imyk from zayvka where zak_1 = '09-5110') where zak_1 = '09-5110'	
update zayvka set imyk='�������' where zak_1 = '14-3276'	
update zayvka set imyk='�������' where zak_1 = '20-3199'	
--proos
insert into Osnastka.TechOrder (IsApplicationFrom,Draft, FactoryOrder, FactoryNumberOrder,WorkshopID,NameDraftProduct,TechOrd,TypeOsnast,ReasonProduction,DateLimitation,AuthorTechnolog,DateCreateApplication,
								AuthorConstructor, AuthorBoss,IsReturnedToTechnolog, DateReturnedToTechnolog, ReasonReturnedToTechnolog, IsAtConstructor, DateAtConstructor, DateAtApproval, RepairOrProduction, DateChangeTechnolog, YearTechOrd
								,OperationCode
								,Workplace
								--,Ksi						
								--,AmountEquipmentForOper	
								,DepartmentTechnolog		
								--,Note					
								,DraftProduct				
								,Analogue				
								--,NameOsnastTechnolog	
								--,IsHandOverDraft			
								--,LaborManufacturingAssume
								,DateWorkChiefConstructor
								,OldProosID	
								,OldZayvkaID
								--,IsMakeInMetal
								)
SELECT 1 as IsApplicationFrom
      ,cast(p.[draft] as numeric (13,2)) as Draft      
      ,cast(p.[zakaz] as smallint) as FactoryOrder
      ,cast([num] as smallint) as FactoryNumberOrder
      ,iif (w.WorkshopID is null, 1,w.WorkshopID) as WorkshopID --------------------------------------------------- ����� ����������� ��� � �������� (cex + klad)	  
      ,LTRIM(RTRIM(cast([izd] as varchar (50)))) as NameDraftProduct
      ,cast(p.[tzak] as smallint) as TechOrd
      ,r.ReferenceInformationID as TypeOsnast ------------------------------------------
      ,LTRIM(RTRIM(cast([prichina] as varchar(50)))) as ReasonProduction      
      ,cast([srok] as datetime) as DateLimitation
      ,LTRIM(RTRIM(cast([who] as varchar(20)))) as AuthorTechnolog
      ,cast([dt_who] as datetime) as DateCreateApplication
      ,LTRIM(RTRIM(cast(imyk  as varchar(20)))) as AuthorConstructor
	  ,LTRIM(RTRIM(cast(boss  as varchar(20)))) as AuthorBoss
      ,[back] as IsReturnedToTechnolog
      ,cast([dt_back] as datetime) as DateReturnedToTechnolog
      ,LTRIM(RTRIM(cast([why_back] as varchar(300)))) as ReasonReturnedToTechnolog
      ,[toko] as IsAtConstructor
      ,cast([dt_toko]  as datetime) as DateAtConstructor
      ,cast([dt_izg] as datetime) as DateAtApproval
      ,f.ReferenceInformationID as RepairOrProduction -------------------
      ,cast([dt_corr] as datetime) as DateChangeTechnolog
      ,LTRIM(RTRIM(cast(iif(p.[zak_1] is null, '', p.zak_1) as varchar(7)))) as YearTechOrd
	  ,iif(op.code is null,null,op.code) as OperationCode
	  ,iif(ob.rab_m is null,null,ob.rab_m) as Workplace

	  --,cast(ksi as		smallint)		as					Ksi							
	  --,cast(koltex as	smallint)		as					AmountEquipmentForOper	
	  ,LTRIM(RTRIM(cast(kpod as varchar(5))))		as						DepartmentTechnolog		
	  --,LTRIM(RTRIM(cast(prim as varchar (50))))	as						Note						
	  ,cast(draftiz as	numeric (13,2)) as					DraftProduct				
	  ,LTRIM(RTRIM(cast(prim_an as	varchar (20))))	as					Analogue				
	  --,LTRIM(RTRIM(cast(naosnsl as	varchar (50))))	as					NameOsnastTechnolog	
	  --,cast(kl as bit)			as							IsHandOverDraft				
	  --,cast(iif(pr.trud<0 or pr.trud is null, 0,pr.trud )as	numeric(7,2))as			LaborManufacturingAssume			
	  ,cast(dt_ko as datetime)		as						DateWorkChiefConstructor	
	  
	  ,cast(tzakpred as int)		as						OldProosID	
		  ,predtz as OldZayvkaid	
	  --,IIF((pr.dop like '%� ���. ��%' or pr.dop like '%� ������� �� ���%'),0,1)   as IsMakeInMetal
  FROM [FOX].[dbo].[proos] p
  left join Workshop w on Rtrim(LTrim(p.cex)) = w.Workshop 
  left join ReferenceInformation r on r.ReferenceInformationID = p.nvid+2 and r.ReferenceInformationID<=20 --��� ����������
  left join ReferenceInformation f on f.ReferenceName = rtrim(p.rem_izg) and f.ReferenceInformationID<=20 --��� ����������
  left join zayvka pr on pr.zak_1 = p.zak_1 
  left join os_pro os on os.zak_1 = p.zak_1
  left join oborud ob on os.rab_m = ob.rab_m
  left join s_oper op on op.code = os.oper
  order by p.tzakpred, pr.id
--��������� ������� zak_1 zayvka
--drop table Osnastka.DraftOsnast
--truncate table Osnastka.TechOrder
insert into Osnastka.TechOrder (
IsApplicationFrom
,Draft      
,FactoryOrder
,FactoryNumberOrder 
,WorkshopID
,TechOrd
--,AddInformation         --������� 
,DateCreateApplication					
--,AmountEquipmentForOper  --������� 
,AuthorTechnolog			
,DateChangeTechnolog		
,DepartmentTechnolog		
--,Note				--�������	
,DraftProduct			
,NameDraftProduct		
,Analogue				
--,NameOsnastTechnolog	-- �������	
--,IsHandOverDraft		-- �������	
--,LaborManufacturingAssume -- �������
,AuthorConstructor		
,DateWorkChiefConstructor
,YearTechOrd
		,OperationCode
		,Workplace
--								,OldZayvkaID
--								,IsMakeInMetal  --������� 
,OldZayvkaid
)
SELECT distinct 0 as													IsApplicationFrom
      ,cast(p.[draft] as numeric (13,2)) as											Draft      
     ,cast(p.[zakaz] as smallint) as							FactoryOrder
      ,cast([nom] as smallint) as							FactoryNumberOrder
      ,iif (w.WorkshopID is null, 1,w.WorkshopID) as WorkshopID--w.WorkshopID as WorkshopID --------------------------------------------------- ����� ����������� ��� � �������� (cex + klad)	  
      ,cast(p.[tzak] as smallint) as							TechOrd
      --,LTRIM(RTRIM(cast(p.[dop] as varchar(3500)))) as						AddInformation            
      ,cast(dza as datetime) as								DateCreateApplication					
	 --,cast(koltex as	smallint)		as					AmountEquipmentForOper
	  ,LTRIM(RTRIM(cast(imyt as varchar (20))))	as						AuthorTechnolog			
	  ,cast(dizmt as datetime)		as						DateChangeTechnolog		
	  ,LTRIM(RTRIM(cast(kpod as varchar(5))))		as						DepartmentTechnolog		
	  --,LTRIM(RTRIM(cast(prim as varchar (50))))	as						Note						
	  ,cast(draftiz as	numeric (13,2)) as					DraftProduct			
	  ,LTRIM(RTRIM(cast(ndraftiz as varchar (50))))	as					NameDraftProduct		
	  ,LTRIM(RTRIM(cast(prim_an as	varchar (20))))	as					Analogue				
	  --,LTRIM(RTRIM(cast(naosnsl as	varchar (50))))	as					NameOsnastTechnolog	
	  --,iif(kl = 0,null,iif(kl = 1,0,1))			as							IsHandOverDraft				
	  --,cast(iif(p.trud<0, 0,p.trud )as	numeric(7,2))as			LaborManufacturingAssume	
	  ,LTRIM(RTRIM(cast(imyk as varchar(20))))	as						AuthorConstructor				
	  ,cast(dt_ko as datetime)		as						DateWorkChiefConstructor		
      ,LTRIM(RTRIM(cast(iif(p.[zak_1] is null, '', p.zak_1) as varchar(7)))) as	YearTechOrd
	  	,op.code as OperationCode
		,ob.rab_m as Workplace
	  --,cast(p.id as int)		as							OldZayvkaID	
	  	  --,IIF((p.dop like '%� ���. ��%' or p.dop like '%� ������� �� ���%'),0,1)   as IsMakeInMetal
		  ,predtz as OldZayvkaid
  FROM [FOX].[dbo].zayvka p
  left join  Workshop w on Rtrim(LTrim(p.cexpol)) = w.Workshop 
  left join oborud ob on p.rab_m = ob.rab_m
  left join s_oper op on op.code = p.kodop --LabourManifactureAssume  OldZayvkaId AddInformation Note
  where p.zak_1 = ''
--��������� �� ������� zak_1 zayvka
insert into Osnastka.TechOrder (
IsApplicationFrom
,Draft      
,FactoryOrder
,FactoryNumberOrder 
,WorkshopID
,TechOrd
--,AddInformation         --������� 
,DateCreateApplication					
--,AmountEquipmentForOper  --������� 
,AuthorTechnolog			
,DateChangeTechnolog		
,DepartmentTechnolog		
--,Note				--�������	
,DraftProduct			
,NameDraftProduct		
,Analogue				
--,NameOsnastTechnolog	-- �������	
--,IsHandOverDraft		-- �������	
--,LaborManufacturingAssume -- �������
,AuthorConstructor		
,DateWorkChiefConstructor
,YearTechOrd
		,OperationCode
		,Workplace
--								,OldZayvkaID
--								,IsMakeInMetal  --������� 
--,OldZayvkaid
)
SELECT distinct 0 as													IsApplicationFrom
      ,cast(p.[draft] as numeric (13,2)) as											Draft      
     ,cast(p.[zakaz] as smallint) as							FactoryOrder
      ,cast([nom] as smallint) as							FactoryNumberOrder
      ,iif (w.WorkshopID is null, 1,w.WorkshopID) as WorkshopID--w.WorkshopID as WorkshopID --------------------------------------------------- ����� ����������� ��� � �������� (cex + klad)	  
      ,cast(p.[tzak] as smallint) as							TechOrd
      --,LTRIM(RTRIM(cast(p.[dop] as varchar(3500)))) as						AddInformation            
      ,cast(dza as datetime) as								DateCreateApplication					
	 --,cast(koltex as	smallint)		as					AmountEquipmentForOper
	  ,LTRIM(RTRIM(cast(imyt as varchar (20))))	as						AuthorTechnolog			
	  ,cast(dizmt as datetime)		as						DateChangeTechnolog		
	  ,LTRIM(RTRIM(cast(kpod as varchar(5))))		as						DepartmentTechnolog		
	  --,LTRIM(RTRIM(cast(prim as varchar (50))))	as						Note						
	  ,cast(draftiz as	numeric (13,2)) as					DraftProduct			
	  ,LTRIM(RTRIM(cast(ndraftiz as varchar (50))))	as					NameDraftProduct		
	  ,LTRIM(RTRIM(cast(prim_an as	varchar (20))))	as					Analogue				
	  --,LTRIM(RTRIM(cast(naosnsl as	varchar (50))))	as					NameOsnastTechnolog	
	  --,iif(kl = 0,null,iif(kl = 1,0,1))			as							IsHandOverDraft				
	  --,cast(iif(p.trud<0, 0,p.trud )as	numeric(7,2))as			LaborManufacturingAssume	
	  ,LTRIM(RTRIM(cast(imyk as varchar(20))))	as						AuthorConstructor				
	  ,cast(dt_ko as datetime)		as						DateWorkChiefConstructor		
      ,LTRIM(RTRIM(cast(iif(p.[zak_1] is null, '', p.zak_1) as varchar(7)))) as	YearTechOrd
	  	,op.code as OperationCode
		,ob.rab_m as Workplace
	  --,cast(p.id as int)		as							OldZayvkaID	
	  	  --,IIF((p.dop like '%� ���. ��%' or p.dop like '%� ������� �� ���%'),0,1)   as IsMakeInMetal
		  --,predtz as OldZayvkaid
  FROM [FOX].[dbo].zayvka p
  left join  Workshop w on Rtrim(LTrim(p.cexpol)) = w.Workshop 
  left join oborud ob on p.rab_m = ob.rab_m
  left join s_oper op on op.code = p.kodop --LabourManifactureAssume  OldZayvkaId AddInformation Note
  left join proos pr on p.zak_1 = pr.zak_1 
  where p.zak_1 <> '' and pr.zak_1 is null



--������ AuthorTechnolog
update Osnastka.TechOrder set AuthorTechnolog = '�����������'	where AuthorTechnolog = '����������' 
update Osnastka.TechOrder set AuthorTechnolog = '���������'		where AuthorTechnolog = '����������' 
update Osnastka.TechOrder set AuthorTechnolog = '�����'			where AuthorTechnolog = '����� ��' 
update Osnastka.TechOrder set AuthorTechnolog = '������'		where AuthorTechnolog = '������ ��' 
update Osnastka.TechOrder set AuthorTechnolog = '�����'			where AuthorTechnolog = '����� ��' 
update Osnastka.TechOrder set AuthorTechnolog = '�������'		where AuthorTechnolog = '���������' 
update Osnastka.TechOrder set AuthorTechnolog = '�����'			where AuthorTechnolog = '������' 
update Osnastka.TechOrder set AuthorTechnolog = '�������'		where AuthorTechnolog = '��������'
update Osnastka.TechOrder set AuthorTechnolog = '������'		where AuthorTechnolog = '������ �� '
update Osnastka.TechOrder set AuthorTechnolog = '�����'			where AuthorTechnolog = '����� ��' 


update Osnastka.TechOrder set AuthorConstructor = '�����������'     where AuthorConstructor = '����������' 
update Osnastka.TechOrder set AuthorConstructor = '������'			where AuthorConstructor = '������ �.' 
update Osnastka.TechOrder set AuthorConstructor = '������'			where AuthorConstructor = '��������' 
