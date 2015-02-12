-- Filter for table
select trim(s.perm_Table_name) as table , substring(trim(info),1,180) as filter, sum(datediff(seconds,starttime,endtime)) as secs, count(*) as num, max(i.query) as query  from stl_explain  p
join stl_plan_info i on ( i.userid=p.userid  and i.query=p.query and i.nodeid=p.nodeid  ) 
join stl_scan s on (s.userid=i.userid and s.query=i.query and  s.segment=i.segment and  s.step=i.step) 
where  s.starttime > dateadd(day, -7, current_Date)
  and   s.perm_table_name not like 'Internal Worktable%'
  and p.info <> ''
  and s.perm_table_name like '%' -- chose table(s) to look for
group by 1,2 order by 1, 4 desc , 3 desc;