echo off

"C:\Program Files (x86)\WinSCP\WinSCP.com" ^
  /ini=nul ^
  /command ^
    "open sftp://{username}@{system sftp server name}/ -hostkey="" -privatekey=""" ^
    "cd /DW_OASIS_STG/" ^
    "dir" ^
    "lcd /INSIGHTS/DW_OASIS_STG/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_LEO_STG/" ^
    "dir" ^
    "lcd /INSIGHTS/DW_LEO_STG/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_CRMS_STG/" ^
    "dir" ^
    "lcd /INSIGHTS/DW_CRMS_STG/" ^
    "mget -delete -transfer=ascii *.*" ^
    "exit"


set WINSCP_RESULT=%ERRORLEVEL%
if %WINSCP_RESULT% equ 0 (
  echo Success
) else (
  echo Error
)
exit /b %WINSCP_RESULT%

