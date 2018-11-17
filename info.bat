@echo off

if NOT "%COMPUTERNAME%" == "%USERDOMAIN%" echo %USERDOMAIN%/%USERNAME%@%COMPUTERNAME%
if "%COMPUTERNAME%" == "%USERDOMAIN%" echo %USERNAME%@%COMPUTERNAME%
:: output the username and the computername (and userdomain / workgroup if there is one)

for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
:: get Windows NT version
if "%version%" == "6.0" echo Microsoft Windows Vista (%OS% %version%)
:: Windows NT 6.0 = Vista
if "%version%" == "6.1" echo Microsoft Windows 7 (%OS% %version%)
:: Windows NT 6.1 = 7
if "%version%" == "6.2" echo Microsoft Windows 8 (%OS% %version%)
:: Windows NT 6.2 = 8
if "%version%" == "6.3" echo Microsoft Windows 8.1 (%OS% %version%)
:: Windows NT 6.3 = 8.1
if "%version%" == "10.0" echo Microsoft Windows 10 (%OS% %version%)
:: Windows NT 10.0 = 10
:: https://www.makeuseof.com/tag/windows-batch-if-statements/

echo Arch: %PROCESSOR_ARCHITECTURE%
:: output user's proc architecture (amd64, ...)

echo CMD: cmd.exe
:: iirc you can't have anything else

for /f %%a in ('powershell Invoke-RestMethod ifconfig.io/country_code') do set c_iso=%%a
:: get user's country iso code and put it into variable "c_iso"
for /f %%a in ('powershell Invoke-RestMethod v4.ident.me') do set PublicIP4=%%a
:: get user's IPv4 and put it into variable "PublicIP4"
if NOT "%PublicIP4%" == "+" echo Public IP(v4): %PublicIP4% (%c_iso%)
if "%PublicIP4%" == "+" echo Public IP(v4): Unable to connect to v4.ident.me (?)
:: output it
for /f %%a in ('powershell Invoke-RestMethod v6.ident.me') do set PublicIP6=%%a
:: get user's IPv6 and put it into variable "PublicIP6"
if NOT "%PublicIP6%" == "+" echo Public IP(v6): %PublicIP6% (%c_iso%)
:: get user has an IPv6, output %PublicIP6%


:: get local ip
echo Local IP: %NetworkIP%
:: output it
:: https://stackoverflow.com/a/17634009

echo.
echo Report any errors here :
echo https://github.com/jusdepatate/info.sh

pause
