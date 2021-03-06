USE [RPDW_UAT]
GO
/****** Object:  StoredProcedure [dbo].[usp_Daily_Email_Notification]    Script Date: 3/17/2022 11:21:27 AM ******/
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
