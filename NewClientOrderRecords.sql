CREATE or alter PROCEDURE NewClientOrderRecords
	@ID INT null out,
	@ClientID INT null,
	@OrderDate DATETIME2 null,
	@OrderNote NVARCHAR(max) null,
	@newID int out

AS
BEGIN
IF @ID not in (select ID from Sales.ShopOrder)
BEGIN;
THROW 50002,'This ID is not be in DataBase',1
end
		IF @ID is null
						BEGIN
						--Inserting values ​​into the Sales.ShopOrder Table by initializing its values ​​based on Parameters
		INSERT INTO Sales.ShopOrder (ClientID,OrderDate,OrderNote) 
		VALUES (@ClientID,@OrderDate,@OrderNote)
		
END
ELSE
BEGIN
			--If not, update the record identified by Id equal to @Id and assign values ​​in the record based on the values ​​of the passed parameters.

UPDATE Sales.ShopOrder SET
		ClientID=@ClientID,
		OrderDate=@OrderDate,
		OrderNote=@OrderNote
Where ID=@ID
ENd
set @newID= SCOPE_IDENTITY()
ENd
go