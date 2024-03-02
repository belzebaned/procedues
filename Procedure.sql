Create or Alter Procedure HumanResources.RegisterTime
	@BusinessEntityID INT,
	@RegIn Datetime,
	@RegOut Datetime,
	@TimeAtWork INT OUTPUT
AS
BEGIN
	IF @RegIn is null
	BEGIN;
		THROW 50001,'Entry Date/time cannot be empty',1;
	END
	IF @RegOut is not null and @RegIn>@RegOut
	BEGIN;
		THROW 50002,'Entry Date/Time cannot be later than Out Date/time',1;
	END


	IF NOT EXISTS(select* from HumanResources.InOut
					where BusinessEntityID=@businessentityid and RegInDate=cast(@regin as date))
	BEGIN
		-- insert a new row
		INSERT INTO HumanResources.InOut (BusinessEntityID,RegIn,RegOut)
		VALUES (@businessEntityID,@RegIN,@RegOut);
	END
	ELSE
	BEGIN
	--Update existing row
	Update HumanResources.InOut SET
		RegIn=@regin,
		RegOut=@regout
		where BusinessEntityID=@businessentityid and RegInDate=cast(@regin as date)
	END
	SET @TimeAtWork= DATEDIFF(minute,@regin,@Regout)
END
go