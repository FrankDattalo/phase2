select fName, lName from Customer where customerId in (select CID from Room)
intersect
select fName, lName from Customer where customerId in (select CID from Reserves_For_Event);