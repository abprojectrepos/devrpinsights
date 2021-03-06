USE [RPDW_UAT_STG]
GO
/****** Object:  Table [dbo].[ETL_JOB_CONFIG_STG_manualrun]    Script Date: 3/21/2022 11:15:00 AM ******/
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
/****** Object:  Table [dbo].[TMP_STG_OASIS_STUDENT_BIRTH_INFO_WRONG]    Script Date: 3/21/2022 11:15:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMP_STG_OASIS_STUDENT_BIRTH_INFO_WRONG](
	[Student_ID] [varchar](11) NOT NULL,
	[Date_of_Birth] [date] NULL,
	[Birth_Location] [varchar](30) NULL,
	[Birth_Country] [varchar](4) NULL,
	[Birth_State] [varchar](6) NULL,
	[Marital_Status] [varchar](11) NULL,
	[Military_Status] [varchar](4) NULL,
	[Residency_Type] [varchar](4) NULL,
	[Expected_Military_Date] [date] NULL,
	[Ethnic_Group] [varchar](10) NULL,
	[Citizenship] [varchar](8) NULL,
	[CREATED_ON] [datetime] NOT NULL,
	[MODIFIED_ON] [datetime] NULL
) ON [PRIMARY]
GO
