@echo off

set MANIFEST_DIR=counterstrike-2-manifests
set CS2_PATH="CS2"

:: Clone manifests repo
if not exist %MANIFEST_DIR% (
	git clone https://gitlab.com/GoodVlad/counterstrike-2-manifests.git %MANIFEST_DIR%
)

:: Pull latest manifests
CD /d %MANIFEST_DIR%
git pull
CD /d ..

:: Find manifest files
for /r %%x in (%MANIFEST_DIR%/*) do (
	Echo.%%x | findstr /C:"2347770">nul && (
		set MANIFEST_2347770="%%~nx"
		echo "Found manifest for 2347770"
	)
	Echo.%%x | findstr /C:"2347771">nul && (
		set MANIFEST_2347771="%%~nx"
		echo "Found manifest for 2347771"
	)
	Echo.%%x | findstr /C:"2347774">nul && (
		set MANIFEST_2347774="%%~nx"
		echo "Found manifest for 2347774"
	)
)

:: Start download
.\DepotDownloader.exe -app 730 -depot 2347770 -validate -decryptionkey b23a737920b6a72f932a5bcdbdf51770d7d4d394a13f95b1cf29db28c1043d88 -manifestpath %MANIFEST_DIR%/%MANIFEST_2347770% -dir "%CS2_PATH%"
.\DepotDownloader.exe -app 730 -depot 2347771 -validate -decryptionkey b80e2b4bd2a244ba996a013850b5d2f46c897f382164181b382c5d672fcb5090 -manifestpath %MANIFEST_DIR%/%MANIFEST_2347771% -dir "%CS2_PATH%"
.\DepotDownloader.exe -app 730 -depot 2347774 -validate -decryptionkey 71e79678830ea0234437b03526e2ede2decfed847ce20bae413718b47db44bea -manifestpath %MANIFEST_DIR%/%MANIFEST_2347774% -dir "%CS2_PATH%"
