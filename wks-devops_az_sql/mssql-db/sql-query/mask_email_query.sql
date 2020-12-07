-- Create user for demo Encryptin Email
CREATE USER reader
	WITHOUT LOGIN
	WITH DEFAULT_SCHEMA = dbo

GO
-- Grant user 
GRANT CONNECT TO reader

SELECT * 
From dbo.client

ALTER TABLE dbo.client ALTER COLUMN email 
ADD MASKED WITH (Function='email()');
GO

EXECUTE AS USER = 'guest'
SELECT * FROM dbo.client