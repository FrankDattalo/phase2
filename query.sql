-- Query 1: Retrieve information of customers who have been billed in the last 1000 days
select c.customerId, c.fName, c.lName, c.BID
from Customer c
inner join Bill b on b.CID = c.customerId
where b.billingDate > dateAdd(day, -1000, getDate());

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

-- Query 6: Retrieve the ssn and name of workers managed by a specific corporate office
select w.ssn, w.fName, w.lName from Worker as w
inner join Branch as b
	on w.BID = b.branchId
inner join Region as r
	on b.RName = r.name
inner join Corporate_Office as co
	on r.COfficeID = co.officeId
where co.officeId = 4;