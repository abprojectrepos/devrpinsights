USE [RPDW_UAT_STG]
GO
/****** Object:  Table [dbo].[ETL_JOB_CONFIG_STG_manualrun]    Script Date: 3/21/2022 11:15:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_JOB_CONFIG_STG_manualrun](
	[STG_JOB_CONFIG_ID] [int] IDENTITY(1,1) NOT NULL,
	[JOB_NAME] [varchar](255) NULL,
	[SOURCE_TABLENAME] [varchar](255) NULL,
	[TARGET_TABLENAME] [varchar](255) NULL,
	[FREQUENCY] [int] NULL,
	[LOAD_TYPE] [varchar](10) NULL,
	[ACTIVE_STATUS] [char](1) NOT NULL
) ON [PRIMARY]
GO
