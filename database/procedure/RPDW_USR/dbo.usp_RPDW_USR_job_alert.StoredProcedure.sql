USE [RPDW_UAT_USR]
GO
/****** Object:  StoredProcedure [dbo].[usp_RPDW_USR_job_alert]    Script Date: 3/17/2022 11:25:54 AM ******/
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
