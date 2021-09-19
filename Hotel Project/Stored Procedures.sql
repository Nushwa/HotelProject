--------STORED PROCEUDRES-------------

-----------------------------------------------------------------------------------
---Take 2 dates as a parameter and show which rooms are available on those dates
create procedure RoomStatus
@checkindate datetime,
@checkoutdate datetime
as
begin
select r.Room_ID from RoomReservation r
inner join Booking b
on b.BookingID = r.BookingID
where
	( @checkindate < b.CheckinDate )
	OR
	( @checkindate > b.CheckoutDate )
	AND
	( @checkoutdate < b.CheckinDate )
	OR
	( @checkoutdate > b.CheckoutDate )
end

execute RoomStatus '2021-06-13', '2021-06-14'

----------------------------------------------------------------------------
---To display the number of Days
create procedure NoOfDays
@stdate datetime,
@endate datetime,
@days int output
as
begin
select @days = DATEDIFF(DAY, @stdate, @endate)   
end

-----------------------------------------------------------------
--Calculating the Amount of Payment by taking rent as a parameter and multiplying it with No. of days
create procedure PaymentCal
@Amount int output,
@rent int,
@indate datetime,
@outdate datetime
as
begin

select @Amount = @rent * DATEDIFF(DAY, @indate, @outdate)
END

----Find Customer------------------
Go;
Create Procedure findCustomer 
@FirstName varchar(20),
@LastName varchar(20)
AS
begin
select Customer.CustomerID, Customer.FName, Customer.LName, Customer.Email, Customer.Email
from Customer
 where Customer.FName=@FirstName AND
 Customer.LName=@LastName
 end
 
 execute findCustomer 'Craig', 'Holt'
 ----------Find Booking----------------------
 GO;

 CREATE Procedure findBooking
 @CustomerID int
 AS
 begin
 select Customer.CustomerID, Customer.FName, Customer.LName, Booking.BookingID, Booking.CheckinDate, Booking.CheckoutDate, Booking.Adults, Booking.Children,RoomReservation.Room_ID
 from Customer
 INNER JOIN Booking ON
 Customer.CustomerID=Booking.CustomerID
 INNER JOIN RoomReservation ON
 RoomReservation.BookingID=Booking.BookingID
 where Customer.CustomerID=@CustomerID
 END


-------------------------------INSERTION PROCEDURES----------------------------

------Customer Insertion Procedure-----------
CREATE PROCEDURE insert_Customer
@id INT,
@fname VARCHAR(30),
@lname VARCHAR(30),
@num VARCHAR(30),
@ema VARCHAR(30),
@idnum VARCHAR(30)

AS
BEGIN
INSERT INTO Customer VALUES(@id, @fname, @lname, @num, @ema, @idnum)

END

-----BOOKING Insertion Procedure-----------

CREATE PROCEDURE insert_Booking
@id INT,
@adul INT,
@chil INT,
@indate DATETIME,
@outdate DATETIME
AS
BEGIN
INSERT INTO Booking VALUES(@id, @adul, @chil, @indate, @outdate)

END

-------PAYMENT Insertion Procedure-----------
CREATE PROCEDURE insert_Payment 
@pID INT,
@cuID int,
@BID int,
@am INT,
@date datetime,
@status BIT
AS
BEGIN
INSERT INTO Payment values(@pID, @cuID, @BID, @am, @date, @status)

END


---------Amenity Insertion Procedure-----------
Go
create procedure insertAmenity
@AmenityID INT,
@AmenityType varchar(30)
AS
begin

INSERT INTO Amenity VALUES (@AmenityID, @AmenityType)

END

--------RoomType Insertion Procedure------------
Go
create procedure insertRoomType
@RoomTypeID INT,
@AmenityID INT,
@RoomType varchar(30),
@Rent int

AS
begin

INSERT INTO RoomType VALUES (@AmenityID, @RoomType,@Rent)

END

-------------Room Reservation Insertion Procedure---------
go
create procedure insertRoomReservation
@Room_ID INT,
@BookingID INT
AS
begin

INSERT INTO RoomReservation VALUES (@Room_ID,@BookingID)

END


-----------Room Insertion Procedure---------
create procedure insertRoom   
@RoomID int,  
@MaximumOccupancy int,
@RoomTypeID int,
@ModifiedDate datetime
as
begin

	insert into RoomAudit values (@RoomID, @MaximumOccupancy, @RoomTypeID, getdate())    
   
end

-----------Ledger Insertion Procedure---------
create procedure insertLedger   
@ID INT,  
@Debit int,  
@Credit int,  
@Balance int,
@Date datetime
as
begin

insert into ledgerAudit values (@ID, @Debit, @Credit, @Balance, getdate())    
   
end


insert into Booking values(16, 3, 1, '2021-04-23 03:32:13', '2021-04-21 03:32:13')
insert into Booking values(16, 3, 1, getdate(), '2021-06-26 03:32:13')