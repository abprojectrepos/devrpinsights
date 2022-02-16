echo off

"C:\Program Files (x86)\WinSCP\WinSCP.com" ^
  /ini=nul ^
  /command ^
    "open sftp:/// -hostkey=""="" -privatekey=""" ^
    "cd /DW/" ^
    "dir" ^
    "lcd ../DW/" ^
    "mget -delete -transfer=ascii *.csv" ^
    "mget -delete -transfer=ascii *.txt" ^
    "cd ../ORG" ^
    "dir" ^
    "lcd ../AIE_PRD/" ^
    "mget -delete -transfer=ascii *.csv" ^
    "mget -delete -transfer=ascii *.txt" ^
    "cd ../OSS" ^
    "dir" ^
    "lcd ../AIE_PRD/" ^
    "mget -delete -transfer=ascii *.csv" ^
    "mget -delete -transfer=ascii *.txt" ^
    "exit"

set WINSCP_RESULT=%ERRORLEVEL%
if %WINSCP_RESULT% equ 0 (
  echo Success
) else (
  echo Error
)
exit /b %WINSCP_RESULT%




