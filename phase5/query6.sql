select b.branchId from Branch as b
inner join Room as r
	on b.branchId = r.BID
inner join Room_Type as rt
	on r.RTName = rt.name
where rt.name = 'donald'
union
select b.branchId from Branch as b
inner join Room as r
	on b.branchId = r.BID
inner join Room_Type as rt
	on r.RTName = rt.name
where rt.name = 'baller';