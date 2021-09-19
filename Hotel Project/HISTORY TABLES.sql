--HISTORY TABLES TRIGGERS
-----------------------------------------------------------
--BOOKING HISTORY TABLE

create table BookingAudit
(
BAuditID int NOT NULL IDENTITY(1,1) Primary key,
CustomerID int NOT NULL,
BookingID int NOT NULL,
Adults int NOT NULL, 
Children int,
CheckinDate Datetime NOT NULL,
CheckoutDate Datetime NOT NULL,
ModifiedDate datetime
)


----------------------------------------------------------------------------------
--PAYMENT HISTORY TABLE

create table PaymentAudit(
PaymentAudit INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
PaymentID int,
Customer_ID int,
BookingID int,
Amount int Not null,
[Date] datetime Not null,
[status] bit Not null, --boolean
ModifiedDate datetime
)

-----------------------------------------------------------------------
--ROOM RESERVATION HISTORY TABLE
CREATE TABLE RoomResAudit(
Room_ID int,
BookingID INT,
ModifiedDate datetime
)

----------------------------------------------------------------------
--LEDGER HISTORY TABLE

CREATE TABLE ledgerAudit (
Payment_ID int,
Debit int,
Credit int,
Balance INT,
ModifiedDate datetime
)

------------------------------------------------------
--Amenity HISTORY TABLE
create table AmenityAudit(
AAuditID int NOT NULL IDENTITY(1,1) Primary key,
AmenityID int NOT NULL,
AmenityType varchar(30),
ModifiedDate datetime 
)

----------------------------------------------------------------
--Room Type HISTORY TABLE
create table RoomTypeAudit(
ARoomTypeID int NOT NULL IDENTITY(1,1) Primary Key,
AmenityID int NOT NULL,
RoomType varchar(30),
Rent int,
ModificationDate datetime
)


-----------------------------------------------------------
--Customer HISTORY TABLE

--backup table for customer table
create table customers_history (
customerID int identity(1,1) Primary key,
fName varchar(30) Not null,
lName varchar(30) Not null,
contactNum varchar(30) Not null,
email  varchar(30) Not null,
modifiedDate DATETIME,
operation char(3) NOT NULL,
check (operation = 'INS')
)

-----------------------------------------------------------
--Room HISTORY TABLE

create Table RoomAudit(
RoomID int Primary key,
MaximumOccupancy int Not NULL,
RoomTypeID INT,
ModifiedDate datetime
)
