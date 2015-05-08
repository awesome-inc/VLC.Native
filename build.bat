@echo off
setlocal
set version=%1
if "%version%" == "" set version=2.2.0
if "%build%"== "" set build=1

:download_dist
echo Downloading VLC %version%.
set dist32=vlc-%version%-win32.zip
set dist64=vlc-%version%-win64.zip
if not exist %dist32% call curl -O http://download.videolan.org/pub/videolan/vlc/%version%/win32/%dist32%
if not exist %dist64% call curl -O http://download.videolan.org/pub/videolan/vlc/%version%/win64/%dist64%

:unzip_dist
echo Unzipping.
if not exist dist\x86\vlc-%version%\vlc.exe 7za x %dist32% -odist\x86 > nul
if not exist dist\x64\vlc-%version%\vlc.exe 7za x %dist64% -odist\x64 > nul

:build_package
nuget pack VLC.Native.nuspec -Properties Version=%version%;Build=%build% -NoPackageAnalysis

endlocal
