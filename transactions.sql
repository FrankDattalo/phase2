---------------------
-- Simple Transaction
---------------------
DECLARE @intErrorCode INT
BEGIN TRAN
	UPDATE Worker
	SET salary = 100000
	WHERE ssn = '146267824'

	SELECT @intErrorCode = @@ERROR
	IF (@intErrorCode <> 0) GOTO PROBLEM

	SELECT * FROM Worker

	UPDATE Vehicle
	SET price = 100000
	WHERE licensePlateNo = 'GJ6030S'

	SELECT @intErrorCode = @@ERROR
	IF (@intErrorCode <> 0) GOTO PROBLEM

	SELECT * FROM Vehicle
COMMIT TRAN
PROBLEM:
IF (@intErrorCode <> 0) BEGIN
PRINT 'Unexpected error occurred!'
	ROLLBACK TRAN
END


---------------------
-- Nested Transaction
---------------------
SELECT 'Before BEGIN TRAN', @@TRANCOUNT  -- The value of @@TRANCOUNT is 0
BEGIN TRAN
	SELECT 'After BEGIN TRAN', @@TRANCOUNT  -- The value of @@TRANCOUNT is 1
	INSERT INTO Worker values ('123456789', 'Sam', 'A', 'Williams', '8/21/1973',
	'369 Pine Sap Lane', 'M', '80000', '08/17/2002', 4, 'CFO', '06/17/2004')

	SELECT * FROM Worker

	BEGIN TRAN nested
		SELECT 'After BEGIN TRAN nested', @@TRANCOUNT -- The value of @@TRANCOUNT is 2

		UPDATE Worker
		SET salary = 85000
		WHERE ssn = '123456789'

	COMMIT TRAN nested  -- Does nothing except decrement the value of @@TRANCOUNT
	SELECT * FROM Worker
	SELECT 'After COMMIT TRAN nested', @@TRANCOUNT  -- The value of @@TRANCOUNT is 1

ROLLBACK TRAN

SELECT 'After ROLLBACK TRAN', @@TRANCOUNT  -- The value of @@TRANCOUNT is 0
-- because ROLLBACK TRAN always rolls back all transactions and sets
-- @@TRANCOUNT to 0.
SELECT * FROM Worker


--------------------------------
-- Transactions with save points
--------------------------------
SELECT 'Before BEGIN TRAN with save points', @@TRANCOUNT  -- The value of @@TRANCOUNT is 0
BEGIN TRAN main
	SELECT 'After BEGIN TRAN main', @@TRANCOUNT  -- The value of @@TRANCOUNT is 1
	INSERT INTO Worker values ('101010101', 'Sally', 'O', 'Bosner', '04/16/1976',
	'291 Vintage Court', 'F', '69000', '06/09/2001', 5, 'CEO', '12/17/2012')

	SAVE TRAN addrec -- Mark a save point
	SELECT 'After SAVE TRAN addrec', @@TRANCOUNT  -- The value of @@TRANCOUNT is still 1
	SELECT * FROM Worker

	BEGIN TRAN nested
		SELECT 'After BEGIN TRAN nested', @@TRANCOUNT  -- The value of @@TRANCOUNT is 2
		
		UPDATE Worker
		SET salary = 100001
		WHERE ssn = '101010101'

		SAVE TRAN updaterec -- Mark a save point
		SELECT 'After SAVE TRAN updaterec', @@TRANCOUNT  -- The value of @@TRANCOUNT is still 2
		SELECT * FROM Worker

	ROLLBACK TRAN addrec
	SELECT 'After ROLLBACK TRAN addrec', @@TRANCOUNT  -- The value of @@TRANCOUNT is still 2
	SELECT * FROM Worker

IF (@@TRANCOUNT > 0) BEGIN
	ROLLBACK TRAN
	SELECT 'AFTER ROLLBACK TRAN', @@TRANCOUNT  -- The value of @@TRANCOUNT is 0 because
	-- ROLLBACK TRAN always rolls back all transactions and sets @@TRANCOUNT to 0.
END
SELECT * FROM Worker