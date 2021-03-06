USE [RPDW_UAT]
GO
/****** Object:  View [dbo].[V_DW_EXT_JAE_APPEAL]    Script Date: 3/21/2022 11:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
[DW_EXT_V_JPAE_POSTFILE]
[DW_EXT_V_PFP]
[MASKED_NATIONAL_ID]
[DW_EXT_JAE_POSTFILE]
[dbo].[DW_EXT_JAE_APPEAL]
*/
CREATE view  [dbo].[V_DW_EXT_JAE_APPEAL]
AS
SELECT [MASKED_NATIONAL_ID]
      ,[Name]
      ,[DOB]
      ,[NRIC]
      ,[Password]
      ,[Mobile]
      ,[HomePhone]
      ,[Email]
      ,[HouseNo]
      ,[UnitNo]
      ,[Street]
      ,[PostalCode]
      ,[Agg_T]
      ,[Agg_B]
      ,[Agg_A]
      ,[Agg_S]
      ,[ECA]
      ,[Choice1]
      ,[Choice2]
      ,[Choice3]
      ,[Result]
      ,[Update_On]
      ,[T_Eli]
      ,[NT_Eli]
      ,[S_Eli]
      ,[A_Eli]
      ,[Posted_Agg]
      ,[Eligibl_List]
      ,[Citizenship]
      ,[Choice1_Net_Agg]
      ,[Choice2_Net_Agg]
      ,[Choice3_Net_Agg]
      ,[Choice1_Ranking]
      ,[Choice2_Ranking]
      ,[Choice3_Ranking]
      ,[Posted_Choice_No]
      ,[Maths_Grade]
      ,[Eng_Grade]
      ,[No_A1s]
      ,[No_A2s]
      ,[No_B3s]
      ,[No_B4s]
      ,[No_C5s]
      ,[No_C6s]
      ,[L1R5]
      ,[L1R4]
      ,[JAE_Posted]
   ,Created_On [ETL_Loaded_On]
	  ,Modified_On [ETL_Last_Updated_On]
	  FROM  [DW_EXT_JAE_APPEAL]
GO
/****** Object:  View [dbo].[V_DW_EXT_JAE_POSTFILE]    Script Date: 3/21/2022 11:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--CREATE 
CREATE VIEW [dbo].[V_DW_EXT_JAE_POSTFILE]
AS
SELECT [SEC_SCHOOL_CD]
      ,[LANG_MEDIUM]
      ,[STATUTORY_NM]
      ,[HYPY_NM]
      ,[MASKED_NATIONAL_ID]
      ,[CITIZENSHIP_CD]
      ,[STREAM_CD]
      ,[GENDER]
      ,[RACE_CD]
      ,[YEAR_EXAM]
      ,[NO_GRADE1_6]
      ,[NO_GRADE7_8]
      ,[NO_GRADE9]
      ,[NO_SUBJECT_ENTERED]
      ,[JAE_SUBJECT_CD_1]
      ,[JAE_GRADE_1]
      ,[BETTER_GRADE_1]
      ,[CORE_CATEG_1]
      ,[JAE_SUBJECT_CD_2]
      ,[JAE_GRADE_2]
      ,[BETTER_GRADE_2]
      ,[CORE_CATEG_2]
      ,[JAE_SUBJECT_CD_3]
      ,[JAE_GRADE_3]
      ,[BETTER_GRADE_3]
      ,[CORE_CATEG_3]
      ,[JAE_SUBJECT_CD_4]
      ,[JAE_GRADE_4]
      ,[BETTER_GRADE_4]
      ,[CORE_CATEG_4]
      ,[JAE_SUBJECT_CD_5]
      ,[JAE_GRADE_5]
      ,[BETTER_GRADE_5]
      ,[CORE_CATEG_5]
      ,[JAE_SUBJECT_CD_6]
      ,[JAE_GRADE_6]
      ,[BETTER_GRADE_6]
      ,[CORE_CATEG_6]
      ,[JAE_SUBJECT_CD_7]
      ,[JAE_GRADE_7]
      ,[BETTER_GRADE_7]
      ,[CORE_CATEG_7]
      ,[JAE_SUBJECT_CD_8]
      ,[JAE_GRADE_8]
      ,[BETTER_GRADE_8]
      ,[CORE_CATEG_8]
      ,[JAE_SUBJECT_CD_9]
      ,[JAE_GRADE_9]
      ,[BETTER_GRADE_9]
      ,[CORE_CATEG_9]
      ,[JAE_SUBJECT_CD_10]
      ,[JAE_GRADE_10]
      ,[BETTER_GRADE_10]
      ,[CORE_CATEG_10]
      ,[JAE_SUBJECT_CD_11]
      ,[JAE_GRADE_11]
      ,[BETTER_GRADE_11]
      ,[CORE_CATEG_11]
      ,[JAE_SUBJECT_CD_12]
      ,[JAE_GRADE_12]
      ,[BETTER_GRADE_12]
      ,[CORE_CATEG_12]
      ,[ADDRESS1]
      ,[ADDRESS2]
      ,[ADDRESS3]
      ,[POSTAL_CD]
      ,[TEL_NO]
      ,[BIRTH_PLACE]
      ,[L1_GRADE]
      ,[L2_GRADE]
      ,[EL1_GRADE]
      ,[CL1_GRADE]
      ,[EL2_GRADE]
      ,[CL2_GRADE]
      ,[SEC_L1_GRADE]
      ,[ML1_GRADE]
      ,[TL1_GRADE]
      ,[ML2_GRADE]
      ,[TL2_GRADE]
      ,[L1B4_AGG_RAW]
      ,[POSTED_POINT]
      ,[INSTITN_ELIG]
      ,[R5_DISTINCTIONS]
      ,[ENGLISH_CD]
      ,[MATHS_CD]
      ,[SCIENCE_CD]
      ,[ENGLISH_GRADE]
      ,[MATHS_GRADE]
      ,[SCIENCE_GRADE]
      ,[NO_GRADE1]
      ,[NO_GRADE2]
      ,[NO_GRADE3]
      ,[NO_GRADE4]
      ,[NO_GRADE5]
      ,[NO_GRADE6]
      ,[L1L2_CD]
      ,[YR_FIRST_SITTING]
      ,[YR_SECOND_SITTING]
      ,[ROD_DATE]
      ,[RELIGION_CD]
      ,[NS_CD]
      ,[DOB]
      ,[COURSE_CD_1]
      ,[COURSE_ORDER_1]
      ,[COURSE_CD_2]
      ,[COURSE_ORDER_2]
      ,[COURSE_CD_3]
      ,[COURSE_ORDER_3]
      ,[COURSE_CD_4]
      ,[COURSE_ORDER_4]
      ,[COURSE_CD_5]
      ,[COURSE_ORDER_5]
      ,[COURSE_CD_6]
      ,[COURSE_ORDER_6]
      ,[COURSE_CD_7]
      ,[COURSE_ORDER_7]
      ,[COURSE_CD_8]
      ,[COURSE_ORDER_8]
      ,[COURSE_CD_9]
      ,[COURSE_ORDER_9]
      ,[COURSE_CD_10]
      ,[COURSE_ORDER_10]
      ,[COURSE_CD_11]
      ,[COURSE_ORDER_11]
      ,[COURSE_CD_12]
      ,[COURSE_ORDER_12]
      ,[POSTED_COURSE]
      ,[POSTED_CENTRE_CD]
      ,[ORIGINAL_CHOICE_ORDER]
      ,[GENERATED_CHOICE_ORDER]
      ,[ECA_GRADE]
      ,[L1R5_AGG_ RAW]
      ,[L1R4_AGG_ RAW]
      ,[FILLER]
      ,[ELR2B2_A_AGG_ RAW]
      ,[ELR2B2_B_AGG_ RAW]
      ,[ELR2B2_C_AGG_ RAW]
      ,[ELR2B2_D_AGG_RAW]
      ,[POLY_A_ELIGIBILITY]
      ,[POLY_B_ELIGIBILITY]
      ,[POLY_C_ELIGIBILITY]
      ,[POLY_D_ELIGIBILITY]
      ,[ITE_ELIGIBILITY]
      ,[AGG_POSTED]
      ,[PVT_CDDT_SEC_SCHOOL_CD]
      ,[TI_COURSES_ELIGIBLE_1]
      ,[TI_COURSES_ELIGIBLE_2]
      ,[TI_COURSES_ELIGIBLE_3]
      ,[TI_COURSES_ELIGIBLE_4]
      ,[TI_COURSES_ELIGIBLE_5]
      ,[TI_COURSES_ELIGIBLE_6]
      ,[TI_COURSES_ELIGIBLE_7]
      ,[TI_COURSES_ELIGIBLE_8]
      ,[TI_COURSES_ELIGIBLE_9]
      ,[TI_COURSES_ELIGIBLE_10]
      ,[TI_COURSES_ELIGIBLE_11]
      ,[TI_COURSES_ELIGIBLE_12]
      ,[TI_COURSES_ELIGIBLE_13]
      ,[TI_COURSES_ELIGIBLE_14]
      ,[TI_COURSES_ELIGIBLE_15]
      ,[TI_COURSES_ELIGIBLE_16]
      ,[TI_COURSES_ELIGIBLE_17]
      ,[TI_COURSES_ELIGIBLE_18]
      ,[TI_COURSES_ELIGIBLE_19]
      ,[TI_COURSES_ELIGIBLE_20]
      ,[TI_COURSES_ELIGIBLE_21]
      ,[TI_COURSES_ELIGIBLE_22]
      ,[TI_COURSES_ELIGIBLE_23]
      ,[TI_COURSES_ELIGIBLE_24]
      ,[TI_COURSES_ELIGIBLE_25]
      ,[TI_COURSES_ELIGIBLE_26]
      ,[TI_COURSES_ELIGIBLE_27]
      ,[TI_COURSES_ELIGIBLE_28]
      ,[TI_COURSES_ELIGIBLE_29]
      ,[TI_COURSES_ELIGIBLE_30]
      ,[TI_COURSES_ELIGIBLE_31]
      ,[TI_COURSES_ELIGIBLE_32]
      ,[TI_COURSES_ELIGIBLE_33]
      ,[TI_COURSES_ELIGIBLE_34]
      ,[TI_COURSES_ELIGIBLE_35]
      ,[TI_COURSES_ELIGIBLE_36]
      ,[TI_COURSES_ELIGIBLE_37]
      ,[TI_COURSES_ELIGIBLE_38]
      ,[TI_COURSES_ELIGIBLE_39]
      ,[TI_COURSES_ELIGIBLE_40]
      ,[TI_COURSES_ELIGIBLE_41]
      ,[TI_COURSES_ELIGIBLE_42]
      ,[TI_COURSES_ELIGIBLE_43]
      ,[TI_COURSES_ELIGIBLE_44]
      ,[TI_COURSES_ELIGIBLE_45]
      ,[TI_COURSES_ELIGIBLE_46]
      ,[TI_COURSES_ELIGIBLE_47]
      ,[TI_COURSES_ELIGIBLE_48]
      ,[TI_COURSES_ELIGIBLE_49]
      ,[TI_COURSES_ELIGIBLE_50]
      ,[TI_COURSES_ELIGIBLE_51]
      ,[TI_COURSES_ELIGIBLE_52]
      ,[TI_COURSES_ELIGIBLE_53]
      ,[TI_COURSES_ELIGIBLE_54]
      ,[TI_COURSES_ELIGIBLE_55]
      ,[TI_COURSES_ELIGIBLE_56]
      ,[TI_COURSES_ELIGIBLE_57]
      ,[TI_COURSES_ELIGIBLE_58]
      ,[TI_COURSES_ELIGIBLE_59]
      ,[TI_COURSES_ELIGIBLE_60]
      ,[TI_COURSES_ELIGIBLE_61]
      ,[TI_COURSES_ELIGIBLE_62]
      ,[TI_COURSES_ELIGIBLE_63]
      ,[TI_COURSES_ELIGIBLE_64]
      ,[TI_COURSES_ELIGIBLE_65]
      ,[TI_COURSES_ELIGIBLE_66]
      ,[TI_COURSES_ELIGIBLE_67]
      ,[TI_COURSES_ELIGIBLE_68]
      ,[TI_COURSES_ELIGIBLE_69]
      ,[TI_COURSES_ELIGIBLE_70]
      ,[TI_COURSES_ELIGIBLE_71]
      ,[TI_COURSES_ELIGIBLE_72]
      ,[TI_COURSES_ELIGIBLE_73]
      ,[TI_COURSES_ELIGIBLE_74]
      ,[TI_COURSES_ELIGIBLE_75]
      ,[TI_COURSES_ELIGIBLE_76]
      ,[TI_COURSES_ELIGIBLE_77]
      ,[TI_COURSES_ELIGIBLE_78]
      ,[TI_COURSES_ELIGIBLE_79]
      ,[TI_COURSES_ELIGIBLE_80]
      ,[TI_COURSES_ELIGIBLE_81]
      ,[TI_COURSES_ELIGIBLE_82]
      ,[TI_COURSES_ELIGIBLE_83]
      ,[TI_COURSES_ELIGIBLE_84]
      ,[TI_COURSES_ELIGIBLE_85]
      ,[TI_COURSES_ELIGIBLE_86]
      ,[TI_COURSES_ELIGIBLE_87]
      ,[TI_COURSES_ELIGIBLE_88]
      ,[TI_COURSES_ELIGIBLE_89]
      ,[TI_COURSES_ELIGIBLE_90]
      ,[TI_COURSES_ELIGIBLE_91]
      ,[TI_COURSES_ELIGIBLE_92]
      ,[TI_COURSES_ELIGIBLE_93]
      ,[TI_COURSES_ELIGIBLE_94]
      ,[TI_COURSES_ELIGIBLE_95]
      ,[TI_COURSES_ELIGIBLE_96]
      ,[TI_COURSES_ELIGIBLE_97]
      ,[TI_COURSES_ELIGIBLE_98]
      ,[TI_COURSES_ELIGIBLE_99]
      ,[TI_COURSES_ELIGIBLE_100]
      ,[TI_COURSES_ELIGIBLE_101]
      ,[TI_COURSES_ELIGIBLE_102]
      ,[TI_COURSES_ELIGIBLE_103]
      ,[TI_COURSES_ELIGIBLE_104]
      ,[TI_COURSES_ELIGIBLE_105]
      ,[TI_COURSES_ELIGIBLE_106]
      ,[TI_COURSES_ELIGIBLE_107]
      ,[TI_COURSES_ELIGIBLE_108]
      ,[TI_COURSES_ELIGIBLE_109]
      ,[TI_COURSES_ELIGIBLE_110]
      ,[TI_COURSES_ELIGIBLE_111]
      ,[TI_COURSES_ELIGIBLE_112]
      ,[TI_COURSES_ELIGIBLE_113]
      ,[TI_COURSES_ELIGIBLE_114]
      ,[TI_COURSES_ELIGIBLE_115]
      ,[TI_COURSES_ELIGIBLE_116]
      ,[TI_COURSES_ELIGIBLE_117]
      ,[TI_COURSES_ELIGIBLE_118]
      ,[TI_COURSES_ELIGIBLE_119]
      ,[TI_COURSES_ELIGIBLE_120]
      ,[TI_COURSES_ELIGIBLE_121]
      ,[TI_COURSES_ELIGIBLE_122]
      ,[TI_COURSES_ELIGIBLE_123]
      ,[TI_COURSES_ELIGIBLE_124]
      ,[TI_COURSES_ELIGIBLE_125]
      ,[TI_COURSES_ELIGIBLE_126]
      ,[TI_COURSES_ELIGIBLE_127]
      ,[TI_COURSES_ELIGIBLE_128]
      ,[TI_COURSES_ELIGIBLE_129]
      ,[TI_COURSES_ELIGIBLE_130]
      ,[TI_COURSES_ELIGIBLE_131]
      ,[TI_COURSES_ELIGIBLE_132]
      ,[TI_COURSES_ELIGIBLE_133]
      ,[TI_COURSES_ELIGIBLE_134]
      ,[TI_COURSES_ELIGIBLE_135]
      ,[TI_COURSES_ELIGIBLE_136]
      ,[TI_COURSES_ELIGIBLE_137]
      ,[TI_COURSES_ELIGIBLE_138]
      ,[TI_COURSES_ELIGIBLE_139]
      ,[TI_COURSES_ELIGIBLE_140]
      ,[TI_COURSES_ELIGIBLE_141]
      ,[TI_COURSES_ELIGIBLE_142]
      ,[TI_COURSES_ELIGIBLE_143]
      ,[TI_COURSES_ELIGIBLE_144]
      ,[TI_COURSES_ELIGIBLE_145]
      ,[TI_COURSES_ELIGIBLE_146]
      ,[TI_COURSES_ELIGIBLE_147]
      ,[TI_COURSES_ELIGIBLE_148]
      ,[TI_COURSES_ELIGIBLE_149]
      ,[TI_COURSES_ELIGIBLE_150]
      ,[TI_COURSES_ELIGIBLE_151]
      ,[TI_COURSES_ELIGIBLE_152]
      ,[TI_COURSES_ELIGIBLE_153]
      ,[TI_COURSES_ELIGIBLE_154]
      ,[TI_COURSES_ELIGIBLE_155]
      ,[TI_COURSES_ELIGIBLE_156]
      ,[TI_COURSES_ELIGIBLE_157]
      ,[TI_COURSES_ELIGIBLE_158]
      ,[TI_COURSES_ELIGIBLE_159]
      ,[TI_COURSES_ELIGIBLE_160]
      ,[TI_COURSES_ELIGIBLE_161]
      ,[TI_COURSES_ELIGIBLE_162]
      ,[TI_COURSES_ELIGIBLE_163]
      ,[TI_COURSES_ELIGIBLE_164]
      ,[TI_COURSES_ELIGIBLE_165]
      ,[TI_COURSES_ELIGIBLE_166]
      ,[TI_COURSES_ELIGIBLE_167]
      ,[TI_COURSES_ELIGIBLE_168]
      ,[TI_COURSES_ELIGIBLE_169]
      ,[TI_COURSES_ELIGIBLE_170]
      ,[TI_COURSES_ELIGIBLE_171]
      ,[TI_COURSES_ELIGIBLE_172]
      ,[TI_COURSES_ELIGIBLE_173]
      ,[TI_COURSES_ELIGIBLE_174]
      ,[TI_COURSES_ELIGIBLE_175]
      ,[TI_COURSES_ELIGIBLE_176]
      ,[TI_COURSES_ELIGIBLE_177]
      ,[TI_COURSES_ELIGIBLE_178]
      ,[TI_COURSES_ELIGIBLE_179]
      ,[TI_COURSES_ELIGIBLE_180]
      ,[TI_COURSES_ELIGIBLE_181]
      ,[TI_COURSES_ELIGIBLE_182]
      ,[TI_COURSES_ELIGIBLE_183]
      ,[TI_COURSES_ELIGIBLE_184]
      ,[TI_COURSES_ELIGIBLE_185]
      ,[TI_COURSES_ELIGIBLE_186]
      ,[TI_COURSES_ELIGIBLE_187]
      ,[TI_COURSES_ELIGIBLE_188]
      ,[TI_COURSES_ELIGIBLE_189]
      ,[TI_COURSES_ELIGIBLE_190]
      ,[TI_COURSES_ELIGIBLE_191]
      ,[TI_COURSES_ELIGIBLE_192]
      ,[TI_COURSES_ELIGIBLE_193]
      ,[TI_COURSES_ELIGIBLE_194]
      ,[TI_COURSES_ELIGIBLE_195]
      ,[TI_COURSES_ELIGIBLE_196]
      ,[TI_COURSES_ELIGIBLE_197]
      ,[TI_COURSES_ELIGIBLE_198]
      ,[TI_COURSES_ELIGIBLE_199]
      ,[TI_COURSES_ELIGIBLE_200]
      ,[TI_COURSES_ELIGIBLE_201]
      ,[TI_COURSES_ELIGIBLE_202]
      ,[TI_COURSES_ELIGIBLE_203]
      ,[TI_COURSES_ELIGIBLE_204]
      ,[TI_COURSES_ELIGIBLE_205]
      ,[TI_COURSES_ELIGIBLE_206]
      ,[TI_COURSES_ELIGIBLE_207]
      ,[TI_COURSES_ELIGIBLE_208]
      ,[TI_COURSES_ELIGIBLE_209]
      ,[TI_COURSES_ELIGIBLE_210]
      ,[TI_COURSES_ELIGIBLE_211]
      ,[TI_COURSES_ELIGIBLE_212]
      ,[TI_COURSES_ELIGIBLE_213]
      ,[TI_COURSES_ELIGIBLE_214]
      ,[TI_COURSES_ELIGIBLE_215]
      ,[TI_COURSES_ELIGIBLE_216]
      ,[TI_COURSES_ELIGIBLE_217]
      ,[TI_COURSES_ELIGIBLE_218]
      ,[TI_COURSES_ELIGIBLE_219]
      ,[TI_COURSES_ELIGIBLE_220]
      ,[TI_COURSES_ELIGIBLE_221]
      ,[TI_COURSES_ELIGIBLE_222]
      ,[TI_COURSES_ELIGIBLE_223]
      ,[TI_COURSES_ELIGIBLE_224]
      ,[TI_COURSES_ELIGIBLE_225]
      ,[TI_COURSES_ELIGIBLE_226]
      ,[TI_COURSES_ELIGIBLE_227]
      ,[TI_COURSES_ELIGIBLE_228]
      ,[TI_COURSES_ELIGIBLE_229]
      ,[TI_COURSES_ELIGIBLE_230]
      ,[TI_COURSES_ELIGIBLE_231]
      ,[TI_COURSES_ELIGIBLE_232]
      ,[TI_COURSES_ELIGIBLE_233]
      ,[TI_COURSES_ELIGIBLE_234]
      ,[TI_COURSES_ELIGIBLE_235]
      ,[TI_COURSES_ELIGIBLE_236]
      ,[TI_COURSES_ELIGIBLE_237]
      ,[TI_COURSES_ELIGIBLE_238]
      ,[TI_COURSES_ELIGIBLE_239]
      ,[TI_COURSES_ELIGIBLE_240]
      ,[TI_COURSES_ELIGIBLE_241]
      ,[TI_COURSES_ELIGIBLE_242]
      ,[TI_COURSES_ELIGIBLE_243]
      ,[TI_COURSES_ELIGIBLE_244]
      ,[TI_COURSES_ELIGIBLE_245]
      ,[TI_COURSES_ELIGIBLE_246]
      ,[TI_COURSES_ELIGIBLE_247]
      ,[TI_COURSES_ELIGIBLE_248]
      ,[TI_COURSES_ELIGIBLE_249]
      ,[TI_COURSES_ELIGIBLE_250]
      ,[TI_COURSES_ELIGIBLE_251]
      ,[TI_COURSES_ELIGIBLE_252]
      ,[TI_COURSES_ELIGIBLE_253]
      ,[TI_COURSES_ELIGIBLE_254]
      ,[TI_COURSES_ELIGIBLE_255]
      ,[TI_COURSES_ELIGIBLE_256]
      ,[TI_COURSES_ELIGIBLE_257]
      ,[TI_COURSES_ELIGIBLE_258]
      ,[TI_COURSES_ELIGIBLE_259]
      ,[TI_COURSES_ELIGIBLE_260]
      ,[TI_COURSES_ELIGIBLE_261]
      ,[TI_COURSES_ELIGIBLE_262]
      ,[TI_COURSES_ELIGIBLE_263]
      ,[TI_COURSES_ELIGIBLE_264]
      ,[TI_COURSES_ELIGIBLE_265]
      ,[TI_COURSES_ELIGIBLE_266]
      ,[TI_COURSES_ELIGIBLE_267]
      ,[TI_COURSES_ELIGIBLE_268]
      ,[TI_COURSES_ELIGIBLE_269]
      ,[TI_COURSES_ELIGIBLE_270]
      ,[TI_COURSES_ELIGIBLE_271]
      ,[TI_COURSES_ELIGIBLE_272]
      ,[TI_COURSES_ELIGIBLE_273]
      ,[TI_COURSES_ELIGIBLE_274]
      ,[TI_COURSES_ELIGIBLE_275]
      ,[TI_COURSES_ELIGIBLE_276]
      ,[TI_COURSES_ELIGIBLE_277]
      ,[TI_COURSES_ELIGIBLE_278]
      ,[TI_COURSES_ELIGIBLE_279]
      ,[TI_COURSES_ELIGIBLE_280]
      ,[TI_COURSES_ELIGIBLE_281]
      ,[TI_COURSES_ELIGIBLE_282]
      ,[TI_COURSES_ELIGIBLE_283]
      ,[TI_COURSES_ELIGIBLE_284]
      ,[TI_COURSES_ELIGIBLE_285]
      ,[TI_COURSES_ELIGIBLE_286]
      ,[TI_COURSES_ELIGIBLE_287]
      ,[TI_COURSES_ELIGIBLE_288]
      ,[TI_COURSES_ELIGIBLE_289]
      ,[TI_COURSES_ELIGIBLE_290]
      ,[TI_COURSES_ELIGIBLE_291]
      ,[TI_COURSES_ELIGIBLE_292]
      ,[TI_COURSES_ELIGIBLE_293]
      ,[TI_COURSES_ELIGIBLE_294]
      ,[TI_COURSES_ELIGIBLE_295]
      ,[TI_COURSES_ELIGIBLE_296]
      ,[TI_COURSES_ELIGIBLE_297]
      ,[TI_COURSES_ELIGIBLE_298]
      ,[TI_COURSES_ELIGIBLE_299]
      ,[TI_COURSES_ELIGIBLE_300]
      ,[PDB_CITIZENSHIP]
      ,[ITE_ELR2B2_C_AGG_ RAW]
      ,[ITE_ELB4_A_AGG_ RAW]
      ,[ITE_ELR1B3_B_AGG_ RAW]
      ,[ITE_C_ELIGIBILITY]
      ,[ITE_A_ELIGIBILITY]
      ,[ITE_B_ELIGIBILITY]
      ,[TELEPHONE_MOBILE]
      ,[TELEPHONE_OTHERS]
      ,[EMAIL]
      ,[COMBINED_SITTING]
      ,[OTHER_AGG_TYPE_ RAW]
      ,[FILE_NAME_ACADEMIC_YEAR]
      ,[FILE_NAME_SEMESTER]
    ,Created_On [ETL_Loaded_On]
	  ,Modified_On [ETL_Last_Updated_On]
       FROM [dbo].[DW_EXT_JAE]
GO
/****** Object:  View [dbo].[V_DW_ICARE_SURVEY_BY_SCHOOL]    Script Date: 3/21/2022 11:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[V_DW_ICARE_SURVEY_BY_SCHOOL] as 
SELECT 
	a.[Student_ID]
	,c.[Sch] as [School]
    ,b.[Survey_ID]
	,b.[Survey_Yr] as [Survey_Year]
    ,b.[Qns_ID] as [Question_ID]
    ,b.[Order_ID]
    ,b.[Qns_Category] as [Question_Category]
    ,b.[Qns_Short_Desc] as [Question_Short_Description]
    ,b.[Actual_Qns] as [Actual_Question]
    ,a.[Response]
	,getdate() as ETL_Loaded_On
	,getdate() as ETL_Last_Updated_On
FROM [dbo].[DW_ICARE_SURVEY_RESPONSE] a 
inner join (select * from [dbo].[DW_ICARE_SURVEY_QN_MAPPING] where [Sensitive]='N') b 
on a.[Survey_ID]=b.[Survey_ID] and a.[Qns_ID]=b.[Qns_ID] 
left join (select 
				[Student_ID]
				,[Sch]
			from (
				SELECT 
					[Student_ID]
					,[Sch]
					,row_number() over(partition by Student_ID order by effective_date desc) rn
				FROM [RPDW_PRD].[dbo].[DW_STUDENT_MENTOR]
				) sm
where sm.rn=1) c 
on a.Student_ID=c.Student_ID
GO
/****** Object:  Table [dbo].[DM_TABLEAU_ROW_ACCESS]    Script Date: 3/21/2022 11:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DM_TABLEAU_ROW_ACCESS](
	[Dashboard_Owner] [varchar](100) NULL,
	[Dashboard_ID] [int] NOT NULL,
	[Dashboard_Name] [varchar](200) NOT NULL,
	[School] [varchar](10) NOT NULL,
	[User_Group] [varchar](20) NULL,
	[Username] [varchar](20) NOT NULL,
	[Remarks] [varchar](max) NULL,
	[CREATED_ON] [datetime] NULL,
	[MODIFIED_ON] [datetime] NULL,
 CONSTRAINT [PK_DM_TABLEAU_ROW_ACCESS] PRIMARY KEY CLUSTERED 
(
	[Dashboard_ID] ASC,
	[School] ASC,
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DM_TABLEAU_ROW_ACCESS_PHASE2]    Script Date: 3/21/2022 11:36:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DM_TABLEAU_ROW_ACCESS_PHASE2](
	[Dashboard_Owner] [varchar](100) NULL,
	[Dashboard_ID] [int] NOT NULL,
	[Dashboard_Name] [varchar](200) NOT NULL,
	[School] [varchar](10) NOT NULL,
	[User_Group] [varchar](20) NULL,
	[Username] [varchar](20) NOT NULL,
	[Remarks] [varchar](max) NULL,
	[CREATED_ON] [datetime] NULL,
	[MODIFIED_ON] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DW_EXT_DPA_JAE_ADMISSION_EXE]    Script Date: 3/21/2022 11:36:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DW_EXT_DPA_JAE_ADMISSION_EXE](
	[UIN] [varchar](12) NULL,
	[M)ASKED_NATIONAL_ID] [varchar](12) NULL,
	[ADMISSION_EXERCISE] [varchar](12) NULL,
	[ACAD_YEAR] [varchar](4) NULL,
	[SEMESTER] [varchar](2) NULL,
	[APPLICANT_NAME] [varchar](100) NULL,
	[DATE_OF_BIRTH] [varchar](10) NULL,
	[SEC_SCHOOL_CODE] [varchar](10) NULL,
	[CITIZENSHIP_CODE] [varchar](2) NULL,
	[CITIZENSHIP] [varchar](50) NULL,
	[GENDER_CODE] [varchar](1) NULL,
	[GENDER] [varchar](10) NULL,
	[RACE_CODE] [varchar](2) NULL,
	[RACE] [varchar](50) NULL,
	[SUBJECT_CODE_1] [varchar](4) NULL,
	[SUBJECT_CODE_2] [varchar](4) NULL,
	[SUBJECT_CODE_3] [varchar](4) NULL,
	[SUBJECT_CODE_4] [varchar](4) NULL,
	[SUBJECT_CODE_5] [varchar](4) NULL,
	[SUBJECT_CODE_6] [varchar](4) NULL,
	[SUBJECT_CODE_7] [varchar](4) NULL,
	[SUBJECT_CODE_8] [varchar](4) NULL,
	[SUBJECT_CODE_9] [varchar](4) NULL,
	[SUBJECT_CODE_10] [varchar](4) NULL,
	[SUBJECT_CODE_11] [varchar](4) NULL,
	[SUBJECT_CODE_12] [varchar](4) NULL,
	[GRADE_1] [varchar](1) NULL,
	[GRADE_2] [varchar](1) NULL,
	[GRADE_3] [varchar](1) NULL,
	[GRADE_4] [varchar](1) NULL,
	[GRADE_5] [varchar](1) NULL,
	[GRADE_6] [varchar](1) NULL,
	[GRADE_7] [varchar](1) NULL,
	[GRADE_8] [varchar](1) NULL,
	[GRADE_9] [varchar](1) NULL,
	[GRADE_10] [varchar](1) NULL,
	[GRADE_11] [varchar](1) NULL,
	[GRADE_12] [varchar](1) NULL,
	[COURSE_CODE_CHOICE_1] [varchar](6) NULL,
	[COURSE_CODE_CHOICE_2] [varchar](6) NULL,
	[COURSE_CODE_CHOICE_3] [varchar](6) NULL,
	[COURSE_CODE_CHOICE_4] [varchar](6) NULL,
	[COURSE_CODE_CHOICE_5] [varchar](6) NULL,
	[COURSE_CODE_CHOICE_6] [varchar](6) NULL,
	[COURSE_CODE_CHOICE_7] [varchar](6) NULL,
	[COURSE_CODE_CHOICE_8] [varchar](6) NULL,
	[COURSE_CODE_CHOICE_9] [varchar](6) NULL,
	[COURSE_CODE_CHOICE_10] [varchar](6) NULL,
	[COURSE_CODE_CHOICE_11] [varchar](6) NULL,
	[COURSE_CODE_CHOICE_12] [varchar](6) NULL,
	[POSTED_COURSE] [varchar](6) NULL,
	[POSTED_CENTRE] [varchar](10) NULL,
	[POSTED_CHOICE_ORDER] [varchar](2) NULL,
	[ECA_GRADE] [varchar](1) NULL,
	[RAW_AGG] [varchar](6) NULL,
	[NET_AGG] [varchar](6) NULL,
	[CREATED_ON] [datetime] NULL,
	[MODIFIED_ON] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Email_Config_Detail]    Script Date: 3/21/2022 11:36:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Email_Config_Detail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Report_id] [int] NULL,
	[Report_Name] [nvarchar](50) NOT NULL,
	[First_name] [nvarchar](60) NULL,
	[Last_name] [nvarchar](60) NULL,
	[Email_ID] [nvarchar](50) NULL,
	[Email_tocc_flag] [varchar](3) NULL,
	[IsActive] [bit] NULL,
	[Created_date] [datetime] NULL,
	[Updated_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Email_Config_Summary]    Script Date: 3/21/2022 11:36:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Email_Config_Summary](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Report_Name] [nvarchar](50) NOT NULL,
	[Sendor_Email_ID] [nvarchar](50) NULL,
	[Email_Subject] [nvarchar](500) NULL,
	[Email_Header] [nvarchar](500) NULL,
	[Email_Body] [nvarchar](500) NULL,
	[Email_Trailor] [nvarchar](500) NULL,
	[IsActive] [bit] NULL,
	[Created_date] [datetime] NULL,
	[Modified_date] [datetime] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[Report_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Email_Delivery_list]    Script Date: 3/21/2022 11:36:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Email_Delivery_list](
	[Delivery_list_ID] [int] IDENTITY(1,1) NOT NULL,
	[Report_Name] [nvarchar](200) NULL,
	[First_Name] [nvarchar](200) NULL,
	[Last_Name] [nvarchar](200) NULL,
	[Email_ID] [nvarchar](400) NULL,
	[IsActive] [bit] NULL,
	[CREATE_DATE] [datetime] NULL,
	[MODIFIED_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Delivery_list_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ETL_Email_Table]    Script Date: 3/21/2022 11:36:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_Email_Table](
	[EMAIL_ID] [int] IDENTITY(1,1) NOT NULL,
	[CRITERIA_START_DT] [datetime] NULL,
	[CRITERIA_END_DT] [datetime] NULL,
	[SUBJECT] [varchar](400) NULL,
	[RECIPIENT] [varchar](400) NULL,
	[CC] [varchar](400) NULL,
	[BCC] [varchar](400) NULL,
	[BODY] [varchar](max) NULL,
	[CREATE_DATE] [datetime] NULL,
	[MODIFIED_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[EMAIL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tableau Row Access by School]    Script Date: 3/21/2022 11:36:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tableau Row Access by School](
	[Dashboard_ID] [int] NOT NULL,
	[Dashboard_Name] [varchar](200) NULL,
	[Dashboard_Owner] [varchar](100) NULL,
	[Department] [varchar](10) NOT NULL,
	[Tableau_Usernames] [nvarchar](400) NULL,
 CONSTRAINT [PK_Tableau Row Access by School] PRIMARY KEY CLUSTERED 
(
	[Dashboard_ID] ASC,
	[Department] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Email_Config_Detail] ADD  CONSTRAINT [ECD_CreatedDt]  DEFAULT (getdate()) FOR [Created_date]
GO
ALTER TABLE [dbo].[Email_Config_Summary] ADD  CONSTRAINT [ECS_CreatedDt]  DEFAULT (getdate()) FOR [Created_date]
GO
ALTER TABLE [dbo].[Email_Delivery_list] ADD  DEFAULT (getdate()) FOR [CREATE_DATE]
GO
ALTER TABLE [dbo].[Email_Delivery_list] ADD  DEFAULT (getdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[ETL_Email_Table] ADD  DEFAULT (getdate()) FOR [CREATE_DATE]
GO
ALTER TABLE [dbo].[ETL_Email_Table] ADD  DEFAULT (getdate()) FOR [MODIFIED_DATE]
GO
