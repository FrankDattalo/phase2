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
(1,'1-832-205-4909','784-1888 Blandit Rd.','pacific'),
(2,'1-398-463-4079','P.O. Box 736, 6351 Accumsan Avenue','southeast'),
(3,'1-216-372-3629','846-5103 Et Street','alaska'),
(4,'1-268-387-3145','426-5159 Ante. Ave','hawaii'),
(5,'1-477-786-9180','P.O. Box 925, 4186 Ipsum. Road','central'),
(6,'1-862-279-5572','Ap #402-5617 Mauris Av.','central'),
(7,'1-387-299-1446','P.O. Box 832, 5780 Massa. Rd.','northeast'),
(8,'1-696-339-3094','Ap #596-1776 Sed Avenue','mountain'),
(9,'1-632-945-6813','608-9541 Imperdiet Av.','pacific'),
(10, '1-354-771-2751','790 Dui, Street','central');

insert into Region (name,description,timeZone,COfficeId) values  
('pacific','Pacific United States region','PST',1),
('mountain','Mountain United States region','MST',2),
('central','Central United States region','CST',3),
('southeast','Southeastern United States region', 'EST',4),
('northeast','Northeastern United States region', 'EST',5),
('alaska','Alaskan region','AKST',6),
('hawaii','Hawaiian region','HST',7);

insert into Corporate_Office ( officeId , address , phoneNo , openHours , closeHours )  values 
(1,'Ap #965-8581 Tincidunt Avenue','1-643-926-9359','08:00:00','16:00:00'),
(2,'Ap #548-6014 Velit. Street','1-388-462-2782','08:00:00','16:00:00'),
(3,'Ap #266-5468 Porttitor Street','1-770-824-3744','08:00:00','16:00:00'),
(4,'479-6636 Condimentum. Street','1-149-260-2874','08:00:00','16:00:00'),
(5,'Ap #867-9390 Lacinia St.','1-373-762-8447','08:00:00','16:00:00'),
(6,'557-5143 Id, Ave','1-145-578-4802','08:00:00','16:00:00'),
(7,'132-6053 Purus, St.','1-774-471-1958','08:00:00','16:00:00');

insert into Worker( ssn , fName , mInit , lName , bDate , address , sex , salary , startDate , BID , PTitle , appointedOn ) values 
('183153645','Sopoline','Q','House','11/15/1948','P.O. Box 608, 4806 Ut Street','M','46627','10/18/2011',1,'Cook','06/13/2013'),
('463131234','Megan','Q','Benjamin','12/11/1869','P.O. Box 329, 370 Ante Avenue','F','45962','08/24/2006',2,'Cook','08/10/1974'),
('234127384','Madison','A','Good','08/18/1938','599 Feugiat Ave','M','49454','05/17/1989',1,'Worker','01/05/1920'),
('235534242','Cadman','Y','Vance','04/10/1963','Ap #525-9797 Ultrices. Av.','F','54201','07/02/1990',3,'Cook','12/24/1931'),
('324567213','Prescott','Y','Stephenson','06/21/1976','Ap #299-3098 Vulputate, St.','F','47651','01/14/2016',4,'Worker','11/08/1992'),
('704938234','Indira','D','Nixon','07/02/2008','P.O. Box 676, 2183 Dolor St.','F','53908','03/05/1994',5,'Director','09/07/1923'),
('463111234','Declan','F','Hester','10/12/1862','P.O. Box 366, 3351 Erat St.','M','50029','11/29/2016',1,'Director','07/12/1994'),
('146267824','Steel','A','Banks','01/14/1985','Ap #389-3754 Eget, St.','F','52037','07/29/2011',3,'Accountant','06/27/2016'),
('203394856','Hayden','Q','Paul','12/02/1992','P.O. Box 108, 7164 Scelerisque Street','M','48680','08/17/2002',1,'IT','06/21/1955'),
('324567443','Xander','G','Weeks','04/30/1888','Ap #347-3349 Quisque Street','F','47560','06/19/1986',2,'Finance','06/15/2005');

insert into Position( title , description ) values  
('Cook','This position is great!'),
('Worker','The best position in the company!'),
('Manager','This position is great!'),
('Director','Directs workers'),
('Head Cook','Runs the kitchen'),
('Security','In charge of security'),
('Accountant','Embezzels the company money'),
('Marketing','Prentends to work'),
('IT','Why did we hire them?'),
('Finance','Stops accounting from stealing too much');

insert into Facility( facilityId , description , type , openTime , closeTime , BID ) values 
(1,'Dont listen to others alternative facts, this place is great!','Beach','08:00:00', '01:00:00', '4'),
(2,'The best in town!','Spa','08:00:00', '01:00:00', '4'),
(3,'The best in town!','Laundry','08:00:00', '01:00:00', '4'),
(4,'Dont listen to others alternative facts, this place is great!','Gym','08:00:00', '01:00:00', '1'),
(5,'The president as been here.','Spa','08:00:00', '01:00:00', '1'),
(6,'Dont listen to others alternative facts, this place is great!','Casino','08:00:00', '01:00:00', '2'),
(7,'The best in town!','Beach','08:00:00', '01:00:00', '4'),
(8,'Beeeeeeeeer','Gym','08:00:00', '01:00:00', '2'),
(9,'Dont listen to others alternative facts, this place is great!','Casino','08:00:00', '01:00:00', '2'),
(10,'The best in town!','Pool','08:00:00', '01:00:00', '3'),
(11,'Youve never had better','Spa','08:00:00', '01:00:00', '7'),
(12,'Beeeeeeeeer','Casino','08:00:00', '01:00:00', '3'),
(13,'Sponsored by Dos Equis','Casino','08:00:00', '01:00:00', '3'),
(14,'Youve never had better','Laundry','08:00:00', '01:00:00', '6'),
(15,'Dont listen to others alternative facts, this place is great!','Gym','08:00:00', '01:00:00', '2'),
(16,'The best in town!','Pool','08:00:00', '01:00:00', '4'),
(17,'Youve never had better','Beach','08:00:00', '01:00:00', '5'),
(18,'Beeeeeeeeer','Casino','08:00:00', '01:00:00', '4'),
(19,'Dont listen to others alternative facts, this place is great!','Gym','08:00:00', '01:00:00', '3'),
(20,'Beeeeeeeeer','Gym','08:00:00', '01:00:00', '3'),
(21,'Youve never had better','Spa','08:00:00', '01:00:00', '4'),
(22,'Youve never had better','Beach','08:00:00', '01:00:00', '8'),
(23,'Beeeeeeeeer','Casino','08:00:00', '01:00:00', '2'),
(24,'Beeeeeeeeer','Beach','08:00:00', '01:00:00', '2'),
(25,'The president as been here.','Pool','08:00:00', '01:00:00', '1'),
(26,'The president as been here.','Laundry','08:00:00', '01:00:00', '9'),
(27,'5 stars!','Beach','08:00:00', '01:00:00', '4'),
(28,'5 stars!','Spa','08:00:00', '01:00:00', '4'),
(29,'5 stars!','Beach','08:00:00', '01:00:00', '1'),
(30,'Youve never had better','Casino','08:00:00', '01:00:00', '10');

insert into Room( roomNo , status , cost , maxOccupancy , BID , RTName , CID , startTime , endTime ) values 
(9,'occupied',724,6,5, 'expo-center',null, null, null), 
(17,'open',105,6,2, 'performance-hall',null, null, null), 
(10,'occupied',549,12,5, 'meeting-room',null, null, null), 
(29,'reserved',426,7,4, 'meeting-room',null, null, null), 
(100,'open',932,9,4, 'meeting-room',null, null, null), 
(65,'occupied',426,12,7, 'meeting-room',null, null, null), 
(94,'reserved',672,6,3, 'family',null, null, null), 
(2,'reserved',985,4,3, 'family',null, null, null), 
(45,'open',889,5,6, 'family',null, null, null), 
(48,'reserved',697,4,9, 'economy',null, null, null),
(32,'reserved',670,9,6, 'economy',null, null, null), 
(61,'open',926,4,3, 'economy',null, null, null), 
(99,'reserved',743,9,9, 'donald',null, null, null), 
(34,'occupied',233,4,1, 'donald',null, null, null), 
(93,'open',799,3,9, 'donald',null, null, null), 
(49,'occupied',633,5,6, 'donald',null, null, null), 
(68,'reserved',415,9,2, 'baller',null, null, null), 
(42,'reserved',326,11,10,'baller',null, null, null), 
(76,'reserved',742,14,1, 'baller',null, null, null), 
(70,'occupied',931,10,2, 'baller',null, null, null),
(45,'occupied',433,11,5, 'baller',null, null, null), 
(8,'reserved',783,6,5, 'baller',null, null, null), 
(58,'occupied',623,3,5, 'cost-saver',null, null, null), 
(15,'reserved',983,6,4, 'cost-saver',null, null, null), 
(84,'open',173,2,3, 'cost-saver',null, null, null), 
(82,'open',177,4,10,'cost-saver',null, null, null), 
(33,'reserved',961,3,8, 'baller',null, null, null), 
(48,'reserved',984,12,8, 'cost-saver',null, null, null), 
(27,'open',898,5,3, 'cost-saver',null, null, null), 
(40,'reserved',940,2,2, 'cost-saver',null, null, null);

insert into Room_Type (name, description) values
('cost-saver','the cheapest we got!'),
('baller','when you really just need to spend money'),
('donald','when you need to spend money biggly'),
('economy','the best value'),
('family','for the rascals'),
('meeting-room','for the business calls'),
('performance-hall','where the band plays'),
('expo-center','where we lift weights');

insert into Facility (facilityId, description, type, openTime, closeTime, BID) values
(31, '8 feet max depth. Diving board.','Swimming Pool','06:00:00','22:00:00', 3),
(32, 'Free weights, Machines, 3 Treadmills.','Fitness Center','06:00:00','22:00:00', 3),
(33, '5 feet max depth.','Swimming Pool','06:00:00','22:00:00', 1),
(34, 'Breakfast diner.','Restaurant','08:00:00','12:00:00', 2),
(35, '21 and over bar.','Restaurant','16:00:00','02:00:00', 4);

insert into Customer( customerId , fName , mInit , lName , cardNo , dateOfBirth , BID ) values
(1,'Yolanda','M','Ross',72139,'04/28/1927','6'),
(2,'Nissim','F','Hull',44077,'04/08/1991','1'),
(3,'Joan','U','Sellers',12701,'03/30/1914','6'),
(4,'Penelope','N','Lee',90367,'11/23/1965','3'),
(5,'Sean','T','Sampson',42453,'06/29/1884','4'),
(6,'Justina','R','Guerra',42340,'07/06/1934','7'),
(7,'Nomlanga','B','Cantu',59340,'03/02/1942','5'),
(8,'Amena','T','Holmes',67324,'03/10/1943','1'),
(9,'Olivia','B','Alston',80889,'06/12/1886','5'),
(10,'Marvin','G','Mcdaniel',66236,'08/23/1970','6'),
(11,'Mollie','E','Blanchard',16219,'01/12/2003','8'),
(12,'Aaron','M','Beck',35195,'01/20/1943','10'),
(13,'Ivan','B','Martin',55085,'01/19/2017','3'),
(14,'Katelyn','S','Camacho',98520,'10/20/1900','2'),
(15,'Nelle','G','Valencia',85381,'04/26/1893','1'),
(16,'Jamalia','I','Greene',38509,'03/04/2016','10'),
(17,'Kaitlin','L','Craft',59208,'10/16/2007','1'),
(18,'Raja','S','Baker',20902,'12/01/2006','7'),
(19,'Donna','B','Vincent',33591,'10/07/1966','4'),
(20,'Cole','Q','Slater',85190,'02/18/1960','5'),
(21,'Eve','I','Le',20417,'03/11/1987','6'),
(22,'Jonah','P','Schmidt',66329,'10/17/1957','6'),
(23,'Keaton','T','Hoover',39620,'12/14/1930','1'),
(24,'Lila','U','Jarvis',59586,'09/03/2012','1'),
(25,'Wynter','S','Brennan',73116,'06/25/1953','3'),
(26,'Clare','N','Tyson',68674,'10/11/1923','1'),
(27,'Hanna','D','Anthony',52086,'04/06/2008','10'),
(28,'Simon','T','Waters',47706,'02/23/1890','1'),
(29,'Judah','D','Love',17760,'12/27/1920','3'),
(30,'Angelica','U','Vazquez',29171,'09/26/2004','2'),
(31,'Carl','G','Trevino',77350,'10/09/1911','10'),
(32,'Ian','I','Hansen',54718,'02/28/1911','1'),
(33,'Dexter','N','Sloan',32439,'10/08/2010','7'),
(34,'Christian','E','Mueller',84608,'06/26/1910','1'),
(35,'Josephine','J','Petty',91218,'02/21/2008','10'),
(36,'Mufutau','T','Austin',87147,'02/03/2006','6'),
(37,'Addison','J','Faulkner',15181,'02/21/1982','3'),
(38,'Robert','T','Bass',25963,'06/11/1988','9'),
(39,'Martha','Q','West',82508,'09/06/1939','4'),
(40,'Shelley','N','Mercer',96625,'08/12/1898','2'),
(41,'Linda','F','Hudson',33723,'11/11/1921','7'),
(42,'Sybill','E','Pickett',13974,'11/11/1984','6'),
(43,'Cheryl','D','Juarez',27763,'12/02/1969','5'),
(44,'Barclay','G','May',58744,'01/04/1933','10'),
(45,'Hoyt','A','Massey',87302,'07/27/1930','3'),
(46,'Channing','Q','Bradley',48453,'12/22/1930','9'),
(47,'Kaitlin','N','Harrell',78175,'10/26/1972','8'),
(48,'Derek','T','Whitehead',66992,'10/25/1978','7'),
(49,'Jorden','O','Frank',55778,'12/19/1898','5'),
(50,'Cooper','R','Vaughan',15983,'07/12/1907','5'),
(51,'Berk','S','Marks',86070,'04/23/1897','4'),
(52,'Nero','C','Wooten',57693,'08/14/1920','3'),
(53,'Melyssa','N','Drake',54669,'12/31/1998','1'),
(54,'Kevin','N','Guerrero',34580,'03/17/1969','3'),
(55,'Raven','E','Johns',68520,'07/06/1889','7'),
(56,'Russell','S','Walton',55814,'10/08/1893','1'),
(57,'Kessie','H','Key',65339,'11/16/2004','4'),
(58,'Driscoll','C','Myers',70973,'02/07/1940','1'),
(59,'Briar','F','Vance',75168,'05/29/1909','7'),
(60,'Emily','M','Hayden',13472,'12/06/1989','1'),
(61,'Nash','S','Wilkerson',78650,'06/13/1915','8'),
(62,'Reagan','P','Montoya',22812,'01/14/1965','6'),
(63,'Tate','J','Greene',42561,'04/06/1961','2'),
(64,'Mohammad','O','Joyce',80954,'05/28/1901','8'),
(65,'Libby','N','Chaney',29949,'05/31/2017','1'),
(66,'Chaney','I','Frazier',74930,'03/20/1953','9'),
(67,'Emerson','O','Fields',90221,'06/14/1972','10'),
(68,'Kyla','R','Hebert',41259,'04/12/1954','9'),
(69,'Dara','J','Ferrell',71019,'10/31/1966','6'),
(70,'Jeanette','P','Maynard',35167,'11/22/2002','10'),
(71,'Galena','C','Mcintyre',62821,'07/20/1987','3'),
(72,'Christine','S','Hansen',12864,'08/08/1973','7'),
(73,'Conan','O','Kinney',68398,'12/02/1972','6'),
(74,'Jesse','E','Simpson',36148,'03/31/1988','7'),
(75,'Warren','N','Francis',86868,'05/19/1959','5'),
(76,'Sigourney','U','Berry',25397,'11/02/1952','2'),
(77,'Hashim','N','Mooney',74684,'03/17/1916','2'),
(78,'Sharon','R','Armstrong',29501,'04/07/1996','2'),
(79,'Lacy','E','Holt',90402,'08/10/1951','10'),
(80,'Hayes','F','Battle',56998,'05/29/1885','8'),
(81,'Mannix','C','Barber',66068,'10/06/1904','2'),
(82,'Naida','T','Alston',20711,'01/12/1986','10'),
(83,'Aline','L','Wall',53442,'11/25/1991','3'),
(84,'Britanney','I','Colon',87513,'10/31/1997','3'),
(85,'Ivan','A','Rogers',95558,'05/06/1897','5'),
(86,'Melyssa','K','Bullock',40827,'09/01/1942','1'),
(87,'Audra','A','Rivas',18839,'04/05/1958','1'),
(88,'Quyn','C','Pacheco',21985,'10/15/1929','10'),
(89,'Yoshi','J','Ray',22526,'11/19/1981','4'),
(90,'Cecilia','Q','Norman',28054,'12/24/1924','7'),
(91,'Lester','T','Foley',80573,'10/04/1958','7'),
(92,'Cameran','P','Daugherty',67224,'04/05/1978','3'),
(93,'Mercedes','F','Patton',50595,'09/18/2008','7'),
(94,'Lionel','H','Moore',61137,'04/27/1913','9'),
(95,'Brett','D','Ross',53296,'06/15/1909','5'),
(96,'Shellie','M','Stone',90051,'12/31/1889','3'),
(97,'Angela','O','Griffin',42172,'06/05/1939','8'),
(98,'Paula','R','Clements',13115,'09/10/1987','9'),
(99,'Elaine','R','Blanchard',53139,'07/22/2001','5'),
(100,'Nathan','C','Richard',39549,'05/09/2016','3');

insert into Bill( billNo , description , cost , CID ) values
(1,'breakfast',241,86),
(2,'lunch',788,26),
(3,'lunch',623,98),
(4,'drinks',410,24),
(5,'room and board',261,67),
(6,'drinks',829,11),
(7,'initial fees',254,5),
(8,'lunch',913,16),
(9,'dinner',647,78),
(10,'lunch',230,88),
(11,'initial fees',714,25),
(12,'room and board',673,24),
(13,'breakfast',610,33),
(14,'all inclusive',551,20),
(15,'breakfast',102,38),
(16,'room service',221,50),
(17,'dinner',840,41),
(18,'initial fees',574,22),
(19,'breakfast',795,93),
(20,'dinner',562,76),
(21,'room and board',843,36),
(22,'lunch',540,95),
(23,'breakfast',298,68),
(24,'lunch',698,7),
(25,'lunch',253,37),
(26,'breakfast',406,15),
(27,'breakfast',746,45),
(28,'breakfast',406,8),
(29,'all inclusive',991,47),
(30,'breakfast',297,6),
(31,'dinner',402,100),
(32,'room and board',194,45),
(33,'dinner',238,5),
(34,'initial fees',147,21),
(35,'drinks',172,62),
(36,'initial fees',406,52),
(37,'breakfast',340,4),
(38,'drinks',849,73),
(39,'all inclusive',942,51),
(40,'room service',627,42),
(41,'initial fees',573,60),
(42,'casino expense',566,26),
(43,'dinner',885,36),
(44,'casino expense',306,63),
(45,'casino expense',465,51),
(46,'lunch',193,48),
(47,'room service',394,73),
(48,'room and board',876,83),
(49,'room service',428,24),
(50,'all inclusive',736,52),
(51,'lunch',972,21),
(52,'room and board',619,24),
(53,'breakfast',450,1),
(54,'casino expense',213,76),
(55,'initial fees',452,93),
(56,'dinner',535,34),
(57,'initial fees',478,25),
(58,'casino expense',252,58),
(59,'lunch',822,96),
(60,'room service',207,12),
(61,'dinner',800,28),
(62,'dinner',412,16),
(63,'breakfast',642,61),
(64,'dinner',963,45),
(65,'room and board',805,16),
(66,'room and board',736,16),
(67,'lunch',169,73),
(68,'drinks',675,20),
(69,'room service',247,6),
(70,'dinner',275,24),
(71,'all inclusive',368,81),
(72,'initial fees',349,33),
(73,'room service',795,78),
(74,'casino expense',834,52),
(75,'room and board',168,54),
(76,'all inclusive',919,37),
(77,'all inclusive',948,71),
(78,'dinner',375,43),
(79,'breakfast',605,47),
(80,'lunch',948,91),
(81,'all inclusive',176,37),
(82,'casino expense',252,40),
(83,'drinks',275,33),
(84,'lunch',752,28),
(85,'casino expense',308,24),
(86,'room and board',772,73),
(87,'lunch',295,91),
(88,'lunch',154,4),
(89,'room and board',324,26),
(90,'lunch',198,30),
(91,'dinner',146,57),
(92,'room and board',293,65),
(93,'initial fees',916,85),
(94,'drinks',842,91),
(95,'room and board',889,76),
(96,'dinner',375,19),
(97,'all inclusive',221,67),
(98,'room and board',771,14),
(99,'breakfast',995,82),
(100,'room service',145,96);


-- Step 3. Update Tables to Add Constraints

-- Step 4. Add Triggers To Tables


-- Potentially remove salary from Position table and keep it only on Worker.