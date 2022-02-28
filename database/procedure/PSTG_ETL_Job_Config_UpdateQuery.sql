  --pstg etl config
  UPDATE [dbo].[ETL_JOB_CONFIG_PSTG]
  SET [Source_Folder] = '\\Dev-rpsvr01\rpdw\Source_Files\External\',
  [ARCHIVE_FOLDER] = replace([ARCHIVE_FOLDER],'E:\RPDW\Archive\External\','\\Dev-rpsvr01\rpdw\Archive\External\')
  where Source_System = 'CRMS' and Frequency ='30'