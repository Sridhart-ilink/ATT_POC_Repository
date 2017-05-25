/*SELECT DATABASE() FROM DUAL*/
/*create database autoforms;*/
/*show databases;*/
use autoforms;

drop table SARF;
drop table Polygon;

CREATE TABLE SARF(
	SarfId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	SarfName varchar(100) NULL,
    SarfStatus varchar(100) NULL,
    ProcessInstanceID nvarchar(100) NULL,
	DateCreated datetime NULL,
	DateModified datetime NULL 	 
);

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

INSERT INTO Polygon (Vertices, SarfId, AreaInSqKm, DateCreated) VALUES ('-80.95556,37.60069;-79.30761,39.9977;-78.56054,38.80927;-80.95556,37.60069;', 1, '345.670', now());
INSERT INTO Polygon (Vertices, SarfId, AreaInSqKm, DateCreated) VALUES ('-88.00878,38.99737;-86.03124,40.45066;-83.98778,39.37205;-84.11962,37.44385;-86.58056,37.19922;-88.00878,38.99737;', 2, '75.920', now());
INSERT INTO Polygon (Vertices, SarfId, AreaInSqKm, DateCreated) VALUES ('-82.09813,37.79194;-81.76854,39.52476;-80.49413,40.88399;-78.99999,37.84401;-82.09813,37.84401;-82.09813,37.79194;', 3, '2645.800', now());
INSERT INTO Polygon (Vertices, SarfId, AreaInSqKm, DateCreated) VALUES ('-122.28612,46.96859;-120.74804,48.79561;-118.02343,47.68347;-117.71581,46.27441;-119.86913,47.50566;-122.15429,47.02854;-122.28612,46.96859;', 4, '567.000', now());
INSERT INTO Polygon (Vertices, SarfId, AreaInSqKm, DateCreated) VALUES ('-122.28612,46.96859;-120.74804,48.79561;-118.02343,47.68347;-117.71581,46.27441;-119.86913,47.50566;-122.15429,47.02854;-122.28612,46.96859;', 5, '568.000', now());

/*select * from polygon;*/

SELECT s.SarfId, s.SarfName, s.SarfStatus, p.PolygonId, p.Vertices, p.AreaInSqKm, s.ProcessInstanceID
FROM SARF s INNER JOIN Polygon p ON s.SarfId = p.SarfId;

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
/************************************************************************/



