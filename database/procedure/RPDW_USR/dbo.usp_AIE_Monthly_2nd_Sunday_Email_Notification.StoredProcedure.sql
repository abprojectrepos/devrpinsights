USE [RPDW_UAT_USR]
GO
/****** Object:  StoredProcedure [dbo].[usp_AIE_Monthly_2nd_Sunday_Email_Notification]    Script Date: 3/17/2022 11:25:54 AM ******/
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
