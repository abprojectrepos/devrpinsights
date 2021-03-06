USE [RPDW_UAT_PSTG]
GO
/****** Object:  Table [dbo].[ETL_JOB_CONFIG_PSTG_manualrun]    Script Date: 3/21/2022 11:06:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_JOB_CONFIG_PSTG_manualrun](
	[PSTG_JOB_CONFIG_ID] [int] IDENTITY(1,1) NOT NULL,
	[SOURCE_SYSTEM] [varchar](255) NULL,
	[SOURCE_FOLDER] [varchar](255) NULL,
	[ARCHIVE_FOLDER] [varchar](255) NULL,
	[SOURCE_NAME] [varchar](255) NULL,
	[SOURCE_TYPE] [varchar](255) NULL,
	[DELIMITER] [varchar](255) NULL,
	[SHEETNAME] [varchar](255) NULL,
	[TARGET_TABLENAME] [varchar](255) NULL,
	[ARCHIVE_TABLENAME] [varchar](255) NULL,
	[ACTIVE_STATUS] [varchar](1) NOT NULL,
	[FREQUENCY] [int] NULL,
	[RETENTION_COPY] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PSTG_OASIS_STUDENT_VISA_PERMIT_DATA]    Script Date: 3/21/2022 11:06:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PSTG_OASIS_STUDENT_VISA_PERMIT_DATA](
	[Student_ID] [varchar](11) NULL,
	[Type] [varchar](4) NULL,
	[Country] [varchar](4) NULL,
	[Classification] [varchar](4) NULL,
	[Effective_Date] [varchar](30) NULL,
	[Number] [varchar](15) NULL,
	[Status] [varchar](4) NULL,
	[Status_Date] [varchar](30) NULL,
	[Issue_Date] [varchar](30) NULL,
	[Duration] [varchar](30) NULL,
	[Duration_Type] [varchar](4) NULL,
	[Date_of_Entry_into_Country] [varchar](30) NULL,
	[Expiration_Date] [varchar](30) NULL,
	[Issuing_Authority] [varchar](50) NULL,
	[Issue_Place] [varchar](30) NULL,
	[Document_ID] [varchar](6) NULL,
	[Descr] [varchar](30) NULL,
	[Created_on] [datetime] NULL,
	[Modified_on] [datetime] NULL
) ON [PRIMARY]
GO
