USE [RPDW_UAT_USR]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetStepFailureData]    Script Date: 3/17/2022 11:25:54 AM ******/
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
