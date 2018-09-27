@echo off

pushd %~dp0
lua squish %1 --minify-level=full --uglify --uglify-level=full
popd
pause
