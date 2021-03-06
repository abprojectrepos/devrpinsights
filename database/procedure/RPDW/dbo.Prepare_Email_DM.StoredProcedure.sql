USE [RPDW_UAT]
GO
/****** Object:  StoredProcedure [dbo].[Prepare_Email_DM]    Script Date: 3/17/2022 11:21:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Prepare_Email_DM]

@Emil_Report_Name NVARCHAR(50)


AS	

BEGIN

  SET NOCOUNT ON;
  DECLARE 
  
  @Report_Name NVARCHAR(50),
  @Sendor_Email_Id NVARCHAR(50),
  @Email_Subject NVARCHAR(500), 
  @Email_Header NVARCHAR(500),
  @Email_Body NVARCHAR(500),
  @Email_Trailor NVARCHAR(500),
   
  @Job_Run_Date DATE, 
  @Job_Status INT,
  @xml NVARCHAR(MAX), 
  @body NVARCHAR(MAX),
  @Content NVARCHAR(MAX),
  @R_Content VARCHAR(5000),
  
  @Source_File_Name NVARCHAR(150),
  @Source_Table_Name NVARCHAR(150),
  @Job_Error_Descr NVARCHAR(200),
  @Recipients NVARCHAR(500),
  @Recipients_CC NVARCHAR(500),
  
  @v_Srl INT,
  @Name NVARCHAR(500),
  @Email_ID NVARCHAR(50),
  @NewLineChar AS CHAR(2) = CHAR(13) + CHAR(10),
  @count int,

  @body1 NVARCHAR(MAX),@body2 NVARCHAR(MAX),@body3 NVARCHAR(MAX)
 , @body4 NVARCHAR(MAX), @body5 NVARCHAR(MAX), @v_dwh_count INT

  SET @Job_Run_Date = GETDATE()
--  SET @Report_Name = 'IRAS File Check'
  SET @Report_Name = @Emil_Report_Name
  SET @Sendor_Email_Id = ''
  SET @Email_Subject = ''
  SET @Email_Header = ''
  SET @Email_Body = ''
  SET @Email_Trailor = ''
  SET @Recipients = ''
  SET @Recipients_CC = ''
  SET @Source_File_Name = ''
  SET @Source_Table_Name = ''
  SET @Job_Status = 0
  SET @v_Srl = 0
  SET @Name = ''
  SET @Email_ID = ''
  SET @body = ''
  SET @Content = ''



  --IF @Job_Error_Descr is NOT NULL 
  --BEGIN
	 SELECT @Sendor_Email_Id = Sendor_Email_ID
           ,@Email_Subject   = Email_Subject
           ,@Email_Header    = Email_Header
           ,@Email_Body      = Email_Body
           ,@Email_Trailor   = Email_Trailor
     FROM dbo.Email_Config_Summary
     WHERE Report_Name = @Report_Name
AND ISActive = 1
     
	 SELECT @Recipients = @Recipients + Email_ID + ';'
	 FROM dbo.Email_Config_Detail
     WHERE Report_Name = @Report_Name
     AND Email_tocc_flag = 'TO'
AND IsActive = 1

	 SELECT @Recipients = SUBSTRING(@Recipients,1, LEN(@Recipients)-1)

	 SELECT @Recipients_CC = @Recipients_CC + Email_ID + ';'
	 FROM dbo.Email_Config_Detail
     WHERE Report_Name = @Report_Name
     AND Email_tocc_flag = 'CC'
AND IsActive = 1

	 SELECT @Recipients_CC = SUBSTRING(@Recipients_CC,1, LEN(@Recipients_CC)-1)

	
	 SELECT 
	 @Name = @Name + CAST(row_number() over (order by Email_ID) as varchar(10)) + '   ' + First_name + ' ' + Last_name + '   ' + Email_ID + @NewLineChar
     FROM dbo.Email_Config_Detail
     WHERE Report_Name = @Report_Name
     AND Email_tocc_flag = 'CC'
 AND IsActive = 1


 IF @Report_Name='LD_PSTG_STG'
 Begin
 select @count=(select count(1) from ETL_JOB_STATUS where convert(varchar(8),CREATED_ON,112)=CONVERT(varchar(8),getdate(),112)
 and JOB_STATUS='fail' and STAGE in ('PSTG','STG'))
 IF @count>=1
 begin
 SET @body =  @body + 'Job_Name: ' + @Report_Name +@NewLineChar
SET @body =  @body + 'Status:' +'Fail' + @NewLineChar
SET @body =  @body + 'Message:' + 'Please look into ETL JOB status table'

EXEC msdb.dbo.sp_send_dbmail
@profile_name=''
,@recipients=@Recipients
,@subject=@Email_Subject
,@body=@body
,@body_format='HTML'
end
ELSE
BEGIN 
 SET @body =  @body + 'Job_Name: ' + @Report_Name +@NewLineChar
SET @body =  @body + 'Status:' +'Success' + @NewLineChar
SET @body =  @body + 'Message:' + 'Job ran successfully'

EXEC msdb.dbo.sp_send_dbmail
@profile_name=''
,@recipients=@Recipients
,@subject=@Email_Subject
,@body=@body
,@body_format='HTML'
END

 end
 ELSE IF @Report_Name='LD_DW'
 Begin
 select @count=(select count(1) from ETL_JOB_STATUS where convert(varchar(8),CREATED_ON,112)=CONVERT(varchar(8),getdate(),112)
 and JOB_STATUS='fail' and STAGE in ('DW'))
 IF @count>=1
 begin
 SET @body =  @body + 'Job_Name: ' + @Report_Name +@NewLineChar
SET @body =  @body + 'Status:' +'Fail' + @NewLineChar
SET @body =  @body + 'Message:' + 'Please look into ETL JOB status table'

EXEC msdb.dbo.sp_send_dbmail
@profile_name=''
,@recipients=@Recipients
,@subject=@Email_Subject
,@body=@body
,@body_format='HTML'



end
ELSE
BEGIN 
 SET @body =  @body + 'Job_Name: ' + @Report_Name +@NewLineChar
SET @body =  @body + 'Status:' +'Success' + @NewLineChar
SET @body =  @body + 'Message:' + 'Job ran successfully'

EXEC msdb.dbo.sp_send_dbmail
@profile_name=''
,@recipients=@Recipients
,@subject=@Email_Subject
,@body=@body
,@body_format='HTML'
END
end
ELSE IF @Report_Name='LD_DM'
 Begin
 select @count=(select count(1) from ETL_JOB_STATUS where convert(varchar(8),CREATED_ON,112)=CONVERT(varchar(8),getdate(),112)
 and JOB_STATUS='fail' and STAGE in ('DM'))
 IF @count>=1
 begin
 SET @body =  @body + 'Job_Name: ' + @Report_Name +@NewLineChar
SET @body =  @body + 'Status:' +'Fail' + @NewLineChar
SET @body =  @body + 'Message:' + 'Please look into ETL JOB status table'

EXEC msdb.dbo.sp_send_dbmail
@profile_name=''
,@recipients=@Recipients
,@subject=@Email_Subject
,@body=@body
,@body_format='HTML'



end
ELSE
BEGIN 
 SET @body =  @body + 'Job_Name: ' + @Report_Name +@NewLineChar
SET @body =  @body + 'Status:' +'Success' + @NewLineChar
SET @body =  @body + 'Message:' + 'Job ran successfully'

EXEC msdb.dbo.sp_send_dbmail
@profile_name=''
,@recipients=@Recipients
,@subject=@Email_Subject
,@body=@body
,@body_format='HTML'
END


 end



--SELECT @Job_Status, @Job_Error_Descr, @Sendor_Email_Id, @Recipients, @Recipients_CC, @Email_Subject, @R_Content

END
GO
