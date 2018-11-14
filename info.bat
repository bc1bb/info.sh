@echo off

echo %USERNAME%@%COMPUTERNAME%
:: output the username and the computername

for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
:: get Windows NT version
if "%version%" == "6.0" echo Microsoft Windows Vista (Windows NT 6.0)
:: Windows NT 6.0 = Vista
if "%version%" == "6.1" echo Microsoft Windows 7 (Windows NT 6.1)
:: Windows NT 6.1 = 7
if "%version%" == "6.2" echo Microsoft Windows 8 (Windows NT 6.2)
:: Windows NT 6.2 = 8
if "%version%" == "6.3" echo Microsoft Windows 8.1 (Windows NT 6.3)
:: Windows NT 6.3 = 8.1
if "%version%" == "10.0" echo Microsoft Windows 10 (Windows NT 10.0)
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
echo Public IP(v4): %PublicIP4% (%c_iso%)
:: output it
for /f %%a in ('powershell Invoke-RestMethod v6.ident.me') do set PublicIP6=%%a
:: get user's IPv6 and put it into variable "PublicIP6"
if NOT "%PublicIP6%" == "+" echo Public IP(v6): %PublicIP6% (%c_iso%)
:: get user has an IPv6, output %PublicIP6%

for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a
:: get local ip
echo Local IP: %NetworkIP%
:: output it
:: https://stackoverflow.com/a/17634009

echo.
echo Report any errors here :
echo https://github.com/jusdepatate/info.sh

pause
