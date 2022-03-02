echo off

"C:\Program Files (x86)\WinSCP\WinSCP.com" ^
  /ini=nul ^
  /command ^
    "open sftp://svc-idw-uat-etl@vmprdizsftp02/ -hostkey="" -privatekey=""" ^
    "cd /INSIGHTS/DW_OASIS_STG/" ^
    "dir" ^
    "lcd ../rpdw/Source_Files/OASIS/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /INSIGHTS/DW_LEO_STG/" ^
    "dir" ^
    "lcd ../rpdw/Source_Files/LEO/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /INSIGHTS/DW_CRMS_STG/" ^
    "dir" ^
    "lcd ../rpdw/Source_Files/CRMS/" ^
    "mget -delete -transfer=ascii *.*" ^
    "exit"
	
	
"C:\Program Files (x86)\WinSCP\WinSCP.com" ^
  /ini=nul ^
  /command ^
    "open sftp://svc-idw-uat-etl@vmprdizsftp01/ -hostkey="" -privatekey=""" ^
	"cd /DW_EXTERNAL_STG/ACE/" ^
    "dir" ^
    "lcd ../rpdw/Source_Files/EXTERNAL/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_EXTERNAL_STG/CED/" ^
    "dir" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_EXTERNAL_STG/OAS/" ^
    "dir" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_EXTERNAL_STG/OFN/" ^
    "dir" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_EXTERNAL_STG/OHR/" ^
    "dir" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_EXTERNAL_STG/OIR/" ^
    "dir" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_EXTERNAL_STG/OPN/" ^
    "dir" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_EXTERNAL_STG/ORG/" ^
    "dir" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_EXTERNAL_STG/OSE/" ^
    "dir" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_EXTERNAL_STG/OSG/" ^
    "dir" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_EXTERNAL_STG/OSS/" ^
    "dir" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_EXTERNAL_STG/OTD/" ^
    "dir" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /DW_EXTERNAL_STG/SFO/" ^
    "dir" ^
    "mget -delete -transfer=ascii *.*" ^
    "exit"

set WINSCP_RESULT=%ERRORLEVEL%
if %WINSCP_RESULT% equ 0 (
  echo Success
) else (
  echo Error
)
exit /b %WINSCP_RESULT%

