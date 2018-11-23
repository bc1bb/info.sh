<div align="right"><img src="https://raw.githubusercontent.com/jusdepatate/info.sh/master/logomadein5minutes.png" /></div><br>

<a href="https://github.com/jusdepatate/info.sh/blob/master/info.sh"><i>info.sh</i></a> is a little script that works like `screenfetch` or `neofetch` it shows infos and was originally made for Termux (Linux on Android).

#### Thanks to
Neofetch (local IP idea is from it), DoomQuakeKeen, Dryusdan, Outout, Oräkle and Leeo97one.

## Install

#### Linux, \*BSD, ...
##### Package you need
- curl (or wget, check info.sh)
- awk (package name is sometimes gawk), cut, head and grep
- bash

##### Install
- Using git

`git clone https://github.com/jusdepatate/info.sh/ && cd info.sh/ && bash info.sh`

Update using `bash info.sh --update`

- Using curl

`curl "https://raw.githubusercontent.com/jusdepatate/info.sh/master/info.sh" -s | bash`

Download file : `curl "https://raw.githubusercontent.com/jusdepatate/info.sh/master/info.sh" -LO`

Update using `bash info.sh --update`

#### Windows
##### Package you need
- Powershell (built-in with Windows 7 and better)

#### Install

- Using git

`git clone https://github.com/jusdepatate/info.sh/ && cd info.sh/ && info.bat`

## Works on
- Ubuntu (tested with official Ubuntu and WSL)
- Termux
- Debian (official and WSL)
- Alpine Linux
- Windows 10 (using https://github.com/jusdepatate/info.sh/blob/master/info.bat)
- Fedora
- \*BSD
- Arch Linux
- NuTyX

## Doesn't works on
### Partially works
...
### Shows nothing
- Windows 10 (using cygwin)
- Windows below 7 (using https://github.com/jusdepatate/info.sh/blob/master/info.bat)

## Features
- Shows IP (public, v4 and v6, and local)
- Shows OS and version
- Shows username and hostname (or phone manufacturer + phone model on Termux)
- Shows Mobile ISP (only on Termux)
- Shows ISP and ASN
- Ultra bad code

### Planned
- [~~Show IPv4 and IPv6 on two different line~~](https://github.com/jusdepatate/info.sh/commit/c2a929935705e8647f2cce32a9d5e4fc54d026a6)
- [~~Explain every line~~](https://github.com/jusdepatate/info.sh/commit/f45db7cf90e5f412541e4a05098dfabed694d5d0) [2](https://github.com/jusdepatate/info.sh/commit/3f146f235e72d52c1a30fa86bc43c73ef3b6a2d6)
- [~~Compatibility with iSH~~](https://github.com/jusdepatate/info.sh/commit/f3bbc05b6e4225d06757b54f31ecff7ef60b2448)
- [~~.bat version~~](https://github.com/jusdepatate/info.sh/commit/429e13447603005a4631155ed11b436d3561e29e)
- [~~Compatibility with \*BSD~~](https://github.com/jusdepatate/info.sh/commit/df4f9159a4f8e85af494e8216d3ae0124b9e7ab1)
- [~~Compatibility with Arch Linux~~](https://github.com/jusdepatate/info.sh/commit/40539e49c42bcd44eefa9ce71ae2fb89e53cfd73)
- [~~Test if curl is here, if not present, use wget.~~](https://github.com/jusdepatate/info.sh/commit/f3c73c9e1414253f8dd1dee4871184b804cfb49a)
- [~~Add success messages after update and don't execute the old code~~](https://github.com/jusdepatate/info.sh/commit/f3c73c9e1414253f8dd1dee4871184b804cfb49a)
- [~~Add a <code>-v</code> argument~~](https://github.com/jusdepatate/info.sh/commit/f3c73c9e1414253f8dd1dee4871184b804cfb49a)
---
- Compatibility with Gentoo
- Compatibility with Mac OS

## Example :
check folder `screenshot`

Pull requests and issues are welcome :)<br>
<img width="80px" src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/By-nc.svg/2560px-By-nc.svg">
