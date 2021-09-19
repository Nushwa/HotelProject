----Query returns a list of reservation that end in March 2021
--Customer names, Room Number, Booking dates

select c.BookingID ,r.RoomID, b.CheckinDate, b.CheckoutDate
from RoomReservation c
inner join Room r on r.RoomID = c.Room_ID
inner join Booking b on b.BookingID = c.BookingID
where b.CheckoutDate < '2021-03-18'

SELECT * FROM BOOKING


select count (rr.BookingID), rt.RoomType from RoomReservation rr
inner join Room r
on rr.Room_ID = r.RoomID
inner join RoomType rt
on rt.RoomTypeID = r.RoomTypeID
group by RoomType

--show booking id against one customer
select * from Booking b
where b.CustomerID IN (select distinct c.CustomerID from Customer c 
group by c.CustomerID having count(c.CustomerID) =  1 )

--query to find bookings attributed to customer

select * from Booking b
where b.CustomerID in (select c.CustomerID from Customer c)

select * from Booking b
inner join Customer c
on b.BookingID = c.CustomerID