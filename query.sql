-- Query 1: Retrieve information of customers who have been billed in the last week

-- Query 2: Select names of customers who have both reserved a room for an event and for stay
select fName, lName from Customer where customerId in (select CID from Room)
intersect
select fName, lName from Customer where customerId in (select CID from Reserves_For_Event);

-- Query 3: Select name and number of branch and amount of people currently staying at that branch

-- Query 4: Names of customers who have attended a specific event
select c.fName, c.lName from Customer as c
inner join Attends as a
	on c.customerId = a.CID
inner join Event as e
	on a.EID = e.eventId
where e.name = 'Tech Expo';
-- Query 5: Retrieve the name and number of branch and amount and the total food cost for the past 30 days

-- Query 6: Retrieve the ssn and name of workers managed by a specific corporate office
select w.ssn, w.fName, w.lName from Worker as w
inner join Branch as b
	on w.BID = b.branchId
inner join Region as r
	on b.RName = r.name
inner join Corporate_Office as co
	on r.COfficeID = co.officeId
where co.officeId = 4;