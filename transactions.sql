use hotel;
-- Simple Transaction
DECLARE @intErrorCode INT
BEGIN TRAN
	UPDATE Worker
	SET salary = 100000
	WHERE ssn = '146267824'

	SELECT @intErrorCode = @@ERROR
	IF (@intErrorCode <> 0) GOTO PROBLEM

	UPDATE Vehicle
	SET price = 100000
	WHERE licensePlateNo = 'GJ6030S'

	SELECT @intErrorCode = @@ERROR
	IF (@intErrorCode <> 0) GOTO PROBLEM
COMMIT TRAN
PROBLEM:
IF (@intErrorCode <> 0) BEGIN
PRINT 'Unexpected error occurred!'
	ROLLBACK TRAN
END