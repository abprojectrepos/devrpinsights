USE [RPDW_UAT_USR]
GO
/****** Object:  StoredProcedure [dbo].[usp_AIE_Monthly_2nd_Sunday_Email_Notification]    Script Date: 3/17/2022 11:25:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_AIE_Monthly_2nd_Sunday_Email_Notification]
AS

DECLARE @TO VARCHAR(400)
DECLARE @Name varchar(100)
DECLARE @Subject varchar(100)
DECLARE @xml NVARCHAR(MAX)
DECLARE @body NVARCHAR(MAX)
DECLARE @DT_START datetime
DECLARE @DT_END varchar(20)
DECLARE @Report_Name VARCHAR(2000);

SET @DT_START = CONVERT(varchar(10),GETDATE(),120) + ' 00:00:00';
SET @DT_END=convert (varchar(10),GETDATE(),120) + ' 23:59:59';
set @Name='Team,';
SET @TO= '';
SET @Report_Name='Monthly 2nd Sunday RPDW_USR Extraction';

SET @Subject=@Report_Name;

--
-- CLEAR EMAIL TABLES
--
TRUNCATE TABLE [dbo].[ETL_Email_Table]; 

IF OBJECT_ID(N'tempdb..##TMP_ETL_LOG') IS NOT NULL
BEGIN
  DROP TABLE ##TMP_ETL_LOG
END;

--
-- GET THE LATEST ENTITIES ETL LOG AND STORE TO ##TMP_ETL_LOG
--
WITH TMP_ETL_LOG AS (

  SELECT TOP 2 
         [JOB_NAME]
        ,[FILENAME]
		,[TGT_CNT]
		,[JOB_STATUS]
		,CONVERT(VARCHAR,[PROCESSED_ON],21) AS [PROCESSED_ON]
  FROM dbo.ETL_JOB_STATUS   
  WHERE [PROCESSED_ON] >= @DT_START and [PROCESSED_ON] <= @DT_END 
  AND [JOB_NAME] IN (
   'DW_ENT_PFP_SURVEY'
  ,'DW_ENT_PFP_SURVEY_RESPONSE'
  )
  ORDER BY PROCESSED_ON DESC

) SELECT JOB_NAME
        ,[FILENAME]
		,[TGT_CNT]
		,[JOB_STATUS]
		,[PROCESSED_ON]
  INTO ##TMP_ETL_LOG 
  FROM TMP_ETL_LOG
  ORDER BY JOB_NAME ASC;

SET @xml =CAST(( SELECT "td/@align"='left', "td/@bgcolor"='white', [JOB_NAME] AS 'td','', 
            "td/@align"='left',"td/@bgcolor"='white',"td/@fontface"='calibri', "td/@fontsize"='3',[FILENAME]  AS 'td','',
            "td/@align"='right', "td/@bgcolor"='white',"td/@fontface"='calibri',"td/@fontsize"='3',CONVERT(VARCHAR, CAST([TGT_CNT]  AS NUMERIC(10, 0)))  AS 'td','',
            "td/@align"='center',"td/@bgcolor"='white',"td/@fontface"='calibri',"td/@fontsize"='3',[JOB_STATUS]  AS 'td','',
            "td/@align"='center',"td/@bgcolor"='white',"td/@fontface"='calibri',"td/@fontsize"='3',[PROCESSED_ON]  AS 'td'
FROM ##TMP_ETL_LOG
ORDER BY JOB_NAME ASC

FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

SET @body ='<table border="0"  width="750" ><tr><td colspan="5"><font face="calibri" size="3" color="black"><b>Dear ' + @Name + '</b></td></tr><br>'
SET @body=  @body +'<tr><td colspan="5"></td></tr>'
SET @body=  @body +'<tr><td colspan="5"><font face="calibri" size="3" color="black">Please find the status of Monthly 2nd Sunday RPDW_USR Extraction below.</td></tr><br></table>'
SET @body=  @body +'<tr><td colspan="5"></td></tr>'


SET @body=  @body +'<table class="MsoTable15Grid4Accent6" border="1" cellspacing="0" cellpadding="0" width="1440" style="width:15.0in;border-collapse:collapse;border:none">
<tbody>
<tr>
<td width="327" valign="top" style="width:245.25pt;border:solid #70AD47 1.0pt;border-right:none;background:#70AD47;padding:0in 5.4pt 0in 5.4pt">
<p class="xmsonormal" align="center" style="text-align:center"><span style="font-size:10.0pt;color:white">JOB NAME</span><b><span style="color:white"><o:p></o:p></span></b></p>
</td>
<td width="475" valign="top" style="width:356.6pt;border-top:solid #70AD47 1.0pt;border-left:none;border-bottom:solid #70AD47 1.0pt;border-right:none;background:#70AD47;padding:0in 5.4pt 0in 5.4pt">
<p class="xmsonormal" align="center" style="text-align:center"><span style="font-size:10.0pt;color:white">OUTPUT FILENAME</span><b><span style="color:white"><o:p></o:p></span></b></p>
</td>
<td width="201" valign="top" style="width:150.45pt;border-top:solid #70AD47 1.0pt;border-left:none;border-bottom:solid #70AD47 1.0pt;border-right:none;background:#70AD47;padding:0in 5.4pt 0in 5.4pt">
<p class="xmsonormal" align="center" style="text-align:center"><span style="font-size:10.0pt;color:white">RECORD COUNT</span><b><span style="color:white"><o:p></o:p></span></b></p>
</td>
<td width="201" valign="top" style="width:150.45pt;border-top:solid #70AD47 1.0pt;border-left:none;border-bottom:solid #70AD47 1.0pt;border-right:none;background:#70AD47;padding:0in 5.4pt 0in 5.4pt">
<p class="xmsonormal" align="center" style="text-align:center"><span style="font-size:10.0pt;color:white">STATUS</span><b><span style="color:white"><o:p></o:p></span></b></p>
</td>
<td width="284" valign="top" style="width:213.25pt;border:solid #70AD47 1.0pt;border-left:none;background:#70AD47;padding:0in 5.4pt 0in 5.4pt">
<p class="xmsonormal" align="center" style="text-align:center"><span style="font-size:10.0pt;color:white">PROCESSED ON</span><b><span style="color:white"><o:p></o:p></span></b></p>
</td>
</tr>'



SET @body=  @body +  @xml +'</table>'
SET @body=  @body +'<table border="0"  width="750" ><tr><td colspan="4"><tr><td></td></tr>'
SET @body=  @body +'<tr><td><font face="calibri" size="3" color="black">Regards </td></tr>'
SET @body=  @body+'<tr><td><font face="calibri" size="3" color="black">BI Administrator </font></td></tr><br>'
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
SELECT @TO = @TO + Email_ID + ';' FROM [dbo].[Email_Delivery_list]
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
/****** Object:  StoredProcedure [dbo].[usp_GetStepFailureData]    Script Date: 3/17/2022 11:25:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_GetStepFailureData]
(
@JobName VARCHAR(250),
@StepFailed VARCHAR(20) OUTPUT,
@DateRun VARCHAR(10) OUTPUT,
@TimeRun VARCHAR(10) OUTPUT,
@StepName VARCHAR(50) OUTPUT,
@RunDuration VARCHAR(10) OUTPUT,
@LogOutput VARCHAR(MAX) OUTPUT
)
AS
/*
This procedure gets failure log data for the failed step of a SQL Server Agent job
*/
DECLARE @job_id UNIQUEIDENTIFIER
SELECT @job_id = job_id FROM msdb.dbo.sysjobs WHERE [name] = @JobName
SELECT @StepFailed='Step ' + CAST(JH.step_id AS VARCHAR(3)) + ' of ' + (SELECT CAST(COUNT(*) AS VARCHAR(5)) FROM msdb.dbo.sysjobsteps WHERE job_id = @job_id),-- AS StepFailed,
@DateRun=CAST(RIGHT(JH.run_date,2) AS CHAR(2)) + '/' + CAST(SUBSTRING(CAST(JH.run_date AS CHAR(8)),5,2) AS CHAR(2)) + '/' + CAST(LEFT(JH.run_date,4) AS CHAR(4)),-- AS DateRun,
@TimeRun=LEFT(RIGHT('0' + CAST(JH.run_time AS VARCHAR(6)),6),2) + ':' + SUBSTRING(RIGHT('0' + CAST(JH.run_time AS VARCHAR(6)),6),3,2) + ':' + LEFT(RIGHT('0' + CAST(JH.run_time AS VARCHAR(6)),6),2),-- AS TimeRun,
@StepName=JS.step_name, 
 --@RunDuration=msdb.dbo.get_time_format(JH.run_duration), 
 @RunDuration=(JH.run_duration), 

--dbo.get_time_format (run_duration) run_duration,
@LogOutput=
CASE
WHEN JSL.[log] IS NULL THEN JH.[Message]
ELSE JSL.[log]
END --AS LogOutput
FROM msdb.dbo.sysjobsteps JS INNER JOIN msdb.dbo.sysjobhistory JH 
 ON JS.job_id = JH.job_id AND JS.step_id = JH.step_id 
 LEFT OUTER JOIN msdb.dbo.sysjobstepslogs JSL
ON JS.step_uid = JSL.step_uid
WHERE INSTANCE_ID IN
(
SELECT INSTANCE_ID
FROM msdb.dbo.sysjobhistory
WHERE job_id = @job_id
AND RUN_STATUS = 0
AND RUN_DATE=CONVERT(int,convert(varchar, year(getdate())) + convert(varchar, right(100+ month(getdate()),2))+  convert(varchar, right(100+day(getdate()),2)))
--ORDER BY INSTANCE_ID desc

)
AND JS.step_id <> 0 
 AND JH.job_id = @job_id
AND JH.run_status = 0
ORDER BY JS.step_id ASC


GO
/****** Object:  StoredProcedure [dbo].[usp_RPDW_USR_job_alert]    Script Date: 3/17/2022 11:25:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_RPDW_USR_job_alert]
(
@JobName VARCHAR(250)
)
AS
declare @sub varchar(250)
declare @message nvarchar(max)

DECLARE @StepFailed VARCHAR(20)
DECLARE @DateRun VARCHAR(10) 
DECLARE @TimeRun VARCHAR(10) 
DECLARE @StepName VARCHAR(50)
DECLARE @RunDuration VARCHAR(10) 
DECLARE @LogOutput VARCHAR(MAX) 

EXEC usp_GetStepFailureData @JobName, @StepFailed=@StepFailed OUTPUT, @DateRun=@DateRun OUTPUT, @TimeRun=@TimeRun OUTPUT, @StepName=@StepName OUTPUT, @RunDuration=@RunDuration OUTPUT, @LogOutput=@LogOutput OUTPUT


SET @message='<style type="text/css">.nobrtable br { display: none }</style><div class="nobrtable"><body style="margin-top:8px; margin-left:8px;"><table border="0"  width="750" >
<tr><td style="font-family:calibri; font-size:11pt; color:black; font-weight:bold;">Dear  All</td></tr><br>'
SET @message=@message+ '<tr><td colspan="5" height="10"></td></tr>'
SET @message=@message+ '<tr><td colspan="5" style="font-family:calibri; font-size:11pt; color:black; font-style:normal;">
Please find the details below:</td></tr><br>'
SET @message=@message+ '<tr><td colspan="5" height="10"></td></tr></table>'
SET @message=@message+ '<table bgcolor="" width="750"  cellpadding="0" style="border: solid SteelBlue;border-collapse: collapse;border-width:1px;">'
SET @message=@message+ '<tr><td width="100" align="left" bgcolor="white" style="border: solid SteelBlue;border-collapse: collapse;border-width:1px;padding-left: 5px; 
font-family:calibri; font-size:11pt; color:black;">Job Name</td>
<td width="650" align="left" bgcolor="white" style="border: solid SteelBlue;border-collapse: collapse;border-width:1px; padding-left: 5px;
font-family:calibri; font-size:11pt; color:darkblue;">' + @JobName +' </td></tr>'

SET @message=@message+ '<tr><td rowspan="2" width="100" align="left" bgcolor="white" style="border: solid SteelBlue;border-collapse: collapse;border-width:1px;padding-left: 5px;
font-family:calibri; font-size:11pt; color:black;" valign="top">Failed At</td>
<td width="650" align="left" bgcolor="white" style="border: solid SteelBlue;border-collapse: collapse;border-width:1px; padding-left: 5px;
font-family:calibri; font-size:11pt; color:darkblue;">' + @StepFailed + '</td></tr>
<td width="650" align="left" bgcolor="white" style="border: solid SteelBlue;border-collapse: collapse;border-width:1px; padding-left: 5px;
font-family:calibri; font-size:11pt; color:darkblue;">'  + @StepName + '</td></tr>'

SET @message=@message+ '<tr><td width="100" align="left" bgcolor="white" style="border: solid SteelBlue;border-collapse: collapse;border-width:1px;padding-left: 5px;
font-family:calibri; font-size:11pt; color:black;">Started At</td>
<td width="650" align="left" bgcolor="white" style="border: solid SteelBlue;border-collapse: collapse;border-width:1px; padding-left: 5px;
font-family:calibri; font-size:11pt; color:darkblue;">' + @DateRun + ' ' + @TimeRun + '</td></tr>'

SET @message=@message+ '<tr><td width="100" align="left" bgcolor="white" style="border: solid SteelBlue;border-collapse: collapse;border-width:1px;padding-left: 5px;
font-family:calibri; font-size:11pt; color:black;">Duration</td>
<td width="650" align="left" bgcolor="white" style="border: solid SteelBlue;border-collapse: collapse;border-width:1px; padding-left: 5px; 
font-family:calibri; font-size:11pt; color:darkblue;">' + @RunDuration +'</td></tr>'

SET @message=@message+ '<tr><td width="100" align="left" bgcolor="white" style="border: solid SteelBlue;border-collapse: collapse;border-width:1px;padding-left: 5px; 
font-family:calibri; font-size:11pt; color:black;" valign="top">Error Details</td>
<td width="650" align="left" bgcolor="white" style="border: solid SteelBlue;border-collapse: collapse;border-width:1px; padding-left: 5px;
font-family:calibri; font-size:11pt; color:darkblue;">' + @LogOutput + '</td></tr>'

SET @message=@message+ '</table> </table></div> <table border="0"  width="750" ><tr><td colspan="4" height="15"></td></tr>'
SET @message=@message+ '<tr><td colspan="5"  style="font-family:calibri; font-size:11pt; color:black;">Regards </td></tr>'
SET @message=@message+ '<tr><td colspan="5" style="font-family:calibri; font-size:11pt; color:black;">RPDW_USR BI Administrator </font></td></tr>
<tr><td colspan="4" height="20"></td></tr>'
SET @message=@message+ '<tr><td colspan="5" style="font-family:calibri; font-size:9pt; color:black;font-weight:italic;"><i>Note: This is an automatically generated email. Please do not reply.</i></td></tr></table></body>'

--/*
set @sub='RPDW_USR Data Loading Job Alert'
EXEC msdb..sp_send_dbmail
@profile_name = 'RPDW',
@recipients='daniel_tan4@rp.edu.sg;',
@copy_recipients =NULL,
@blind_copy_recipients =NULL,
@subject=@sub,
@body=@message,
@body_format='HTML'
--*/

SELECT @JobName,@StepFailed,@DateRun,@TimeRun,@StepName,@RunDuration,@LogOutput,@message


GO
