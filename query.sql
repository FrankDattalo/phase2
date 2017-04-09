-- Query 1: Retrieve the names of all people who attended events but did not reserve rooms
select c.fName, c.lName from Customer c
inner join Attends a on c.customerId = a.CID
where not exists (
    select 1 from Room r
    where r.CID = c.customerId
      and r.BID = c.BID);

-- Query 2: Select names of customers who have both reserved a room for an event and for stay
select fName, lName from Customer where customerId in (select CID from Room)
intersect
select fName, lName from Customer where customerId in (select CID from Reserves_For_Event);

-- Query 3: Select number, id, and address of branch and amount of people currently staying at that branch
select b.branchId, b.phoneNo, b.address, count(c.customerId) as count
from Customer c
inner join Branch b on b.branchId = c.BID
group by b.branchId, b.address, b.phoneNo;

-- Query 4: Names of customers who have attended a specific event
select c.fName, c.lName from Customer as c
inner join Attends as a
	on c.customerId = a.CID
inner join Event as e
	on a.EID = e.eventId
where e.name = 'Tech Expo';

-- Query 5: Retrieve the name and number of branch and total purchase cost for the past 1000 days
select b.branchId, b.phoneNo, sum(invoice) as cost
from (
    select f.BID, f.purchaseDate, f.invoice from Purchases_Food as f
    union all
    select s.BID, s.purchaseDate, s.invoice from Purchases_Supply as s
    union all
    select v.BID, v.purchaseDate, v.invoice from Purchases_Vehicle as v
) as p inner join Branch b on b.branchId = p.BID
where p.purchaseDate > dateAdd(day, -1000, getDate())
group by b.branchId, b.phoneNo;

-- Query 6: Retrieve the branch ID's of branches that have room types of donald or baller
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