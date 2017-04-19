select r.roomNo, r.status from Customer as c
right outer join Room as r
	on c.customerId = r.CID
where c.customerId is null;