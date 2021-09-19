---------------------------------------TRIGGERS------------------------------------------
--Insertion in Room Reservation will show you the type of Room that is assigned
create trigger tr_Reservation
on RoomReservation
for insert
as
begin
select * FROM INSERTED
INNER JOIN Room rt
ON rt.RoomID = INSERTED.Room_ID

END

--this trigger won't let a customer book the room if it is already booked
CREATE TRIGGER tr_bookOccupiedRoom
ON Room
INSTEAD OF INSERT 
AS
BEGIN
	IF (NOT EXISTS (SELECT rr.Room_ID FROM RoomReservation rr , INSERTED i 
	WHERE rr.Room_ID = i.RoomID) )
		PRINT('Room is already booked')

	ELSE
		INSERT INTO Room 
		SELECT RoomID, MaximumOccupancy, RoomTypeID 
		FROM INSERTED

END
--trigger for payment status, sets status value in Payment table as 1 upon insertion

Create trigger tr_PaymentStatus
on Payment
for insert
as
Begin
  Update Payment
  Set status=1

End
--Trigger to check whether the Check-in date and Check-out date is correctly entered 
create trigger tr_bookingdate
on Booking 
instead  of insert
as
begin
declare @cid int
DECLARE @BID int
DECLARE @Adults int
DECLARE @Child int
DECLARE @indate DATETIME 
DECLARE @outdate DATETIME 

SELECT @cid = CustomerID, @BID = BookingID,@Adults = Adults,@Child= Children, @indate = CheckinDate,@outdate = CheckoutDate FROM INSERTED
	IF (EXISTS (select b.CheckinDate, b.CheckoutDate from Booking b where CheckinDate > CheckoutDate))
		PRINT ('Check in date is greater than Check out date')
	ELSE
		execute dbo.insert_Booking @cid, @Adults, @Child, @indate, @outdate
end
select * from Booking
execute insert_Booking 126, 2, 1, '2021-03-12', '2021-03-11'


--trigger for ROOM AUDIT TABLE
create trigger roomHistory on Room 
for UPDATE, delete
as
begin
set nocount on;
insert into RoomAudit (RoomID, RoomTypeID, ModifiedDat)
select RoomID, RoomTypeID ,getdate() from inserted
END

--trigger for CUSTOER AUDIT TABLE
create trigger customerHistory on Customer 
for UPDATE, DELETE 
as
begin
set nocount on;
insert into customers_history (fName, lName, contactNum, email, modifiedDate, operation)
select i.fName, i.lName, i.contactNum, i.email, getdate(), 'ins' from deleted i
END

--trigger for Room Audit Table
create trigger tr_RoomTypeAudit
on RoomType
for update, delete
as
begin

insert into RoomTypeAudit 
(AmenityID, RoomType,Rent,ModificationDate)
select AmenityID, RoomType,Rent, GETDATE()
from deleted 

end

--trigger for AMENITY AUDIT TABLE
create trigger tr_AmenityAudit
on Amenity
for update, delete
as
begin

insert into AmenityAudit 
(AmenityID, AmenityType,ModifiedDate)
select AmenityID, AmenityType, GETDATE() from deleted 

END

--trigger for LEDGER AUDIT TABLE

create trigger tr_LedgerAudit
on dbo.Ledger
for update, delete
as
begin

insert into dbo.LedgerAudit
(Payment_ID, Debit, Credit, Balance, ModifiedDate)
select d.Payment_ID, d.Debit, d.Credit, d.Balance, GETDATE() 
from deleted d

END

--trigger for ROOM RESERVATION AUDIT TABLE

create trigger tr_auditRoomReservation
on dbo.RoomReservation
for update, delete
as

begin

insert into dbo.RoomResAudit
(Room_ID, BookingID, ModifiedDate)
select d.Room_ID, d.BookingID, GETDATE() 
from deleted d

END

--trigger for PAYMENT AUDIT TABLE

--update data into the payment audit table whenever data is updated or deleted from Payment
create trigger tr_auditPayment
on dbo.Payment
for update, delete
as
BEGIN

insert into dbo.PaymentAudit 
(PaymentID, Customer_ID, BookingID, Amount, [Date], [status], ModifiedDate)
select d.PaymentID, d.Customer_ID, d.BookingID, d.Amount, d.Date, d.[Status], GETDATE() 
from deleted d

END

--trigger for BOOKING AUDIT TABLE

create trigger tr_auditBooking 
on dbo.Booking
for update, delete
as

begin

insert into dbo.BookingAudit(CustomerID, BookingID, Adults, Children,
CheckinDate, CheckoutDate, ModifiedDate)

select d.CustomerID, d.BookingID, d.Adults, d.Children, d.CheckinDate,
d.CheckoutDate, GETDATE()
from deleted d

END


-----TRIGGER TO CHECK FOR ROOM OCCUPANCY
CREATE TRIGGER tr_checkRoomOccupancy
ON Room
INSTEAD OF INSERT 
AS
BEGIN
IF (NOT EXISTS (SELECT r.MaximumOccupancy FROM Room r, INSERTED i
WHERE i.MaximumOccupancy > 6) )
	PRINT ('The Room is Full')
	ELSE
		INSERT INTO Room
		SELECT RoomID, MaximumOccupancy, RoomTypeID
		FROM INSERTED

END

