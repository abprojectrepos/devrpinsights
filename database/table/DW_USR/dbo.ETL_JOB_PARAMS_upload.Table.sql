USE [RPDW_UAT_USR]
GO
/****** Object:  Table [dbo].[ETL_JOB_PARAMS_upload]    Script Date: 3/21/2022 11:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_JOB_PARAMS_upload](
	[JOB_PARAM_ID] [nvarchar](50) NOT NULL,
	[JOB_NAME] [nvarchar](50) NOT NULL,
	[FILTER_CRITERIA] [nvarchar](50) NOT NULL,
	[QUAL_TYPE_CRITERIA] [nvarchar](50) NOT NULL,
	[FILTER_CRITERIA_NOTE] [nvarchar](100) NULL,
	[QUAL_TYPE_CRITERIA_NOTE] [nvarchar](100) NULL,
	[CREATED_ON] [datetime2](7) NULL,
	[MODIFIED_ON] [datetime2](7) NULL
) ON [PRIMARY]
GO
