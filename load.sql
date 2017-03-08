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
	timeZone char(3) not null,
	noOfBranches int not null,
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
	salary int not null, -- TODO: maybe remove this? Since workers already have a salary
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
	roomNo int not null,
	status varchar(20) not null,
	cost int not null,
	maxOccupancy int not null,
	BID int not null,
	RTName varchar(15) not null,
	CID int not null,
	RNumber int not null, -- TODO: Dont know what this is?
	startTime datetime not null,
	endTime datetime not null,
	primary key (roomNo, BID)
);

create table Room_Type (
	name varchar(15) not null,
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

-- Step 2. Insert Values into Tables

insert into Branch (branchId, phoneNo, address, RName) 
values
(1,	'1-832-205-4909',	'784-1888 Blandit Rd.',					'Ulster'),
(2,	'1-398-463-4079',	'P.O. Box 736, 6351 Accumsan Avenue',	'Inverness-shire'),
(3,	'1-216-372-3629',	'846-5103 Et Street',					'New York'),
(4,	'1-268-387-3145',	'426-5159 Ante. Ave',					'MP'),
(5,	'1-477-786-9180',	'P.O. Box 925, 4186 Ipsum. Road',		'Sbg'),
(6,	'1-862-279-5572',	'Ap #402-5617 Mauris Av.',				'Mississippi'),
(7,	'1-387-299-1446',	'P.O. Box 832, 5780 Massa. Rd.',		'SA'),
(8,	'1-696-339-3094',	'Ap #596-1776 Sed Avenue',				'Ontario'),
(9,	'1-632-945-6813',	'608-9541 Imperdiet Av.',				'New South Wales'),
(10,'1-354-771-2751',	'790 Dui, Street',						'BC');


insert into Corporate_Office ([officeId],[address],[phoneNo],[openHours],[closeHours]) 
values
(1,	'Ap #965-8581 Tincidunt Avenue',	'1-643-926-9359',	'08:00:00',	'16:00:00'),
(2,	'Ap #548-6014 Velit. Street',		'1-388-462-2782',	'08:00:00',	'16:00:00'),
(3,	'Ap #266-5468 Porttitor Street',	'1-770-824-3744',	'08:00:00',	'16:00:00'),
(4,	'479-6636 Condimentum. Street',		'1-149-260-2874',	'08:00:00',	'16:00:00'),
(5,	'Ap #867-9390 Lacinia St.',			'1-373-762-8447',	'08:00:00',	'16:00:00'),
(6,	'557-5143 Id, Ave',					'1-145-578-4802',	'08:00:00',	'16:00:00'),
(7,	'132-6053 Purus, St.',				'1-774-471-1958',	'08:00:00',	'16:00:00'),
(8,	'4682 Felis. Rd.',					'1-143-224-9818',	'08:00:00',	'16:00:00'),
(9,	'P.O. Box 405, 1415 Mi Street',		'1-328-896-6292',	'08:00:00',	'16:00:00'),
(10,'8999 Parturient Street',			'1-972-846-5302',	'08:00:00',	'16:00:00');


-- Step 3. Update Tables to Add Constraints

-- Step 4. Add Triggers To Tables


-- Potentially remove salary from Position table and keep it only on Worker.