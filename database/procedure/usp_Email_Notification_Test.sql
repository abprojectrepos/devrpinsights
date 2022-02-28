USE [RPDW_UAT]
GO

/****** Object:  StoredProcedure [dbo].[usp_Email_Notification_Test]    Script Date: 2/16/2022 2:14:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Email_Notification_Test] @Subject as varchar(100)

AS

DECLARE @TO VARCHAR(400)
DECLARE @body NVARCHAR(MAX)
;

SELECT TOP (1)
		@TO=[RECIPIENT]
      ,@body=[BODY]
FROM [dbo].[ETL_Email_Table]
WHERE [SUBJECT]=@Subject
;  


EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'RPDW',
@recipients=@TO,
@copy_recipients='',
@body_format = 'HTML',
@body=@body,
@Subject=@Subject
;
GO


