-----------------------------------------
-- Step 1: Remove Foreign Key Constraints
-----------------------------------------
alter table Branch drop constraint FK_Branch_Region;
alter table Region drop constraint FK_Region_Corporate_Office;
alter table Facility drop constraint FK_Facility_Branch;
alter table Room drop constraint FK_Room_Branch;
alter table Room drop constraint FK_Room_Room_Type;
alter table Room drop constraint FK_Room_Customer;
alter table Customer drop constraint FK_Customer_Branch;
alter table Bill drop constraint FK_Bill_Customer;
alter table Request drop constraint FK_Request_Customer;
alter table Attends drop constraint FK_Attends_Customer;
alter table Attends drop constraint FK_Attends_Event;
alter table Event drop constraint FK_Event_Branch;
alter table Can_Reserve drop constraint FK_Can_Reserve_Event;
alter table Can_Reserve drop constraint FK_Can_Reserve_Room_Type;
alter table Reserves_For_Event drop constraint FK_Reserves_For_Event_Customer;
alter table Reserves_For_Event drop constraint FK_Reserves_For_Event_Room;
alter table Reserves_For_Event drop constraint FK_Reserves_For_Event_Event;
alter table Reserves_For_Event drop constraint FK_Reserves_For_Event_Branch;
alter table Reserves drop constraint FK_Reserves_Branch;
alter table Reserves drop constraint FK_Reserves_Room;
alter table Reserves drop constraint FK_Reserves_Event;
alter table Purchases_Supply drop constraint FK_Purchases_Supply_Branch;
alter table Purchases_Supply drop constraint FK_Purchases_Supply_Supplier;
alter table Purchases_Supply drop constraint FK_Purchases_Supply_Supply;
alter table Purchases_Food drop constraint FK_Purchases_Food_Branch;
alter table Purchases_Food drop constraint FK_Purchases_Food_Supplier;
alter table Purchases_Food drop constraint FK_Purchases_Food_Food;
alter table Purchases_Vehicle drop constraint FK_Purchases_Vehicle_Branch;
alter table Purchases_Vehicle drop constraint FK_Purchases_Vehicle_Supplier;
alter table Purchases_Vehicle drop constraint FK_Purchases_Vehicle_Vehicle;

-----------------------
-- Step 2: Drop Indexes
-----------------------
drop index Customer.idx_cname
drop index Worker.idx_wname
drop index Room.idx_roomCost
drop index Request.idx_requestPrice
drop index Event.idx_eventPrice
drop index Supply.idx_supplyPrice
drop index Food.idx_foodPrice
drop index Vehicle.idx_vehicle

----------------------
-- Step 3: Drop Tables
----------------------
drop table Attends;
drop table Bill;
drop table Branch;
drop table Can_Reserve;
drop table Corporate_Office;
drop table Customer;
drop table Event;
drop table Facility;
drop table Food;
drop table Position;
drop table Region;
drop table Request;
drop table Reserves;
drop table Reserves_For_Event;
drop table Purchases_Food;
drop table Purchases_Supply;
drop table Purchases_Vehicle;
drop table Room;
drop table Room_Type;
drop table Supply;
drop table Worker;
drop table Vehicle;
drop table Supplier;