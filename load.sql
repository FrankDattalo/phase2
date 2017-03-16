-- Step 1. Create Tables

create table Branch (
branchId int not null, 
phoneNo varchar(15) not null, 
address varchar(50) not null, 
RName varchar(30) not null, 
primary key (branchId)
);

create table Region (
name varchar(15) not null, 
description text not null, 
timeZone char(4) not null, 
COfficeID int not null, 
primary key (name)
);

create table Corporate_Office (
officeId int not null, 
address varchar(50) not null, 
phoneNo varchar(15) not null, 
openHours time not null, 
closeHours time not null, 
primary key (officeId)
);

create table Worker (
ssn int not null, 
fName varchar(15) not null, 
mInit char(1) not null, 
lName varchar(15) not null, 
bDate date not null, 
address varchar(50) not null, 
sex char(1) not null, 
salary int not null, 
startDate date not null, 
BID int not null, 
PTitle varchar(20) not null, 
appointedOn date not null, 
primary key (ssn)
);

create table Position (
title varchar(20) not null, 
-- salary int not null, -- TODO: maybe remove this? Since workers already have a salary
description text not null, 
primary key (title)
);

create table Facility (
facilityId int not null, 
description text not null, 
type varchar(20) not null, 
openTime time not null, 
closeTime time not null, 
BID int not null, 
primary key (facilityId, BID) 
);

create table Room (
roomNo int not null, -- TODO: roomNo is unique among branches, but not unique among all rooms (Branch 1 and 3 both have room 101)
status varchar(20) not null, 
cost int not null, 
maxOccupancy int not null, 
BID int not null, 
RTName varchar(30) not null, 
CID int, 
-- RNumber int not null, -- TODO: Dont know what this is?
startTime date, 
endTime date, 
primary key (roomNo, BID)
);

create table Room_Type (
name varchar(30) not null, 
description text not null, 
primary key (name)
);

create table Customer (
customerId int not null, 
fName varchar(15) not null, 
mInit char(1) not null, 
lName varchar(15) not null, 
cardNo int not null, 
dateOfBirth date not null, 
BID int not null, 
primary key (customerId)
);


create table Bill (
billNo int not null, 
billingDate date not null, 
description text not null, 
cost int not null, 
CID int not null, 
primary key (billNo, CID)
);

create table Request (
requestId int not null, 
description text not null, 
type varchar(20) not null, 
price int not null, 
CID int not null, 
primary key (requestId, CID)
);

create table Attends (
CID int not null, 
EID int not null, 
primary key (CID, EID)
);

create table Event (
eventId int not null, 
name varchar(50) not null, 
price int not null, 
-- noOfAttendees int not null, -- TODO: this can be removed as we can figure this out through the Attends relationship
startDate date not null, 
endDate date not null, 
BID int not null, 
primary key (eventId)
);

create table Can_Reserve (
EID int not null, 
RTName varchar(30) not null, 
primary key(EID, RTname)
);

create table Reserves_For_Event (
CID int not null, 
RNumber int not null, 
EID int not null, 
primary key(CID, RNumber, EID)
);

create table Reserves (
BID int not null, 
RNumber int not null, 
EID int not null, 
primary key(BID, RNumber, EID)
);

create table Supply (
itemName varchar(15) not null, 
description text not null, 
price int not null, 
primary key (itemName)
);

create table Supplier (
sid int not null,
name varchar(15) not null,
description text not null,
address varchar(50) not null,
phoneNo varchar(15) not null,
primary key (sid)
);

create table Food (
itemName varchar(15) not null, 
description text not null, 
perishDate date not null, 
price int not null, 
primary key (itemName)
);

create table Vehicle (
licensePlateNo varchar(7) not null, 
manufacturer varchar(15) not null, 
model varchar(15) not null, 
color varchar(10) not null, 
type varchar(10) not null, 
price int not null, 
primary key (licensePlateNo)
);

create table Purchases_Supply (
invoice int not null, 
quantity int not null, 
purchaseDate date not null, 
fulfillmentDate date, 
BID int not null, 
SID int not null, 
Item varchar(15) not null, 
primary key (invoice, BID, SID, Item)
);

create table Purchases_Food (
invoice int not null, 
quantity int not null, 
purchaseDate date not null, 
fulfillmentDate date, 
BID int not null, 
SID int not null, 
Item varchar(15) not null, 
primary key (invoice, BID, SID, Item)
);

create table Purchases_Vehicle (
invoice int not null, 
quantity int not null, 
purchaseDate date not null, 
fulfillmentDate date, 
BID int not null, 
SID int not null, 
PlateNo varchar(15) not null, 
primary key (invoice, BID, SID, PlateNo)
);

-- Step 2. insert values  into Tables
insert into Branch (branchId, phoneNo, address, RName) values 
(1, '1-832-205-4909', '784-1888 Blandit Rd.', 'pacific'), 
(2, '1-398-463-4079', 'P.O. Box 736, 6351 Accumsan Avenue', 'southeast'), 
(3, '1-216-372-3629', '846-5103 Et Street', 'alaska'), 
(4, '1-268-387-3145', '426-5159 Ante. Ave', 'hawaii'), 
(5, '1-477-786-9180', 'P.O. Box 925, 4186 Ipsum. Road', 'central'), 
(6, '1-862-279-5572', 'Ap #402-5617 Mauris Av.', 'central'), 
(7, '1-387-299-1446', 'P.O. Box 832, 5780 Massa. Rd.', 'northeast'), 
(8, '1-696-339-3094', 'Ap #596-1776 Sed Avenue', 'mountain'), 
(9, '1-632-945-6813', '608-9541 Imperdiet Av.', 'pacific'), 
(10, '1-354-771-2751', '790 Dui, Street', 'central');

insert into Region (name, description, timeZone, COfficeId) values  
('pacific', 'Pacific United States region', 'PST', 1), 
('mountain', 'Mountain United States region', 'MST', 2), 
('central', 'Central United States region', 'CST', 3), 
('southeast', 'Southeastern United States region', 'EST', 4), 
('northeast', 'Northeastern United States region', 'EST', 5), 
('alaska', 'Alaskan region', 'AKST', 6), 
('hawaii', 'Hawaiian region', 'HST', 7);

insert into Corporate_Office (officeId, address, phoneNo, openHours, closeHours)  values 
(1, 'Ap #965-8581 Tincidunt Avenue', '1-643-926-9359', '08:00:00', '16:00:00'), 
(2, 'Ap #548-6014 Velit. Street', '1-388-462-2782', '08:00:00', '16:00:00'), 
(3, 'Ap #266-5468 Porttitor Street', '1-770-824-3744', '08:00:00', '16:00:00'), 
(4, '479-6636 Condimentum. Street', '1-149-260-2874', '08:00:00', '16:00:00'), 
(5, 'Ap #867-9390 Lacinia St.', '1-373-762-8447', '08:00:00', '16:00:00'), 
(6, '557-5143 Id, Ave', '1-145-578-4802', '08:00:00', '16:00:00'), 
(7, '132-6053 Purus, St.', '1-774-471-1958', '08:00:00', '16:00:00');

insert into Worker (ssn, fName, mInit, lName, bDate, address, sex, salary, startDate, BID, PTitle, appointedOn) values 
('183153645', 'Sopoline', 'Q', 'House', '11/15/1948', 'P.O. Box 608, 4806 Ut Street', 'M', '46627', '10/18/2011', 1, 'Cook', '06/13/2013'), 
('463131234', 'Megan', 'Q', 'Benjamin', '12/11/1869', 'P.O. Box 329, 370 Ante Avenue', 'F', '45962', '08/24/2006', 2, 'Cook', '08/10/1974'), 
('234127384', 'Madison', 'A', 'Good', '08/18/1938', '599 Feugiat Ave', 'M', '49454', '05/17/1989', 1, 'Worker', '01/05/1920'), 
('235534242', 'Cadman', 'Y', 'Vance', '04/10/1963', 'Ap #525-9797 Ultrices. Av.', 'F', '54201', '07/02/1990', 3, 'Cook', '12/24/1931'), 
('324567213', 'Prescott', 'Y', 'Stephenson', '06/21/1976', 'Ap #299-3098 Vulputate, St.', 'F', '47651', '01/14/2016', 4, 'Worker', '11/08/1992'), 
('704938234', 'Indira', 'D', 'Nixon', '07/02/2008', 'P.O. Box 676, 2183 Dolor St.', 'F', '53908', '03/05/1994', 5, 'Director', '09/07/1923'), 
('463111234', 'Declan', 'F', 'Hester', '10/12/1862', 'P.O. Box 366, 3351 Erat St.', 'M', '50029', '11/29/2016', 1, 'Director', '07/12/1994'), 
('146267824', 'Steel', 'A', 'Banks', '01/14/1985', 'Ap #389-3754 Eget, St.', 'F', '52037', '07/29/2011', 3, 'Accountant', '06/27/2016'), 
('203394856', 'Hayden', 'Q', 'Paul', '12/02/1992', 'P.O. Box 108, 7164 Scelerisque Street', 'M', '48680', '08/17/2002', 1, 'IT', '06/21/1955'), 
('324567443', 'Xander', 'G', 'Weeks', '04/30/1888', 'Ap #347-3349 Quisque Street', 'F', '47560', '06/19/1986', 2, 'Finance', '06/15/2005');

insert into Position(title, description) values  
('Cook', 'This position is great!'), 
('Worker', 'The best position in the company!'), 
('Manager', 'This position is great!'), 
('Director', 'Directs workers'), 
('Head Cook', 'Runs the kitchen'), 
('Security', 'In charge of security'), 
('Accountant', 'Embezzels the company money'), 
('Marketing', 'Prentends to work'), 
('IT', 'Why did we hire them?'), 
('Finance', 'Stops accounting from stealing too much');

insert into Facility (facilityId, description, type, openTime, closeTime, BID) values 
(1, 'Dont listen to others alternative facts, this place is great!', 'Beach', '08:00:00', '01:00:00', '4'), 
(2, 'The best in town!', 'Spa', '08:00:00', '01:00:00', '4'), 
(3, 'The best in town!', 'Laundry', '08:00:00', '01:00:00', '4'), 
(4, 'Dont listen to others alternative facts, this place is great!', 'Gym', '08:00:00', '01:00:00', '1'), 
(5, 'The president as been here.', 'Spa', '08:00:00', '01:00:00', '1'), 
(6, 'Dont listen to others alternative facts, this place is great!', 'Casino', '08:00:00', '01:00:00', '2'), 
(7, 'The best in town!', 'Beach', '08:00:00', '01:00:00', '4'), 
(8, 'Beeeeeeeeer', 'Gym', '08:00:00', '01:00:00', '2'), 
(9, 'Dont listen to others alternative facts, this place is great!', 'Casino', '08:00:00', '01:00:00', '2'), 
(10, 'The best in town!', 'Pool', '08:00:00', '01:00:00', '3');

insert into Facility (facilityId, description, type, openTime, closeTime, BID) values
(31, '8 feet max depth. Diving board.', 'Swimming Pool', '06:00:00', '22:00:00', 3), 
(32, 'Free weights, Machines, 3 Treadmills.', 'Fitness Center', '06:00:00', '22:00:00', 3), 
(33, '5 feet max depth.', 'Swimming Pool', '06:00:00', '22:00:00', 1), 
(34, 'Breakfast diner.', 'Restaurant', '08:00:00', '12:00:00', 2), 
(35, '21 and over bar.', 'Restaurant', '16:00:00', '02:00:00', 4);

insert into Room (roomNo, status, cost, maxOccupancy, BID, RTName, CID, startTime, endTime) values 
(9, 'reserved-by-customer', 724, 7, 4, 'expo-center', 18, '05/01/2016', '05/12/2017'), 
(17, 'open', 105, 6, 2, 'performance-hall', null, null, null), 
(10, 'open', 549, 12, 5, 'meeting-room', null, null, null), 
(2, 'open', 985, 4, 3, 'family', null, null, null), 
(45, 'reserved-by-branch', 889, 5, 6, 'family', null, '01/08/2016', '04/05/2017'), 
(49, 'reserved-by-branch', 633, 5, 6, 'family', null, '01/08/2016', '04/05/2017'), 
(68, 'open', 415, 9, 2, 'baller', null, null, null), 
(42, 'occupied', 326, 11, 10, 'donald', 9, '1/1/1999', '12/1/2017'), 
(76, 'reserved-by-customer', 742, 14, 9, 'baller', 5, '07/03/2016', '08/29/2017'), 
(70, 'occupied', 931, 10, 7, 'baller', 7, '1/2/1999', '1/3/3999'), 
(45, 'open', 433, 11, 5, 'baller', null, null, null), 
(8, 'open', 783, 6, 5, 'baller', null, null, null), 
(58, 'open', 623, 3, 5, 'cost-saver', null, null, null), 
(15, 'reserved-by-branch', 983, 6, 4, 'performance-hall', null, '10/19/2016', '04/15/2017'), 
(84, 'occupied', 173, 2, 3, 'cost-saver', 4, '3/1/2017', '3/2/2017'), 
(82, 'reserved-by-branch', 177, 4, 10, 'donald', null, '04/14/2016', '07/12/2017'), 
(33, 'open', 961, 3, 8, 'baller', null, null, null), 
(48, 'occupied', 984, 12, 6, 'cost-saver', 3, '1/1/1800', '1/1/2999'), 
(27, 'occupied', 898, 5, 1, 'cost-saver', 2, '4/23/2015', '4/23/2018'), 
(40, 'occupied', 940, 2, 6, 'cost-saver', 1, '3/1/2001', '3/1/2020');

insert into Room_Type (name, description) values
('cost-saver', 'the cheapest we got!'), 
('baller', 'when you really just need to spend money'), 
('donald', 'when you need to spend money biggly'), 
('economy', 'the best value'), 
('family', 'for the rascals'), 
('meeting-room', 'for the business calls'), 
('performance-hall', 'where the band plays'), 
('expo-center', 'where we lift weights');

insert into Customer (customerId, fName, mInit, lName, cardNo, dateOfBirth, BID) values
(1, 'Yolanda', 'M', 'Ross', 72139, '04/28/1927', '6'), 
(2, 'Nissim', 'F', 'Hull', 44077, '04/08/1991', '1'), 
(3, 'Joan', 'U', 'Sellers', 12701, '03/30/1914', '6'), 
(4, 'Penelope', 'N', 'Lee', 90367, '11/23/1965', '3'), 
(5, 'Sean', 'T', 'Sampson', 42453, '06/29/1884', '4'),
(6, 'Justina', 'R', 'Guerra', 42340, '07/06/1934', '7'), 
(9, 'Olivia', 'B', 'Alston', 80889, '06/12/1886', '5'), 
(18, 'Raja', 'S', 'Baker', 20902, '12/01/2006', '7');

insert into Bill (billNo, billingDate, description, cost, CID) values
(1, '3/25/2005', 'drinks', 40, 1),
(2, '2/20/2015', 'hosted event', 500, 5),
(3, '5/3/2013', 'cost of room', 200, 1),
(4, '3/1/2015', 'cost of room', 150, 2),
(5, '1/1/1800', 'cost of room', 1, 3),
(7, '3/1/2017', 'cost of room', 250, 4),
(6, '3/3/1999', 'cost of room', 3000, 6),
(8, '1/1/1999', 'cost of room', 30000, 9); 

insert into Request (requestId, description, type, price, CID) values
(3, 'customer requests extra cleaning', 'extra-cleaning', 0, 1), 
(4, 'customer requests extra cleaning', 'extra-cleaning', 0, 9), 
(5, 'customer request personal trainer', 'personal-training', 0, 4), 
(6, 'customer request personal trainer', 'personal-training', 0, 9), 
(7, 'customer request personal trainer', 'personal-training', 0, 4), 
(8, 'customer request personal trainer', 'personal-training', 0, 3), 
(10, 'customer request bottle service for dinner', 'bottle-service', 40, 9), 
(12, 'customer requests breakfast in bed', 'bed-and-breakfast', 0, 6), 
(13, 'customer requests breakfast in bed', 'bed-and-breakfast', 0, 18);

insert into Attends(CID, EID) values
(18, 4), 
(5, 19), 
(67, 20), 
(98, 19), 
(69, 13), 
(67, 15);

insert into Event(eventId, name, price, startDate, endDate, BID) values
(4, 'Business Extravaganza!', '50', '05/01/2016', '05/12/2017', '7'), 
(13, 'Foods of the Word!', '0', '01/08/2016', '04/05/2017', '6'), 
(18, 'Painters United', '100', '10/19/2016', '04/15/2017', '4'), 
(19, 'Tech Expo', '25', '07/03/2016', '08/29/2017', '9'), 
(20, 'History Expo', '10', '04/14/2016', '07/12/2017', '10');

insert into Can_Reserve(EID, RTName) values
(4, 'expo-center'), 
(13, 'family'), 
(19, 'baller'), 
(18, 'performance-hall'), 
(20, 'baller'), 
(20, 'expo-center'), 
(20, 'meeting-room'), 
(20, 'donald');

insert into Reserves_For_Event (CID, RNumber, EID) values
(18, 9, 4),
(5, 76, 19);

insert into Reserves (BID, RNumber, EID) values
(6, 49, 13),
(4, 15, 18),
(10, 82, 20);

insert into Supplier (sid, name, description, address, phoneNo) values
(1, 'Tord Motors', 'They sell cars. Sometimes they work.', '1 Tord Motors Lane', '1-531-578-4802'),
(2, 'Foyota Lexits', 'They sell cars that are cheaper, but less cool.', '9 Horey Sheet St', '1-631-256-1101'),
(3, 'Wolkswagen', 'Oh Yah, Good Vehicles', '1 Wolks Wagen', '1-000-000-0000'),
(4, 'Maples', 'Kind of like staples, but only in Canada', '1 Maple Street', '3-210-123-3456'),
(5, 'Worst Buy', 'How is this place still in business?', '3 Dont Buy From Here Lane', '1-678-456-2345'),
(6, 'Krogert', 'Why does EVERYONE call it Krogerts? THERES NO S AT THE END!', '1 Seriously Though Blvd', '1-567-231-1234'),
(7, 'MallMart', 'You can meet the best people here.', '1 Malton St', '1-673-221-4684');

insert into Supply (itemName, description, price) values 
('rain-drops', 'get', 10),
('drop-tops', 'back to', 20),
('pots-pans', 'the tri-state', 25),
('things-n-stuff', 'If you want to run a hotel will youll need these things.', 45);

insert into Food (itemName, description, perishDate, price) values
('oranges', 'for your immune system!', '3/21/2088', 3000),
('bananas', 'to get some K', '1/23/4567', 10),
('hamburgers', 'but they have cheese', '12/31/2099', 30),
('pasta', 'mmmmmmmmmmmmmm, thats a spicy meatball', '6/30/1900', 50);

insert into Vehicle (licensePlateNo, manufacturer, model, color, type, price) values
('G7C0ZBA', 'Foyota Lexits', 'Crayolla', 'blue', 'sedan', 30000),
('1HTYZBQ', 'Tord', 'Focus ST', 'yellow', 'hatchback', 25000),
('GJ6030S', 'Wolkswagen USA', 'porsche cayman', 'black', 'superfast', 50000);

insert into Purchases_Supply (invoice, quantity, purchaseDate, fulfillmentDate, BID, SID, Item) values
(3, 3, '3/21/2015', '4/22/2015', 1, 4, 'things-n-stuff'),
(4, 4, '3/22/2015', '4/22/2015', 2, 5, 'things-n-stuff'),
(5, 5, '3/23/2015', '4/22/2015', 3, 4, 'things-n-stuff'),
(6, 6, '3/24/2015', '4/22/2015', 4, 5, 'things-n-stuff'),
(7, 7, '3/25/2015', '4/22/2015', 5, 4, 'things-n-stuff'),
(8, 8, '3/26/2015', '4/22/2015', 2, 5, 'things-n-stuff'),
(9, 1, '3/27/2015', '4/22/2015', 3, 4, 'things-n-stuff'),
(10, 2, '3/28/2015', '4/22/2015', 4, 5, 'pots-pans'),
(11, 7, '3/29/2015', '4/22/2015', 5, 4, 'things-n-stuff'),
(12, 8, '4/20/2015', '4/22/2015', 1, 5, 'things-n-stuff'),
(13, 9, '4/21/2015', '4/22/2015', 2, 4, 'things-n-stuff'),
(14, 11, '4/22/2015', '4/22/2015', 3, 5, 'things-n-stuff'),
(15, 23, '2/1/2015', '4/22/2015', 4, 4, 'pots-pans'),
(16, 4, '3/1/2015', '4/22/2015', 5, 5, 'things-n-stuff'),
(17, 2, '3/21/2015', '4/22/2015', 1, 4, 'pots-pans'),
(18, 8, '3/21/2015', '4/22/2015', 2, 5, 'pots-pans'),
(19, 3, '3/21/2015', '4/22/2015', 3, 4, 'pots-pans'),
(20, 2, '3/21/2015', '4/22/2015', 4, 5, 'rain-drops'),
(21, 1, '3/21/2015', '4/22/2015', 5, 4, 'drop-tops');

insert into Purchases_Food (invoice, quantity, purchaseDate, fulfillmentDate, BID, SID, Item) values
(144, 3, '3/21/2015', '4/22/2015', 1, 6, 'oranges'),
(145, 4, '3/21/2015', '4/22/2015', 2, 6, 'oranges'),
(146, 5, '3/21/2015', '4/22/2015', 3, 7, 'oranges'),
(147, 6, '3/21/2015', '4/22/2015', 4, 6, 'oranges'),
(148, 7, '3/21/2015', '4/22/2015', 5, 7, 'oranges'),
(149, 8, '3/21/2015', '4/22/2015', 2, 6, 'bananas'),
(150, 1, '3/21/2015', '4/22/2015', 3, 6, 'bananas'),
(151, 2, '3/21/2015', '4/22/2015', 4, 7, 'bananas'),
(152, 7, '3/21/2015', '4/22/2015', 5, 7, 'bananas'),
(153, 8, '3/21/2015', '4/22/2015', 1, 7, 'hamburgers'),
(154, 9, '3/21/2015', '4/22/2015', 2, 7, 'hamburgers'),
(156, 11, '3/21/2015', '4/22/2015', 3, 6, 'hamburgers'),
(167, 23, '3/21/2015', '4/22/2015', 4, 6, 'hamburgers'),
(192, 4, '3/21/2015', '4/22/2015', 5, 6, 'hamburgers'),
(193, 2, '3/21/2015', '4/22/2015', 1, 7, 'pasta'),
(194, 8, '3/21/2015', '4/22/2015', 2, 6, 'pasta'),
(195, 3, '3/21/2015', '4/22/2015', 3, 7, 'pasta'),
(196, 2, '3/21/2015', '4/22/2015', 4, 7, 'pasta'),
(197, 1, '3/21/2015', '4/22/2015', 5, 6, 'pasta');

insert into Purchases_Vehicle (invoice, quantity, purchaseDate, fulfillmentDate, BID, SID, PlateNo) values 
(200, 1, '6/28/2015', '7/21/2016', 1, 1, 'G7C0ZBA'),
(201, 1, '5/2/2015', '3/1/2017', 2, 2, '1HTYZBQ'),
(202, 1, '2/3/2007', '9/9/2011', 3, 3, 'GJ6030S');

-- Step 3. Update Tables to Add Constraints

-- Step 4. Add Triggers To Tables
-- Trigger 1: if event is created and has over 1000 people, give $100 discount
-- Trigger 2: if room is reserved for a week or more, discount $50
