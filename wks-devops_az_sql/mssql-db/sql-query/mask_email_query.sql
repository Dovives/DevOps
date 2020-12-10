-- Alter Email Column 
ALTER TABLE dbo.Customers ALTER COLUMN email 
ADD MASKED WITH (Function='email()');
GO


use [DB]
-- Create user for demo Encryptin Email
CREATE USER reader
	WITHOUT LOGIN
	WITH DEFAULT_SCHEMA = dbo

GO
-- Grant user 
GRANT CONNECT TO reader
-- Add user to reader role
ALTER Role db_datareader ADD MEMBER reader; 

EXECUTE AS USER = 'reader'
SELECT * FROM dbo.Customers


-- other option for reader user https://docs.microsoft.com/en-us/sql/relational-databases/security/dynamic-data-masking?view=sql-server-ver15

CREATE USER reader WITHOUT LOGIN;  
GRANT SELECT ON dbo.Customers TO reader;  
  
EXECUTE AS USER = 'reader';  
SELECT * FROM dbo.Customers;  
REVERT;