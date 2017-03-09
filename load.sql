-- Step 1. Create Tables

set DateFormat MDY;

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
	startTime datetime,
	endTime datetime,
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
	name varchar(20) not null,
	price int not null,
	noOfAttendees int not null,
	startDate date not null,
	endDate date not null,
	BID int not null,
	primary key (eventId)
);

create table Can_Reserve (
	EID int not null,
	RTName int not null,
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
	(1,	'1-832-205-4909',	'784-1888 Blandit Rd.',					'pacific'),
	(2,	'1-398-463-4079',	'P.O. Box 736, 6351 Accumsan Avenue',	'southeast'),
	(3,	'1-216-372-3629',	'846-5103 Et Street',					'alaska'),
	(4,	'1-268-387-3145',	'426-5159 Ante. Ave',					'hawaii'),
	(5,	'1-477-786-9180',	'P.O. Box 925, 4186 Ipsum. Road',		'central'),
	(6,	'1-862-279-5572',	'Ap #402-5617 Mauris Av.',				'central'),
	(7,	'1-387-299-1446',	'P.O. Box 832, 5780 Massa. Rd.',		'northeast'),
	(8,	'1-696-339-3094',	'Ap #596-1776 Sed Avenue',				'mountain'),
	(9,	'1-632-945-6813',	'608-9541 Imperdiet Av.',				'pacific'),
	(10, '1-354-771-2751',	'790 Dui, Street',						'central');

insert into Region (name,description,timeZone,COfficeId) values  
	('pacific',		'Pacific United States region',		'PST',	1),
	('mountain',	'Mountain United States region',	'MST',	2),
	('central',		'Central United States region',		'CST',	3),
	('southeast',	'Southeastern United States region', 'EST',	4),
	('northeast',	'Northeastern United States region', 'EST',	5),
	('alaska',		'Alaskan region',					'AKST',	6),
	('hawaii',		'Hawaiian region',					'HST',	7);

insert into Corporate_Office ( officeId , address , phoneNo , openHours , closeHours )  values 
	(1,	'Ap #965-8581 Tincidunt Avenue',	'1-643-926-9359',	'08:00:00',	'16:00:00'),
	(2,	'Ap #548-6014 Velit. Street',		'1-388-462-2782',	'08:00:00',	'16:00:00'),
	(3,	'Ap #266-5468 Porttitor Street',	'1-770-824-3744',	'08:00:00',	'16:00:00'),
	(4,	'479-6636 Condimentum. Street',		'1-149-260-2874',	'08:00:00',	'16:00:00'),
	(5,	'Ap #867-9390 Lacinia St.',			'1-373-762-8447',	'08:00:00',	'16:00:00'),
	(6,	'557-5143 Id, Ave',					'1-145-578-4802',	'08:00:00',	'16:00:00'),
	(7,	'132-6053 Purus, St.',				'1-774-471-1958',	'08:00:00',	'16:00:00');

insert into Worker( ssn , fName , mInit , lName , bDate , address , sex , salary , startDate , BID , PTitle , appointedOn ) values 
	('183153645',	'Sopoline',	'Q',	'House',		'11/15/1948',	'P.O. Box 608, 4806 Ut Street',				'M',	'46627',	'10/18/2011',	1,	'Cook',			'06/13/2013'),
	('463131234',	'Megan',	'Q',	'Benjamin',		'12/11/1869',	'P.O. Box 329, 370 Ante Avenue',			'F',	'45962',	'08/24/2006',	2,	'Cook',			'08/10/1974'),
	('234127384',	'Madison',	'A',	'Good',			'08/18/1938',	'599 Feugiat Ave',							'M',	'49454',	'05/17/1989',	1,	'Worker',		'01/05/1920'),
	('235534242',	'Cadman',	'Y',	'Vance',		'04/10/1963',	'Ap #525-9797 Ultrices. Av.',				'F',	'54201',	'07/02/1990',	3,	'Cook',			'12/24/1931'),
	('324567213',	'Prescott',	'Y',	'Stephenson',	'06/21/1976',	'Ap #299-3098 Vulputate, St.',				'F',	'47651',	'01/14/2016',	4,	'Worker',		'11/08/1992'),
	('704938234',	'Indira',	'D',	'Nixon',		'07/02/2008',	'P.O. Box 676, 2183 Dolor St.',				'F',	'53908',	'03/05/1994',	5,	'Director',		'09/07/1923'),
	('463111234',	'Declan',	'F',	'Hester',		'10/12/1862',	'P.O. Box 366, 3351 Erat St.',				'M',	'50029',	'11/29/2016',	1,	'Director',		'07/12/1994'),
	('146267824',	'Steel',	'A',	'Banks',		'01/14/1985',	'Ap #389-3754 Eget, St.',					'F',	'52037',	'07/29/2011',	3,	'Accountant',	'06/27/2016'),
	('203394856',	'Hayden',	'Q',	'Paul',			'12/02/1992',	'P.O. Box 108, 7164 Scelerisque Street',	'M',	'48680',	'08/17/2002',	1,	'IT',			'06/21/1955'),
	('324567443',	'Xander',	'G',	'Weeks',		'04/30/1888',	'Ap #347-3349 Quisque Street',				'F',	'47560',	'06/19/1986',	2,	'Finance',		'06/15/2005');

insert into Position( title , description ) values  
	('Cook',		'This position is great!'),
	('Worker',		'The best position in the company!'),
	('Manager',		'This position is great!'),
	('Director',	'Directs workers'),
	('Head Cook',	'Runs the kitchen'),
	('Security',	'In charge of security'),
	('Accountant',	'Embezzels the company money'),
	('Marketing',	'Prentends to work'),
	('IT',			'Why did we hire them?'),
	('Finance',		'Stops accounting from stealing too much');

insert into Facility( facilityId , description , type , openTime , closeTime , BID ) values 
	(1,		'Dont listen to others alternative facts, this place is great!',	'Beach',	'08:00:00', '01:00:00', '4'),
	(2,		'The best in town!',												'Spa',		'08:00:00', '01:00:00', '4'),
	(3,		'The best in town!',												'Laundry',	'08:00:00', '01:00:00', '4'),
	(4,		'Dont listen to others alternative facts, this place is great!',	'Gym',		'08:00:00', '01:00:00', '1'),
	(5,		'The president as been here.',										'Spa',		'08:00:00', '01:00:00', '1'),
	(6,		'Dont listen to others alternative facts, this place is great!',	'Casino',	'08:00:00', '01:00:00', '2'),
	(7,		'The best in town!',												'Beach',	'08:00:00', '01:00:00', '4'),
	(8,		'Beeeeeeeeer',														'Gym',		'08:00:00', '01:00:00', '2'),
	(9,		'Dont listen to others alternative facts, this place is great!',	'Casino',	'08:00:00', '01:00:00', '2'),
	(10,	'The best in town!',												'Pool',		'08:00:00', '01:00:00', '3'),
	(11,	'Youve never had better',											'Spa',		'08:00:00', '01:00:00', '7'),
	(12,	'Beeeeeeeeer',														'Casino',	'08:00:00', '01:00:00', '3'),
	(13,	'Sponsored by Dos Equis',											'Casino',	'08:00:00', '01:00:00', '3'),
	(14,	'Youve never had better',											'Laundry',	'08:00:00', '01:00:00', '6'),
	(15,	'Dont listen to others alternative facts, this place is great!',	'Gym',		'08:00:00', '01:00:00', '2'),
	(16,	'The best in town!',												'Pool',		'08:00:00', '01:00:00', '4'),
	(17,	'Youve never had better',											'Beach',	'08:00:00', '01:00:00', '5'),
	(18,	'Beeeeeeeeer',														'Casino',	'08:00:00', '01:00:00', '4'),
	(19,	'Dont listen to others alternative facts, this place is great!',	'Gym',		'08:00:00', '01:00:00', '3'),
	(20,	'Beeeeeeeeer',														'Gym',		'08:00:00', '01:00:00', '3'),
	(21,	'Youve never had better',											'Spa',		'08:00:00', '01:00:00', '4'),
	(22,	'Youve never had better',											'Beach',	'08:00:00', '01:00:00', '8'),
	(23,	'Beeeeeeeeer',														'Casino',	'08:00:00', '01:00:00', '2'),
	(24,	'Beeeeeeeeer',														'Beach',	'08:00:00', '01:00:00', '2'),
	(25,	'The president as been here.',										'Pool',		'08:00:00', '01:00:00', '1'),
	(26,	'The president as been here.',										'Laundry',	'08:00:00', '01:00:00', '9'),
	(27,	'5 stars!',															'Beach',	'08:00:00', '01:00:00', '4'),
	(28,	'5 stars!',															'Spa',		'08:00:00', '01:00:00', '4'),
	(29,	'5 stars!',															'Beach',	'08:00:00', '01:00:00', '1'),
	(30,	'Youve never had better',											'Casino',	'08:00:00', '01:00:00', '10');

insert into Room( roomNo , status , cost , maxOccupancy , BID , RTName , CID , startTime , endTime ) values 
	(9,		'occupied',	724,	6,	5, 'expo-center',		null, null, null), 
	(17,	'open',		105,	6,	2, 'performance-hall',	null, null, null), 
	(10,	'occupied',	549,	12,	5, 'meeting-room',		null, null, null), 
	(29,	'reserved',	426,	7,	4, 'meeting-room',		null, null, null), 
	(100,	'open',		932,	9,	4, 'meeting-room',		null, null, null), 
	(65,	'occupied',	426,	12,	7, 'meeting-room',		null, null, null), 
	(94,	'reserved',	672,	6,	3, 'family',			null, null, null), 
	(2,		'reserved',	985,	4,	3, 'family',			null, null, null), 
	(45,	'open',		889,	5,	6, 'family',			null, null, null), 
	(48,	'reserved',	697,	4,	9, 'economy',			null, null, null),
	(32,	'reserved',	670,	9,	6, 'economy',			null, null, null), 
	(61,	'open',		926,	4,	3, 'economy',			null, null, null), 
	(99,	'reserved',	743,	9,	9, 'donald',			null, null, null), 
	(34,	'occupied',	233,	4,	1, 'donald',			null, null, null), 
	(93,	'open',		799,	3,	9, 'donald',			null, null, null), 
	(49,	'occupied',	633,	5,	6, 'donald',			null, null, null), 
	(68,	'reserved',	415,	9,	2, 'baller',			null, null, null), 
	(42,	'reserved',	326,	11,	10,'baller',			null, null, null), 
	(76,	'reserved',	742,	14,	1, 'baller',			null, null, null), 
	(70,	'occupied',	931,	10,	2, 'baller',			null, null, null),
	(45,	'occupied',	433,	11,	5, 'baller',			null, null, null), 
	(8,		'reserved',	783,	6,	5, 'baller',			null, null, null), 
	(58,	'occupied',	623,	3,	5, 'cost-saver',		null, null, null), 
	(15,	'reserved',	983,	6,	4, 'cost-saver',		null, null, null), 
	(84,	'open',		173,	2,	3, 'cost-saver',		null, null, null), 
	(82,	'open',		177,	4,	10,'cost-saver',		null, null, null), 
	(33,	'reserved',	961,	3,	8, 'baller',			null, null, null), 
	(48,	'reserved',	984,	12,	8, 'cost-saver',		null, null, null), 
	(27,	'open',		898,	5,	3, 'cost-saver',		null, null, null), 
	(40,	'reserved',	940,	2,	2, 'cost-saver',		null, null, null);

insert into Room_Type (name, description) values
	('cost-saver',			'the cheapest we got!'),
	('baller',				'when you really just need to spend money'),
	('donald',				'when you need to spend money biggly'),
	('economy',				'the best value'),
	('family',				'for the rascals'),
	('meeting-room',		'for the business calls'),
	('performance-hall',	'where the band plays'),
	('expo-center',			'where we lift weights');

insert into Facility (facilityId, description, type, openTime, closeTime, BID) values
	(31, '8 feet max depth. Diving board.','Swimming Pool','06:00:00','22:00:00', 3),
	(32, 'Free weights, Machines, 3 Treadmills.','Fitness Center','06:00:00','22:00:00', 3),
	(33, '5 feet max depth.','Swimming Pool','06:00:00','22:00:00', 1),
	(34, 'Breakfast diner.','Restaurant','08:00:00','12:00:00', 2),
	(35, '21 and over bar.','Restaurant','16:00:00','02:00:00', 4);

-- Step 3. Update Tables to Add Constraints

-- Step 4. Add Triggers To Tables


-- Potentially remove salary from Position table and keep it only on Worker.