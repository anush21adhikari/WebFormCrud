
IF (OBJECT_ID('dbo.sp_UserLogin', 'P') IS NOT NULL) 
BEGIN
	DROP PROCEDURE dbo.sp_UserLogin;
END;
GO

CREATE PROCEDURE sp_UserLogin
	(
		@flag					  NVARCHAR(50)			=NULL,	
 		@userName                 NVARCHAR(50)			=NULL, 
		@password		          NVARCHAR(MAX)			=NULL
	)
   AS   

        SET NOCOUNT ON;   
        SET XACT_ABORT ON;   

       BEGIN TRY   
	   	DECLARE
 				@msg					NVARCHAR(MAX) =NULL
				
if(@flag='userLogin')
BEGIN

	 IF NOT EXISTS(	 SELECT 'x' FROM tbl_ApplicationUser au INNER JOIN tbl_Users urs ON urs.userID = au.userID
		 WHERE au.userName = @userName AND au.password=@password AND ISNULL(au.isActive,'Y')='Y' AND ISNULL(urs.isActive,'Y')='Y')
		 BEGIN 
			 EXEC sp_ErrorHandler 1, 'Invalid username or password.', NULL;   
			RETURN;
		 END

	  ELSE
	  BEGIN 
			 EXEC sp_ErrorHandler 0, 'login successful', NULL;   
 
			SELECT ISNULL(urs.firstName,'')+' '+ISNULL(urs.lastName,'')fullName,urs.email, au.userName, urs.userID
			FROM tbl_ApplicationUser au INNER JOIN tbl_Users urs ON urs.userID = au.userID
		    WHERE au.userName = @userName AND au.password=@password AND ISNULL(au.isActive,'Y')='Y' 
			AND ISNULL(urs.isActive,'Y')='Y' AND ISNULL(urs.isDeleted,'N')='N'
		  
	  END

 END


	 END TRY											   
   BEGIN CATCH   									   
	IF @@TRANCOUNT > 0   								   
               ROLLBACK TRANSACTION;   
           SET @msg = ERROR_MESSAGE();   
          EXEC sp_ErrorHandler 1, @msg, NULL;   
 END CATCH;   
