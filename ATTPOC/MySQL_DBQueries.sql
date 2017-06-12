/*SELECT DATABASE() FROM DUAL*/
/*create database autoforms;*/
/*show databases;*/
use autoforms;

drop table SARF;
drop table Polygon;
drop table Node;

CREATE TABLE SARF(
	SarfId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	SarfName varchar(100) NULL,
    SarfStatus varchar(100) NULL,
    ProcessInstanceID nvarchar(100) NULL,
	DateCreated datetime NULL,
	DateModified datetime NULL 	 
);
ALTER TABLE SARF AUTO_INCREMENT=1001;

INSERT INTO SARF (SarfName, SarfStatus, ProcessInstanceID, DateCreated) VALUES ('sarfname1', 'RF Pending Completion', '3579ed8f-3bd7-11e7-9aa9-dacc20524153', now());
INSERT INTO SARF (SarfName, SarfStatus, ProcessInstanceID, DateCreated) VALUES ('sarfname2', 'C&E Vendor Assignment', '8579ed8f-3bd7-11e7-9aa9-eacc20524158', now());
INSERT INTO SARF (SarfName, SarfStatus, ProcessInstanceID, DateCreated) VALUES ('sarfname3', 'TV Pending Approval', '5579ed8f-3bd7-11e7-9aa9-facc20524155', now());
INSERT INTO SARF (SarfName, SarfStatus, ProcessInstanceID, DateCreated) VALUES ('sarfname4', 'RF Mod - TV Pending Approval ', '9579ed8f-3bd7-11e7-9aa9-gacc20524159', now());
INSERT INTO SARF (SarfName, SarfStatus, ProcessInstanceID, DateCreated) VALUES ('sarfname5', 'TV Complete', '2579ed8f-3bd7-11e7-9aa9-hacc20524152', now());

/*select * from sarf;*/

CREATE TABLE Polygon (
	PolygonId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Vertices varchar(8000) NOT NULL,
	SarfId int NULL,
    AreaInSqKm decimal(12,3) NULL,
	DateCreated datetime NULL,
	DateModified datetime NULL
);
ALTER TABLE Polygon AUTO_INCREMENT=1001;

INSERT INTO Polygon (Vertices, SarfId, AreaInSqKm, DateCreated) VALUES ('-80.95556,37.60069;-79.30761,39.9977;-78.56054,38.80927;-80.95556,37.60069;', 1001, '345.670', now());
INSERT INTO Polygon (Vertices, SarfId, AreaInSqKm, DateCreated) VALUES ('-88.00878,38.99737;-86.03124,40.45066;-83.98778,39.37205;-84.11962,37.44385;-86.58056,37.19922;-88.00878,38.99737;', 1002, '75.920', now());
INSERT INTO Polygon (Vertices, SarfId, AreaInSqKm, DateCreated) VALUES ('-82.09813,37.79194;-81.76854,39.52476;-80.49413,40.88399;-78.99999,37.84401;-82.09813,37.84401;-82.09813,37.79194;', 1003, '2645.800', now());
INSERT INTO Polygon (Vertices, SarfId, AreaInSqKm, DateCreated) VALUES ('-122.28612,46.96859;-120.74804,48.79561;-118.02343,47.68347;-117.71581,46.27441;-119.86913,47.50566;-122.15429,47.02854;-122.28612,46.96859;', 1004, '567.000', now());
INSERT INTO Polygon (Vertices, SarfId, AreaInSqKm, DateCreated) VALUES ('-122.28612,46.96859;-120.74804,48.79561;-118.02343,47.68347;-117.71581,46.27441;-119.86913,47.50566;-122.15429,47.02854;-122.28612,46.96859;', 1005, '568.000', now());

/*select * from polygon;*/

/*SELECT s.SarfId, s.SarfName, s.SarfStatus, p.PolygonId, p.Vertices, p.AreaInSqKm, s.ProcessInstanceID
FROM SARF s INNER JOIN Polygon p ON s.SarfId = p.SarfId;*/

/************************************************************************/

ALTER TABLE SARF ADD FA_Code nvarchar(24)NULL;
ALTER TABLE SARF ADD Search_Ring_ID nvarchar(100) NULL;
ALTER TABLE SARF ADD iPlan_Job nvarchar(200)NULL;
ALTER TABLE SARF ADD Pace nvarchar(200)NULL;
ALTER TABLE SARF ADD Market nvarchar(200)NULL;
ALTER TABLE SARF ADD County nvarchar(50) NULL;
ALTER TABLE SARF ADD FA_Type nvarchar(100)NULL;
ALTER TABLE SARF ADD Market_Cluster nvarchar(200)NULL;
ALTER TABLE SARF ADD Region nvarchar(200)NULL;
ALTER TABLE SARF ADD RF_Design_Engineer_ATTUID nvarchar (500) NULL;
ALTER TABLE SARF ADD AtollSiteName nvarchar (500) NULL;
/************************************************************************/

/* delete from sarf where sarfname is null;
delete from polygon where sarfid not in (select sarfid from sarf); */

/************************************************************************/
CREATE TABLE Node(
	NodeId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	SarfId int NULL,
    Latitude decimal(12,7) NULL,
    Longitude decimal(12,7) NULL,
    AtollSiteName varchar(200) NULL,
    iPlanJobNumber varchar(200) NULL,
    PaceNumber varchar(100) NULL,    
	DateCreated datetime NULL,
	DateModified datetime NULL 	 
);

INSERT INTO Node (SarfId, Latitude, Longitude, AtollSiteName, iPlanJobNumber, PaceNumber, DateCreated) 
VALUES (1001, '47.6101497', '-122.2015159', 'TestAtoll1', 'WR_-RUTH-11-00318', 'MRUTH000105', now());
INSERT INTO Node (SarfId, Latitude, Longitude, AtollSiteName, iPlanJobNumber, PaceNumber, DateCreated) 
VALUES (1001, '47.6101000', '-122.2015000', 'TestAtoll2', 'WR_-RUTH-11-00318', 'MRUTH000105', now());
INSERT INTO Node (SarfId, Latitude, Longitude, AtollSiteName, iPlanJobNumber, PaceNumber, DateCreated) 
VALUES (1002, '47.6062095', '-122.3320708', 'TestAtoll3', 'WR_-RUTH-11-00318', 'MRUTH000105', now());
INSERT INTO Node (SarfId, Latitude, Longitude, AtollSiteName, iPlanJobNumber, PaceNumber, DateCreated) 
VALUES (1002, '47.6063155', '-122.3327984', 'TestAtoll4', 'WR_-RUTH-11-00318', 'MRUTH000105', now());
/************************************************************************/
CREATE TABLE Hub(
	HubId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	SarfId int NULL,
    Latitude decimal(12,7) NULL,
    Longitude decimal(12,7) NULL,
    Address varchar(200),  
	DateCreated datetime NULL,
	DateModified datetime NULL 	 
);

INSERT INTO Hub (SarfId, Latitude, Longitude, Address, DateCreated) 
VALUES (1006, '47.6101497', '-122.2015159', 'Water Street, Spokane, Washington', now());
INSERT INTO Hub (SarfId, Latitude, Longitude, Address, DateCreated) 
VALUES (1006, '48.6101497', '-121.2015159', 'Water Street, Spokane, Washington', now());
INSERT INTO Hub (SarfId, Latitude, Longitude, Address, DateCreated) 
VALUES (1007, '49.6101497', '-120.2015159', 'Big Street, Spokane, Washington', now());
INSERT INTO Hub (SarfId, Latitude, Longitude, Address, DateCreated) 
VALUES (1007, '46.6101497', '-123.2015159', 'Big Street, Spokane, Washington', now());

ALTER TABLE Node ADD HubId int NULL;

--New columns added by sheik for HUBS AND NODES
ALTER TABLE HUB ADD HubType nvarchar (500) NULL;
ALTER TABLE NODE ADD NodeType nvarchar (500) NULL;
ALTER TABLE NODE ADD VendorName nvarchar (500) NULL;
ALTER TABLE NODE ADD ContactPolice nvarchar (500) NULL;
ALTER TABLE NODE ADD ContactFire nvarchar (500) NULL;
ALTER TABLE NODE ADD ContactEnergy nvarchar (500) NULL;
ALTER TABLE NODE ADD IsATTOwned nvarchar (50) NULL;
ALTER TABLE NODE ADD StructureHeight nvarchar (50) NULL;
ALTER TABLE NODE ADD Company nvarchar (500) NULL;
/************************************************************************/