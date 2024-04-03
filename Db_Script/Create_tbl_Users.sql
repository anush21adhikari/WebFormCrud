IF (OBJECT_ID('dbo.tbl_ApplicationUser', 'U') IS NOT NULL) 
BEGIN
  return;
END; 
CREATE TABLE tbl_ApplicationUser(
	rowID						INT PRIMARY KEY IDENTITY(1,1),
	userID	 					INT FOREIGN KEY REFERENCES tbl_Users(userID),
    userName					NVARCHAR(50) UNIQUE NOT NULL ,
    password					NVARCHAR(200) UNIQUE NOT NULL,
	createdBy					NVARCHAR(50) NULL,
	createdDate					DATETIME  NULL,
	modifiedBy					NVARCHAR(50) NULL,	 
	modifiedDate				DATETIME  NULL,
	isActive					CHAR(1) NULL,
	isDeleted					CHAR(1) NULL
) 