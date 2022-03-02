echo off

"C:\Program Files (x86)\WinSCP\WinSCP.com" ^
  /ini=nul ^
  /command ^
    "open sftp://svc-idw-uat-etl@vmprdizsftp02/ -hostkey="" -privatekey=""" ^
	"cd /AIE/AIE_PRD/DW/" ^
    "dir" ^
    "lcd ../RPDW_USR/AIE/AIE_PRD/DW/" ^
    "mput -delete -transfer=ascii *.txt" ^
    "cd /AIE/AIE_PRD/DW/" ^
    "dir" ^
    "lcd ../RPDW_USR/AIE/AIE_PRD/DW/Daily/" ^
    "mput -delete -transfer=ascii *.txt" ^
    "cd /AIE/AIE_PRD/DW/" ^
    "dir" ^
    "lcd ../RPDW_USR/AIE/AIE_PRD/DW/Weekly/" ^
    "mput -delete -transfer=ascii *.txt" ^
    "cd /AIE/AIE_PRD/DW/" ^
    "dir" ^
    "lcd ../RPDW_USR/AIE/AIE_PRD/DW/Monthly/" ^
    "mput -delete -transfer=ascii *.txt" ^
    "exit"
	
	
set WINSCP_RESULT=%ERRORLEVEL%
if %WINSCP_RESULT% equ 0 (
  echo Success
) else (
  echo Error
)
exit /b %WINSCP_RESULT%

