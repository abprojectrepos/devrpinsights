USE [RPDW_UAT_PSTG]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCSVConfigDetail_ManualRun]    Script Date: 3/17/2022 11:28:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SP_GetCSVConfigDetail_ManualRun]
@Frequency INT


AS
  

SELECT	SOURCE_SYSTEM, SOURCE_FOLDER, ARCHIVE_FOLDER, SOURCE_NAME, SOURCE_TYPE, Delimiter, TARGET_TABLENAME, ARCHIVE_TABLENAME, RETENTION_COPY
FROM	[dbo].[ETL_Job_Config_Pstg_manualrun] WITH(NOLOCK)
WHERE	SOURCE_TYPE = '.csv' AND ACTIVE_STATUS = 'Y' AND FREQUENCY = @Frequency


GO
