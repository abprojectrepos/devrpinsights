USE [RPDW_UAT_PSTG]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetExcelConfigDetail_ManualRun]    Script Date: 3/17/2022 11:28:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_GetExcelConfigDetail_ManualRun]
@Frequency Int 


AS
  

SELECT	SOURCE_SYSTEM, SOURCE_FOLDER, ARCHIVE_FOLDER, SOURCE_NAME, SOURCE_TYPE, TARGET_TABLENAME, SheetName, ARCHIVE_TABLENAME, RETENTION_COPY
FROM	[dbo].[ETL_Job_Config_Pstg_manualrun] WITH(NOLOCK)
WHERE	(SOURCE_TYPE = '.xlsx' OR SOURCE_TYPE = 'xls') AND ACTIVE_STATUS = 'Y' AND FREQUENCY = @Frequency
GO
