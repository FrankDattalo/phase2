-- Step 1. Create Tables

create table Branch (
	branchId int not null,
	phoneNo varchar(15) not null,
	address varchar(30) not null,
	RName int not null,
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
	address varchar(30) not null,
	phoneNo varchar(10) not null,
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
	address varchar(30) not null,
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
	fulfillmentDate date not null,
	BID int not null,
	SID int not null,
	Item varchar(15) not null,
	primary key (invoice, BID, SID, Item)
);

create table Purchases_Vehicle (
	invoice int not null,
	quantity int not null,
	purchaseDate date not null,
	fulfillmentDate date not null,
	BID int not null,
	SID int not null,
	PlateNo varchar(15) not null,
	primary key (invoice, BID, SID, PlateNo)
);

-- Step 2. Insert Values into Tables


-- Step 3. Update Tables to Add Constraints

-- Step 4. Add Triggers To Tables


-- Potentially remove salary from Position table and keep it only on Worker.