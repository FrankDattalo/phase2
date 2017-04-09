-- Query 1: Retrieve information of customers who have been billed in the last 1000 days
select c.customerId, c.fName, c.lName, c.BID
from Customer c
inner join Bill b on b.CID = c.customerId
where b.billingDate > dateAdd(day, -1000, getdate());

-- Query 2: Select names of customers who have both reserved a room for an event and for stay

-- Query 3: Select number, id, and address of branch and amount of people currently staying at that branch
select b.branchId, b.phoneNo, b.address, count(c.customerId) as count
from Customer c
inner join Branch b on b.branchId = c.BID
group by b.branchId, b.address, b.phoneNo;

-- Query 4: Names of customers who have attended a specific event

-- Query 5: Retrieve the name and number of branch and amount and the total food cost for the past 1000 days
select b.branchId, b.phoneNo, sum(f.invoice) as cost
from Branch b
inner join Purchases_Food f on f.BID = b.branchId
where f.purchaseDate > dateAdd(day, -1000, getDate())
group by b.branchId, b.phoneNo;

-- Query 6: Retrieve the ssn and name of workers managed by a specific corporate office