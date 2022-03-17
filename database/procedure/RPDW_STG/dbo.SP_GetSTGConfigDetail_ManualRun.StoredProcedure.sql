USE [RPDW_UAT_STG]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSTGConfigDetail_ManualRun]    Script Date: 3/17/2022 11:27:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create PROCEDURE [dbo].[SP_GetSTGConfigDetail_ManualRun]
@DW_DB_Name VARCHAR(255),
@Frequency INT


AS

DECLARE 
@SCRIPT VARCHAR(MAX) = ''


SET @SCRIPT = 'SELECT 			SOURCE_TABLENAME, TARGET_TABLENAME, LOAD_TYPE, JOB_NAME
			   FROM				(SELECT STG.SOURCE_TABLENAME, STG.TARGET_TABLENAME, STG.LOAD_TYPE, JS.JOB_NAME, JS.JOB_STATUS,
										ROW_NUMBER() OVER(PARTITION By JS.TARGET_TABLENAME ORDER BY JS.PROCESSED_ON DESC) AS [ROW]
								 FROM   '+@DW_DB_Name+'.dbo.ETL_JOB_STATUS JS WITH(NOLOCK)

									    INNER JOIN [dbo].[ETL_JOB_CONFIG_STG_manualrun] STG WITH(NOLOCK) 
										ON (STG.SOURCE_TABLENAME = JS.TARGET_TABLENAME)

								 WHERE  STAGE = ''PSTG'' AND STG.FREQUENCY = '+CONVERT(VARCHAR(10), @Frequency)+' AND STG.ACTIVE_STATUS = ''Y''
								) AS T
								WHERE T.[ROW] = 1 AND T.JOB_STATUS = ''Success''';


EXEC(@SCRIPT);

GO
