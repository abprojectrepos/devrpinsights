USE [RPDW_UAT_USR]
GO
/****** Object:  Table [dbo].[ETL_JOB_FREQUENCY]    Script Date: 3/21/2022 11:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_JOB_FREQUENCY](
	[FREQUENCY_ID] [int] IDENTITY(1,1) NOT NULL,
	[FREQUENCY] [varchar](100) NULL,
	[CREATED_ON] [datetime] NULL,
 CONSTRAINT [PK_ETL_JOB_FREQUENCY] PRIMARY KEY CLUSTERED 
(
	[FREQUENCY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
