USE [RPDW_UAT]
GO
/****** Object:  StoredProcedure [dbo].[DisplayJobStatus]    Script Date: 3/17/2022 11:22:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DisplayJobStatus]
AS

IF OBJECT_ID(N'tempdb..#PSTGList') IS NOT NULL BEGIN DROP TABLE #PSTGList END


SELECT * INTO #PSTGList FROM(
    SELECT * FROM(SELECT *, ROW_NUMBER() OVER(PARTITION BY JOB_NAME ORDER BY PROCESSED_ON DESC) AS Rno FROM [dbo].ETL_JOB_STATUS) JOBSTATUS WHERE JOBSTATUS.Rno = 1 and STAGE = 'PSTG'
) PSTGList

SELECT 
        ISNULL(ISNULL(FREQUENCY_PHASE1.FREQUENCY,FREQUENCY_PHASE2.FREQUENCY),'NOT FOUND') FREQUENCY
       ,PSTG.JOB_NAME PSTG,PSTG.PROCESSED_ON,PSTG.JOB_STATUS 
       ,STG.JOB_NAME STG,STG.PROCESSED_ON,CASE WHEN PSTG.PROCESSED_ON > STG.PROCESSED_ON THEN 'NOT TRIGGERED' ELSE STG.JOB_STATUS END JOB_STATUS
	   ,DW.JOB_NAME DW, DW.PROCESSED_ON ,CASE WHEN PSTG.PROCESSED_ON > STG.PROCESSED_ON THEN 'NOT TRIGGERED' ELSE DW.JOB_STATUS END JOB_STATUS
	   ,DM.JOB_NAME DM, DM.PROCESSED_ON,CASE WHEN DW.PROCESSED_ON > DM.PROCESSED_ON THEN 'NOT TRIGGERED' ELSE DM.JOB_STATUS END JOB_STATUS
 FROM #PSTGList PSTG 
 LEFT JOIN (SELECT * FROM(SELECT *, ROW_NUMBER() OVER(PARTITION BY JOB_NAME ORDER BY PROCESSED_ON DESC) AS Rno FROM [dbo].ETL_JOB_STATUS) JOBSTATUS WHERE JOBSTATUS.Rno = 1 AND STAGE = 'STG') STG 
 ON PSTG.TARGET_TABLENAME = STG.SOURCE_FILENAME
  LEFT JOIN (SELECT * FROM(SELECT *, ROW_NUMBER() OVER(PARTITION BY JOB_NAME ORDER BY PROCESSED_ON DESC) AS Rno FROM [dbo].ETL_JOB_STATUS) JOBSTATUS WHERE JOBSTATUS.Rno = 1 AND STAGE = 'DW') DW 
 ON STG.TARGET_TABLENAME = DW.SOURCE_FILENAME
  LEFT JOIN (SELECT * FROM(SELECT *, ROW_NUMBER() OVER(PARTITION BY JOB_NAME ORDER BY PROCESSED_ON DESC) AS Rno FROM [dbo].ETL_JOB_STATUS) JOBSTATUS WHERE JOBSTATUS.Rno = 1 AND STAGE = 'DM') DM 
 ON DW.TARGET_TABLENAME = DM.SOURCE_FILENAME
 LEFT JOIN [dbo].[ETL_JOB_DEPENDENCY] DEPENDENCY
 ON PSTG.TARGET_TABLENAME = DEPENDENCY.PACKAGE_NAME

 LEFT JOIN [dbo].[ETL_JOB_FREQUENCY] FREQUENCY_PHASE1
 ON DEPENDENCY.FREQUENCY_ID = FREQUENCY_PHASE1.FREQUENCY_ID
 LEFT JOIN [RPDW_UAT_STG].[dbo].ETL_JOB_CONFIG_STG CONFIG_STG
 ON PSTG.TARGET_TABLENAME = CONFIG_STG.SOURCE_TABLENAME
 LEFT JOIN [dbo].[ETL_JOB_FREQUENCY] FREQUENCY_PHASE2
 ON CONFIG_STG.FREQUENCY = FREQUENCY_PHASE2.FREQUENCY_ID
 order by FREQUENCY DESC
GO
/****** Object:  StoredProcedure [dbo].[Prepare_Email]    Script Date: 3/17/2022 11:22:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Prepare_Email]

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

SET @Content =@Content + @body

SELECT  @Sendor_Email_Id, @Recipients, @Recipients_CC, @Email_Subject, @Content,@count

--EXEC msdb.dbo.sp_send_dbmail
--@profile_name=''
--,@recipients=@Recipients
--,@subject=@Email_Subject
--,@body=@body
--,@body_format='HTML'
end
ELSE
BEGIN 
 SET @body =  @body + 'Job_Name: ' + @Report_Name +@NewLineChar
SET @body =  @body + 'Status:' +'Success' + @NewLineChar
SET @body =  @body + 'Message:' + 'Job ran successfully'


SET @Content =@Content + @body

SELECT  @Sendor_Email_Id, @Recipients, @Recipients_CC, @Email_Subject, @Content,@count

--EXEC msdb.dbo.sp_send_dbmail
--@profile_name=''
--,@recipients=@Recipients
--,@subject=@Email_Subject
--,@body=@body
--,@body_format='HTML'
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


SET @Content =@Content + @body

SELECT  @Sendor_Email_Id, @Recipients, @Recipients_CC, @Email_Subject, @Content,@count

--EXEC msdb.dbo.sp_send_dbmail
--@profile_name=''
--,@recipients=@Recipients
--,@subject=@Email_Subject
--,@body=@body
--,@body_format='HTML'



end
ELSE
BEGIN 
 SET @body =  @body + 'Job_Name: ' + @Report_Name +@NewLineChar
SET @body =  @body + 'Status:' +'Success' + @NewLineChar
SET @body =  @body + 'Message:' + 'Job ran successfully'

SET @Content =@Content + @body

SELECT  @Sendor_Email_Id, @Recipients, @Recipients_CC, @Email_Subject, @Content,@count

--EXEC msdb.dbo.sp_send_dbmail
--@profile_name=''
--,@recipients=@Recipients
--,@subject=@Email_Subject
--,@body=@body
--,@body_format='HTML'
END
end
--ELSE IF @Report_Name='LD_DM'
-- Begin
-- select @count=(select count(1) from ETL_JOB_STATUS where convert(varchar(8),CREATED_ON,112)=CONVERT(varchar(8),getdate(),112)
-- and JOB_STATUS='fail' and STAGE in ('DM'))
-- IF @count>=1
-- begin
-- SET @body =  @body + 'Job_Name: ' + @Report_Name +@NewLineChar
--SET @body =  @body + 'Status:' +'Fail' + @NewLineChar
--SET @body =  @body + 'Message:' + 'Please look into ETL JOB status table'

--EXEC msdb.dbo.sp_send_dbmail
--@profile_name=''
--,@recipients=@Recipients
--,@subject=@Email_Subject
--,@body=@body
--,@body_format='HTML'



--end
--ELSE
--BEGIN 
-- SET @body =  @body + 'Job_Name: ' + @Report_Name +@NewLineChar
--SET @body =  @body + 'Status:' +'Success' + @NewLineChar
--SET @body =  @body + 'Message:' + 'Job ran successfully'

--EXEC msdb.dbo.sp_send_dbmail
--@profile_name=''
--,@recipients=@Recipients
--,@subject=@Email_Subject
--,@body=@body
--,@body_format='HTML'
--END


-- end



--SELECT @Job_Status, @Job_Error_Descr, @Sendor_Email_Id, @Recipients, @Recipients_CC, @Email_Subject, @R_Content

END
GO
/****** Object:  StoredProcedure [dbo].[Prepare_Email_DM]    Script Date: 3/17/2022 11:22:41 AM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_Daily_Email_Notification]    Script Date: 3/17/2022 11:22:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_Daily_Email_Notification]
AS


DECLARE @TO VARCHAR(400)
DECLARE @Name varchar(100)
DECLARE @Subject varchar(100)
DECLARE @xml NVARCHAR(MAX)
DECLARE @body NVARCHAR(MAX)
DECLARE @DT_START datetime
DECLARE @DT_END varchar(20)
DECLARE @Report_Name VARCHAR(2000);

SET @DT_START=CONVERT(varchar(10),dateadd(day,0,GETDATE()),120) + ' 00:00:00';
SET @DT_END=CONVERT(varchar(10),dateadd(day,0,GETDATE()),120) + ' 23:59:59';
set @Name='Team,';
SET @TO= '';
SET @Report_Name='Daily RPDW Load Job';

SET @Subject=@Report_Name;

TRUNCATE TABLE [dbo].[ETL_Email_Table]; 

SET @xml =CAST(( SELECT "td/@align"='left', "td/@bgcolor"='white', JOB_NAME AS 'td','', 
            "td/@align"='left',"td/@bgcolor"='white',"td/@fontface"='calibri', "td/@fontsize"='3',[SOURCE_FILENAME]  AS 'td','',
            "td/@align"='left', "td/@bgcolor"='white',"td/@fontface"='calibri',"td/@fontsize"='3',[TARGET_TABLENAME]  AS 'td','',
			"td/@align"='center', "td/@bgcolor"='white',"td/@fontface"='calibri',"td/@fontsize"='3',b.[FREQUENCY_ID]  AS 'td','',
			"td/@align"='left',"td/@bgcolor"='white',"td/@fontface"='calibri',"td/@fontsize"='3',c.[FREQUENCY]  AS 'td','',
            "td/@align"='left',"td/@bgcolor"='white',"td/@fontface"='calibri',"td/@fontsize"='3',[JOB_STATUS]  AS 'td','',
			"td/@align"='left',"td/@bgcolor"='white',"td/@fontface"='calibri',"td/@fontsize"='3',[ERROR_MSG]  AS 'td','',
            "td/@align"='left',"td/@bgcolor"='white',"td/@fontface"='calibri',"td/@fontsize"='3',CONVERT(VARCHAR,a.[CREATED_ON],21)  AS 'td'

      FROM ETL_JOB_STATUS a
	  LEFT JOIN [RPDW_UAT].[dbo].[ETL_JOB_DEPENDENCY] b ON a.[JOB_NAME]=b.[PACKAGE_NAME] 
	  LEFT JOIN [RPDW_UAT].[dbo].[ETL_JOB_FREQUENCY] c ON b.[FREQUENCY_ID]=c.[FREQUENCY_ID]
	  WHERE 
      a.CREATED_ON >= @DT_START and a.CREATED_ON <= @DT_END 
	  --AND STAGE = 'PSTG'
	  ORDER BY JOB_NAME DESC

FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

SET @body ='<table border="0"  width="750" ><tr><td colspan="5"><font face="calibri" size="3" color="black"><b>Dear ' + @Name + '</b></td></tr><br>'
SET @body=  @body +'<tr><td colspan="5"></td></tr>'
SET @body=  @body +'<tr><td colspan="5"><font face="calibri" size="3" color="black">Please find below the status of RPDW Daily Load Jobs.</td></tr><br></table>'
SET @body=  @body +'<tr><td colspan="5"></td></tr>'


SET @body=  @body +'<table class="MsoTable15Grid4Accent6" border="1" cellspacing="0" cellpadding="0" width="1440" style="width:15.0in;border-collapse:collapse;border:none">
<tbody>
<tr>
<td width="327" valign="top" style="width:245.25pt;border:solid #70AD47 1.0pt;border-right:none;background:#70AD47;padding:0in 5.4pt 0in 5.4pt">
<p class="xmsonormal" align="center" style="text-align:center"><span style="font-size:10.0pt;color:white">JOB NAME</span><b><span style="color:white"><o:p></o:p></span></b></p>
</td>
<td width="475" valign="top" style="width:356.6pt;border-top:solid #70AD47 1.0pt;border-left:none;border-bottom:solid #70AD47 1.0pt;border-right:none;background:#70AD47;padding:0in 5.4pt 0in 5.4pt">
<p class="xmsonormal" align="center" style="text-align:center"><span style="font-size:10.0pt;color:white">SOURCE FILENAME</span><b><span style="color:white"><o:p></o:p></span></b></p>
</td>
<td width="201" valign="top" style="width:150.45pt;border-top:solid #70AD47 1.0pt;border-left:none;border-bottom:solid #70AD47 1.0pt;border-right:none;background:#70AD47;padding:0in 5.4pt 0in 5.4pt">
<p class="xmsonormal" align="center" style="text-align:center"><span style="font-size:10.0pt;color:white">TARGET TABLENAME</span><b><span style="color:white"><o:p></o:p></span></b></p>
</td>
<td width="201" valign="top" style="width:150.45pt;border-top:solid #70AD47 1.0pt;border-left:none;border-bottom:solid #70AD47 1.0pt;border-right:none;background:#70AD47;padding:0in 5.4pt 0in 5.4pt">
<p class="xmsonormal" align="center" style="text-align:center"><span style="font-size:10.0pt;color:white">JOB FREQUENCY ID</span><b><span style="color:white"><o:p></o:p></span></b></p>
</td>
<td width="201" valign="top" style="width:150.45pt;border-top:solid #70AD47 1.0pt;border-left:none;border-bottom:solid #70AD47 1.0pt;border-right:none;background:#70AD47;padding:0in 5.4pt 0in 5.4pt">
<p class="xmsonormal" align="center" style="text-align:center"><span style="font-size:10.0pt;color:white">FREQUENCY DESCRIPTION</span><b><span style="color:white"><o:p></o:p></span></b></p>
</td>
<td width="201" valign="top" style="width:150.45pt;border-top:solid #70AD47 1.0pt;border-left:none;border-bottom:solid #70AD47 1.0pt;border-right:none;background:#70AD47;padding:0in 5.4pt 0in 5.4pt">
<p class="xmsonormal" align="center" style="text-align:center"><span style="font-size:10.0pt;color:white">JOB_STATUS</span><b><span style="color:white"><o:p></o:p></span></b></p>
</td>
<td width="201" valign="top" style="width:150.45pt;border-top:solid #70AD47 1.0pt;border-left:none;border-bottom:solid #70AD47 1.0pt;border-right:none;background:#70AD47;padding:0in 5.4pt 0in 5.4pt">
<p class="xmsonormal" align="center" style="text-align:center"><span style="font-size:10.0pt;color:white">ERROR MESSAGE</span><b><span style="color:white"><o:p></o:p></span></b></p>
</td>
<td width="284" valign="top" style="width:213.25pt;border:solid #70AD47 1.0pt;border-left:none;background:#70AD47;padding:0in 5.4pt 0in 5.4pt">
<p class="xmsonormal" align="center" style="text-align:center"><span style="font-size:10.0pt;color:white">CREATED ON</span><b><span style="color:white"><o:p></o:p></span></b></p>
</td>
</tr>'



SET @body=  @body +  @xml +'</table>'
SET @body=  @body +'<table border="0"  width="750" ><tr><td colspan="4"><tr><td></td></tr>'
SET @body=  @body +'<tr><td><font face="calibri" size="3" color="black">Regards </td></tr>'
SET @body=  @body+'<tr><td><font face="calibri" size="3" color="black">Data Warehouse Administrator </font></td></tr><br>'
SET @body=  @body +'<tr><td><font face="calibri" size="1" color="black">Note: This is an automatically generated email. Please do not reply.
</font></td></tr></table>'


	-- IF no records processed
	IF ISNULL(@body,' ') = ' '
	BEGIN
			SET @body ='<table border="0"  width="1500" ><tr><td colspan="5"><font face="calibri" size="3" color="black"><b>Dear ' + @Name + '</b></td></tr><br>'
			SET @body=  @body +'<tr><td colspan="5"></td></tr>'
			SET @body=  @body +'<tr><td colspan="5"></td></tr>'
			SET @body=  @body +'<tr><td colspan="10"><font face="calibri" size="3" color="black" style="text-decoration;">There are no updates for this run. </td></tr><br><br>'
			SET @body=  @body +'<tr><td colspan="5"></td></tr>'
			SET @body=  @body +'<tr><td colspan="5"></td></tr>'
			SET @body=  @body +'<tr><td colspan="10"><font face="calibri" size="3" color="black" style="text-decoration;">Thank you.</td></tr><br><br>'
			SET @body=  @body + '</table>'

	END 
;

-- EXTRACT RECIPIENTS FROM EMAIL_DELIVERY_LIST TABLE 
SELECT @TO = @TO + Email_ID + ';' FROM [RPDW_UAT].[dbo].[Email_Delivery_list]
 WHERE Report_Name = @Report_Name AND IsActive = 1;

 INSERT INTO [ETL_Email_Table] (
       [CRITERIA_START_DT]
      ,[CRITERIA_END_DT]
      ,[SUBJECT]
      ,[RECIPIENT]
      ,[CC]
      ,[BCC]
      ,[BODY]
) SELECT @DT_START AS [CRITERIA_START_DT]
        ,@DT_END   AS [CRITERIA_END_DT]
		,@Subject  AS [SUBJECT]
		,@TO       AS [RECIPIENT]
		,''
		,''
		,@body     AS [BODY]
;
GO
