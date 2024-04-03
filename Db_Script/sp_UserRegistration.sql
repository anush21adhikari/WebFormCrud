
IF (OBJECT_ID('dbo.sp_UserRegistration', 'P') IS NOT NULL) 
BEGIN
	DROP PROCEDURE dbo.sp_UserRegistration;
END;
GO

CREATE PROCEDURE sp_UserRegistration
	(
		@flag					  NVARCHAR(50)			=NULL,	
 		@userID		              INT 					=NULL, 
 		@userName                 NVARCHAR(50)			=NULL, 
		@password		          NVARCHAR(200)			=NULL, 
		@firstName                NVARCHAR(50)			=NULL, 
		@lastName                 NVARCHAR(50)			=NULL, 
 		@gender                   NVARCHAR(50)			=NULL, 
 		@email		              NVARCHAR(100)			=NULL, 
 		@address                  NVARCHAR(100)			=NULL, 
 		@phone		              NVARCHAR(20)			=NULL, 
		@isActive				  NVARCHAR(50)	=	'Y', 
 		@isDeleted				  NVARCHAR(50)	=	'N', 
		@createdBy				  NVARCHAR(50)	=	NULL, 
 		@createdDate			  DATETIME		=	NULL, 
 		@modifiedDate			  DATETIME		=	NULL, 
 		@modifiedBy				  NVARCHAR(50)	=	NULL
	)
   AS   
	
        SET NOCOUNT ON;   
        SET XACT_ABORT ON;   

   BEGIN TRY   
	   	DECLARE
 				@msg					NVARCHAR(MAX) =NULL

if(@flag='insert')
BEGIN

		 IF EXISTS(	 SELECT 'x' FROM tbl_ApplicationUser WHERE userName = @userName AND ISNULL(isActive,'Y')='Y')
		 BEGIN 
			EXEC sp_ErrorHandler 1, 'UserName already Exixts. Try Another user name.', NULL;
			RETURN;
		 END
		  IF EXISTS(SELECT 'x' FROM tbl_Users WHERE (phone =@phone OR email =@email) AND ISNULL(isActive,'Y')='Y')
		 BEGIN 
			EXEC sp_ErrorHandler 1, 'User already Exixts with provided phone or email.', NULL;
			RETURN;
		 END

		 BEGIN TRANSACTION

		INSERT INTO tbl_Users(	
					 firstName
					,lastName
					,email
					,address
					,phone
					,gender
					,createdBy
					,createdDate
					,isActive
					,isDeleted					
				)
					VALUES
					(
					 @firstName
					,@lastName
					,@email
					,@address
					,@phone
					,@gender
					,@createdBy
					,GETDATE()				
					,'Y'
					,'N'
					)
	
	           SET @userID = SCOPE_IDENTITY();

		INSERT INTO tbl_ApplicationUser(								
					 userID
					,userName
					,password
					,createdBy
					,createdDate
					,isActive
					,isDeleted
					)
					VALUES
					(
					 @userID
					,@userName
					,@password
					,@createdBy
					,GETDATE()
					,'Y'
					,'N'
					)	
	SELECT 0 errorCode,'User created Sucessfully.' msg
 Commit TRAN
 END


if(@flag='update')
BEGIN

		 IF EXISTS(	 SELECT 'x' FROM tbl_ApplicationUser WHERE userName = @userName AND userID<>@userID AND ISNULL(isActive,'Y')='Y')
		 BEGIN 
			EXEC sp_ErrorHandler 1, 'UserName already Exixts. Try Another user name.', NULL;   
			RETURN;
		 END
		  IF EXISTS(SELECT 'x' FROM tbl_Users WHERE (phone =@phone OR email =@email) AND  userID<>@userID AND ISNULL(isActive,'Y')='Y')
		 BEGIN 
			EXEC sp_ErrorHandler 1, 'User already Exixts with provided phone or email.', NULL;   
			RETURN;
		 END

		 BEGIN TRANSACTION
			UPDATE tbl_Users
				SET  firstName    =@firstName
					,lastName	  =@lastName
					,email		  =@email
					,address	  =@address
					,phone		  =@phone
					,gender		  =@gender			
					,modifiedBy	   =@modifiedBy
					,modifiedDate  =GETDATE()
					,isActive	   =@isActive
					,isDeleted	   =@isDeleted
				WHERE userId = @userID
	
			UPDATE tbl_ApplicationUser							
				SET	 userName      =@userName
					,password      =@password
					,modifiedBy	   =@modifiedBy
					,modifiedDate  =GETDATE()
					,isActive	   =@isActive
					,isDeleted	   =@isDeleted
				WHERE userID = @userID

			EXEC sp_ErrorHandler 0, 'User updated Successfully.', NULL;   

 Commit TRAN
 END
 if(@flag='edit')
 BEGIN
	   SELECT urs.firstName, urs.lastName, urs.gender,urs.phone,urs.email, au.userName,urs.address,au.isActive
		FROM tbl_ApplicationUser au INNER JOIN tbl_Users urs ON urs.userID = au.userID
	    WHERE au.userId = @userId  AND ISNULL(au.isActive,'Y')='Y' 
		AND ISNULL(urs.isActive,'Y')='Y'
 END
 if(@flag='deleteUser')
 BEGIN
    BEGIN TRANSACTION
			UPDATE tbl_Users
				SET  isActive	   ='N'
					,isDeleted	   ='Y'
				WHERE userId = @userID
	
			UPDATE tbl_ApplicationUser							
				SET  isActive	   ='N'
					,isDeleted	   ='Y'
				WHERE userID = @userID

			 EXEC sp_ErrorHandler 0, 'User Deleted Successfully.', NULL;   
 Commit TRAN
 END
 if(@flag='getUserList')
 BEGIN
 	   SELECT urs.userID, (ISNULL(urs.firstName,'') +' '+ ISNULL(urs.lastName,'')) fullName, urs.gender,urs.phone,urs.email, au.userName,urs.address,
	   CASE WHEN ISNULL(au.isActive,'Y')='Y' THEN 'Active' ELSE 'InActive' END AS userStatus 
		FROM tbl_ApplicationUser au INNER JOIN tbl_Users urs ON urs.userID = au.userID
	    WHERE   ISNULL(au.isDeleted,'N')='N' AND ISNULL(urs.isDeleted,'N')='N'

 END
	 END TRY											   
   BEGIN CATCH   									   
	IF @@TRANCOUNT > 0   								   
               ROLLBACK TRANSACTION;   
           SET @msg = ERROR_MESSAGE();   
           EXEC sp_ErrorHandler 1, @msg, NULL;   
 END CATCH;   
