@echo off

if "%~1" == "" echo "need input folder path" & pause & goto :eof

set "src_path=%~1"

setlocal EnableDelayedExpansion

pushd "%src_path%"
for /f "usebackq tokens=*" %%f in (`dir /s /b *.lua`) do (
	set "file=%%~dpnf"
	set "file=!file:\=/!"
	echo !file!

	RENAME %%~dpnf.lua %%~nf.luac
	lua %~dp0/squish "" -q -c="Output '!file!.lua';Main '!file!.luac';" --minify-level=full
	del %%~dpnf.luac
)
setlocal DisableDelayedExpansion
popd

pause
