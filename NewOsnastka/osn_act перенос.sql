--починка того что не соединилось
update osn_act set dza = '2019-03-28' where tzak = 1289 and dza = '2019-04-26'
update osn_act set dza = '2014-12-15' where tzak = 4004 and dza = '2013-10-31'
update osn_act set dza = '2015-06-17' where tzak = 4494 and dza = '2016-02-24'
--в оснсв где норм всё соединилось
--insert into osnsv(
draft,
rab_m,
kpodrt,
kodop,
ksi,
klo,
naimosn,
koltex,
kprt,
dizmt,
imyt,
dokt,
draftosn,
kl,
dizmk,
imyk,
tzak,
prim_an,
prim,
trud
) 
select 
--o.dza as dza,
iif (z.draft is not null,z.draft,p.draft) as draft,
iif (z.rab_m is not null,z.rab_m,os.rab_m) as rab_m,
z.kpodrt as kpodrt,
iif (z.kodop is not null,z.kodop,os.oper) as kodop,
z.ksi as ksi,
z.klo as klo,
o.naimosn as naimosn,
z.koltex as koltex,
iif (z.dizmt is not null,z.dizmt,p.dt_corr) as dizmt,
z.imyt as imyt,
o.draftosn as draftosn,
z.kl as kl,
z.dizmk as dizmk,
z.imyk as imyk,
o.tzak as tzak,
z.prim_an as prim_an,
z.prim as prim,
z.trud as trud,
concat (substring(cast( year(o.dza) as varchar),3,4),'-',cast(o.tzak as varchar))
from osn_act o
left join zayvka z ON (z.id = (SELECT MIN(t2_.id) 
FROM zayvka t2_ WHERE (t2_.tzak = o.tzak and t2_.dza = o.dza ))) --так нельзя, надо по зак_1
left join proos p on p.tzak = o.tzak and cast(p.dt_who as date) = o.dza
left join os_pro os on p.zak_1 = os.zak_1
where (z.draft is not null or p.draft is not null) and o.tzak <> 9999 and o.tzak <> 0 order by tzak
--где тзак = 9999
--insert into osnsv(
draft,
rab_m,
kpodrt,
kodop,
ksi,
klo,
naimosn,
koltex,
kprt,
dizmt,
imyt,
dokt,
draftosn,
kl,
dizmk,
imyk,
tzak,
prim_an,
prim,
trud
) 
select 
--b.dza as dza,
b.draft as draft,
b.rab_m as rab_m,
b.kpodrt as kpodrt,
b.kodop as kodop,
b.ksi as ksi,
b.klo as klo,
b.naimosn as naimosn,
b.koltex as koltex,
b.dizmt as dizmt,
b.imyt as imyt,
a.draftosn as draftosn,
b.kl as kl,
b.dizmk as dizmk,
b.imyk as imyk,
b.tzak as tzak,
b.prim_an as prim_an,
b.prim as prim,
b.trud as trud 
from osn_act a
left join osnsv b on floor(a.draftosn) = FLOOR(b.draftosn) and a.dza = b.dizmt
where a.tzak = 9999 and b.draft is not null





--дальше мусор
select * from osn_act where tzak = 316	--2018-05-17 --удалиить

select * from zayvka where tzak = 1289	--2019-04-26	
select * from osn_act where tzak = 1289 and dza = '2019-04-26' --поменять на 2019-03-28

select * from zayvka where tzak = 4004	--2013-10-31
select * from osn_act where tzak = 4004 and dza = '2013-10-31' --поменять на 2014-12-15

select * from zayvka where tzak = 4494	--2016-02-24	
select * from osn_act where tzak = 4494 and dza = '2016-02-24' --поменять на 2015-06-17

select * from zayvka where tzak = 4947	--2016-02-16	
select * from osn_act where tzak = 4947 and dza = '2016-02-16' --удалить

select * from zayvka where tzak = 5571	--2010-01-11
select * from osn_act where tzak = 5571 and dza = '2010-01-11' --удалить

select * from proos where  tzak = 9666	--2019-03-15 --удалить

select 
*
from osn_act a
left join osnsv b on floor(a.draftosn) = FLOOR(b.draftosn) and a.dza = b.dizmt
where a.tzak = 9999 and b.draft is null --удалить
--нужно решить с
select 
*
from osn_act a
left join osnsv b on floor(a.draftosn) = FLOOR(b.draftosn) and a.dza = b.dizmt
where a.tzak = 9999 and b.draft is null
--и с этим 
select 
--o.dza as dza,
iif (z.draft is not null,z.draft,p.draft) as draft,
iif (z.rab_m is not null,z.rab_m,os.rab_m) as rab_m,
z.kpodrt as kpodrt,
iif (z.kodop is not null,z.kodop,os.oper) as kodop,
z.ksi as ksi,
z.klo as klo,
o.naimosn as naimosn,
z.koltex as koltex,
iif (z.dizmt is not null,z.dizmt,p.dt_corr) as dizmt,
z.imyt as imyt,
o.draftosn as draftosn,
z.kl as kl,
z.dizmk as dizmk,
z.imyk as imyk,
o.tzak as tzak,
z.prim_an as prim_an,
z.prim as prim,
z.trud as trud,
concat (substring(cast( year(o.dza) as varchar),3,4),'-',cast(o.tzak as varchar))
from osn_act o
left join zayvka z ON (z.id = (SELECT MIN(t2_.id) 
FROM zayvka t2_ WHERE (t2_.tzak = o.tzak and t2_.dza = o.dza ))) --так нельзя, надо по зак_1
left join proos p on p.tzak = o.tzak and cast(p.dt_who as date) = o.dza
left join os_pro os on p.zak_1 = os.zak_1
where (z.draft is null and p.draft is null) and o.tzak <> 9999 and o.tzak <> 0 order by tzak
--дальше мусор
select 
o.dza as dza,
iif (z.draft is not null,z.draft,p.draft) as draft,
iif (z.rab_m is not null,z.rab_m,os.rab_m) as rab_m,
z.kpodrt as kpodrt,
iif (z.kodop is not null,z.kodop,os.oper) as kodop,
z.ksi as ksi,
z.klo as klo,
o.naimosn as naimosn,
z.koltex as koltex,
z.dizmt as dizmt,
z.imyt as imyt,
o.draftosn as draftosn,
z.kl as kl,
z.dizmk as dizmk,
z.imyk as imyk,
o.tzak as tzak,
z.prim_an as prim_an,
z.prim as prim,
z.trud as trud,
concat (substring(cast( year(o.dza) as varchar),3,4),'-',cast(o.tzak as varchar))
from osn_act o
left join zayvka z ON (z.id = (SELECT MIN(t2_.id) 
FROM zayvka t2_ WHERE (t2_.tzak =  o.tzak and t2_.dza = o.dza))) --так нельзя, надо по зак_1
left join proos p on p.zak_1 = z.zak_1
left join os_pro os on p.zak_1 = os.zak_1
where z.draft is null and o.tzak <> 9999 and o.tzak <> 0 order by tzak

select *from osn_act where tzak = 0
select * from osnsv
select * from osn_act where tzak = 9999 order by dza desc




select * from zayvka where dza = '2023-02-17'
--select * from osnsv where naimosn like '%Клин д/отжима шпонки при насадке кольца%'
select * from osnsv where draftosn like '%20600317000%'
select * from zayvka where tzak = 5332
select * from prod where zak_1 = '23-7420'
select * from zayvka where zak_1 = '23-7420'
select * from proos

select * from zayvka where tzak = 316	--2018-05-17
select * from zayvka where tzak = 1289	--2019-04-26	
select * from zayvka where tzak = 4004	--2013-10-31	
select * from zayvka where tzak = 4494	--2016-02-24	
select * from zayvka where tzak = 4947	--2016-02-16	
select * from zayvka where tzak = 5571	--2010-01-11
select * from proos where  tzak = 9666	--2019-03-15
select * from osn_act

select distinct
o.dza as dza,
o.tzak as tzak
from osn_act o
left join zayvka z ON (z.id = (SELECT MIN(t2_.id) 
FROM zayvka t2_ WHERE (t2_.tzak = o.tzak and t2_.dza = o.dza)))
left join proos p on p.tzak = o.tzak and cast(p.dt_who as date) = o.dza
left join os_pro os on p.zak_1 = os.zak_1
where (z.draft is null and p.draft is null) and o.tzak <> 9999 and o.tzak <> 0 order by tzak

--insert into Osnastka.DraftOsnast()
select * from osn
