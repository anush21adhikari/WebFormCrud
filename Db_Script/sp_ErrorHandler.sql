
IF (OBJECT_ID('dbo.sp_ErrorHandler', 'P') IS NOT NULL) 
BEGIN
	DROP PROCEDURE dbo.sp_ErrorHandler;
END;
GO

CREATE PROCEDURE sp_ErrorHandler
	(
		@errorCode			 NVARCHAR(10)			=NULL,	
 		@msg                 NVARCHAR(500)			=NULL, 
		@extra		         NVARCHAR(200)			=NULL
	)
   AS   

 SET NOCOUNT ON;   
 SELECT @errorCode errorCode,@msg msg, @extra extra
   