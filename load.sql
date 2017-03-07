-- Step 1. Create Tables

create table Branch (
	branchId int not null,
	phoneNo varchar(10) not null,
	address text not null,
	RName int not null,
	primary key (branchId)
);

create table Region (
	name varchar(10) not null,
	description text not null,
	timeZone varchar(3) not null,
	noOfBranches int not null,
	COfficeID int not null,
	primary key (name)
);

-- Step 2. Insert Values into Tables

-- Step 3. Update Tables to Add Constrains

-- Step 4. Add Triggers To Tables