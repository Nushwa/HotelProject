--Ledger Report Date Wise

SELECT P.[Date], P.Customer_ID, l.Credit, l.Debit, l.Balance, P.status FROM Ledger l
INNER JOIN Payment P
ON P.PaymentID = l.Payment_ID  
order by P.[Date] asc

--Customer who has stayed the longest ->Discount
SELECT Top 1  c.FName, c.LName, b.BookingID, SUM (DATEDIFF(DAY, b.CheckinDate, b.CheckoutDate) ) as [Total Number of Days] FROM Booking b
INNER JOIN Customer c ON
c.CustomerID = b.BookingID
Group by c.FName, c.LName, b.BookingID

--
