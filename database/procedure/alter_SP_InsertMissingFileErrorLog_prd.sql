USE [RPDW_PRD_PSTG]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertMissingFileErrorLog]    Script Date: 2/16/2022 2:22:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[SP_InsertMissingFileErrorLog]
@SourceSystem Varchar(255),
@SourceName Varchar(255),
@TargetTable Varchar(255)


AS
  
SET QUOTED_IDENTIFIER OFF

DECLARE @JOB_STATUS_ID Int;


INSERT INTO [RPDW_PRD].[dbo].[ETL_JOB_STATUS] VALUES (@SourceSystem+' - '+@SourceName, 'PSTG', @SourceName, @TargetTable, GETDATE(), 'Fail', 'File Missing', GETDATE());
SET @JOB_STATUS_ID = (SELECT MAX(JOB_STATUS_ID) FROM [RPDW_UAT].[dbo].[ETL_JOB_STATUS] WITH(NOLOCK));
INSERT INTO [RPDW_PRD].[dbo].[ETL_ERROR_LOG] VALUES (@JOB_STATUS_ID, 'File Missing', GETDATE());

