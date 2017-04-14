select c.fName, c.lName from Customer as c
inner join Attends as a
	on c.customerId = a.CID
inner join Event as e
	on a.EID = e.eventId
where e.name = 'Tech Expo';