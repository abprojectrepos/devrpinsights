USE [RPDW_UAT_USR]
GO

/****** Object:  StoredProcedure [dbo].[usp_AIE_Send_Email_test]    Script Date: 2/16/2022 2:15:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_AIE_Send_Email_test]  @Subject varchar(100)
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


