IF (OBJECT_ID('dbo.tbl_Users', 'U') IS NOT NULL) 
BEGIN
  return;
END; 
CREATE TABLE tbl_Users(
    userID				    	INT PRIMARY KEY IDENTITY(1,1),
    firstName					NVARCHAR(50) NOT NULL,
    lastName					NVARCHAR(50),
	email						NVARCHAR(100) UNIQUE NOT NULL,
    address						NVARCHAR(255),
    phone						NVARCHAR(20) UNIQUE,
    gender						NVARCHAR(10),
	createdBy					NVARCHAR(50) NULL,
	createdDate					DATETIME  NULL,
	modifiedBy					NVARCHAR(50) NULL,	 
	modifiedDate				DATETIME  NULL,
	isActive					CHAR(1) NULL,
	isDeleted					CHAR(1) NULL
) 