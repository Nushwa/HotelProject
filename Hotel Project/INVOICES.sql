-------------INVOICES---------------------

------CUSTOMER WISE Payment invoice 
CREATE VIEW viewPayment
AS
SELECT c.CustomerID, c.FName, c.LName, P.Amount, P.[Date], P.[status] FROM Customer c
INNER JOIN Payment P
ON P.PaymentID = c.CustomerID

SELECT * FROM viewPayment 

--DATE WISE Invoice Procedure----------------
Go
CREATE PROCEDURE View_Payment_DateWise
AS 
begin
SELECT P.[Date], c.FName, c.LName, P.Amount, C.CustomerID, P.[status] FROM Customer c
INNER JOIN Payment P
ON P.PaymentID = c.CustomerID
order by P.[Date] asc

end

EXECUTE View_Payment_DateWise

