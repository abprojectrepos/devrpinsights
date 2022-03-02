echo off

"C:\Program Files (x86)\WinSCP\WinSCP.com" ^
  /ini=nul ^
  /command ^
    "open sftp://{username}@{user sftp server name}/ -hostkey="" -privatekey=""" ^
	"cd /ACE/" ^
    "dir" ^
    "lcd /DW_EXTERNAL_STG/ACE/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /CED/" ^
    "dir" ^
    "lcd /DW_EXTERNAL_STG/CED/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /OAS/" ^
    "dir" ^
    "lcd /DW_EXTERNAL_STG/OAS/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /OFN/" ^
    "dir" ^
    "lcd /DW_EXTERNAL_STG/OFN/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /OHR/" ^
    "dir" ^
    "lcd /DW_EXTERNAL_STG/OHR/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /OIR/" ^
    "dir" ^
    "lcd /DW_EXTERNAL_STG/OIR/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /OPN/" ^
    "dir" ^
    "lcd /DW_EXTERNAL_STG/OPN/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /ORG/" ^
    "dir" ^
    "lcd /DW_EXTERNAL_STG/ORG/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /OSE/" ^
    "dir" ^
    "lcd /DW_EXTERNAL_STG/OSE/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /OSG/" ^
    "dir" ^
    "lcd /DW_EXTERNAL_STG/OSG/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /OSS/" ^
    "dir" ^
    "lcd /DW_EXTERNAL_STG/OSS/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /OTD/" ^
    "dir" ^
    "lcd /DW_EXTERNAL_STG/OTD/" ^
    "mget -delete -transfer=ascii *.*" ^
	"cd /SFO/" ^
    "dir" ^
    "lcd /DW_EXTERNAL_STG/SFO/" ^
    "mget -delete -transfer=ascii *.*" ^
    "exit"


set WINSCP_RESULT=%ERRORLEVEL%
if %WINSCP_RESULT% equ 0 (
  echo Success
) else (
  echo Error
)
exit /b %WINSCP_RESULT%

