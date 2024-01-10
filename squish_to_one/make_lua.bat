@echo off
set "path=%~dp0/../lua5.1/;%path%"

echo %~dp1
pushd %~dp1
lua %~dp0/squish %1 --minify-level=full --uglify --uglify-level=full
popd
