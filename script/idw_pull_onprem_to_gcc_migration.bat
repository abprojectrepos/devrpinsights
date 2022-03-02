echo off

"C:\Program Files (x86)\WinSCP\WinSCP.com" ^
  /ini=nul ^
  /command ^
    "open sftp://{username}@{vendorshare sftp server name}/ -hostkey="" -privatekey=""" ^
    "cd /INSIGHT_Migration/" ^
    "dir" ^
    "lcd /INSIGHTS/DW_DB/" ^
    "mget -delete -transfer=ascii *.*" ^
    "exit"


set WINSCP_RESULT=%ERRORLEVEL%
if %WINSCP_RESULT% equ 0 (
  echo Success
) else (
  echo Error
)
exit /b %WINSCP_RESULT%

