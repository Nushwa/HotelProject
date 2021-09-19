create database HotelManagementSystem

-------------------------------TABLES-------------------------------------
create table Amenity(
AmenityID int primary key,
AmenityType varchar(30),
)

create table RoomType(
RoomTypeID int IDENTITY(101,1) Primary Key, 
AmenityID int FOREIGN KEY REFERENCES Amenity(AmenityID),
RoomType varchar(30),
Rent int 
)

create Table Room(
RoomID int Primary key,
MaximumOccupancy int Not null,
RoomTypeID int FOREIGN KEY REFERENCES RoomType(RoomTypeID)
)

create table Customer(
CustomerID int Primary key, 
FName varchar(30) Not null,
LName varchar(30) Not null,
ContactNum varchar(30) Not null,
Email  varchar(30) Not null,
IdentityNum varchar(30) Not null,
)

create table Booking(
CustomerID int FOREIGN KEY REFERENCES Customer (CustomerID),
BookingID int IDENTITY(1,1) Primary key,
Adults int NOT NULL, 
Children int,
CheckinDate Datetime NOT NULL,
CheckoutDate Datetime NOT NULL
)

--normalized table
create table RoomReservation( 
Room_ID int FOREIGN KEY REFERENCES Room(RoomID),
BookingID int FOREIGN KEY REFERENCES Booking(BookingID)
)

create table Payment (
PaymentID int primary key,
Customer_ID int FOREIGN KEY REFERENCES Customer (CustomerID) ON DELETE CASCADE,
BookingID int FOREIGN KEY REFERENCES Booking(BookingID) ON DELETE CASCADE,
Amount int Not null,
[Date] datetime Not null,
[status] bit Not null --boolean
)         

create table Ledger(
Payment_ID int Foreign Key references Payment(PaymentID) ON DELETE CASCADE,
Debit int,
Credit int,
Balance int
)
 
--------------------------------------DISPLAY-------------------------------------------
SELECT * from Amenity
SELECT * FROM Customer
SELECT * from RoomReservation
SELECT * from RoomType
SELECT * from Room
SELECT * FROM Booking 
SELECT * FROM Ledger
SELECT * FROM Payment




