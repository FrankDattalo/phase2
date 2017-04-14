select c.fName, c.lName from Customer c
inner join Attends a on c.customerId = a.CID
where not exists (
    select 1 from Room r
    where r.CID = c.customerId
    and r.BID = c.BID);