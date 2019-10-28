<div align="right"><img src="https://raw.githubusercontent.com/jusdepatate/info.sh/master/logomadein5minutes.png" /></div><br>

<a href="https://github.com/jusdepatate/info.sh/blob/master/info.sh"><i>info.sh</i></a> is a little script that works like `screenfetch` or `neofetch` it shows infos and was originally made for Termux (Linux on Android).

#### Thanks to
Neofetch, DoomQuakeKeen, Dryusdan, Outout, Oräkle, Leeo97one, and the whole community from Gnous (French Linux Discord).

## Install

### Package you need
- `curl` (or `wget`),
- `awk` (package name is sometimes `gawk`), `cut`, `head` and `grep`,
- `bash`

### Install
- Using `git`

`git clone https://github.com/jusdepatate/info.sh/ && cd info.sh/ && bash info_rewrite.sh`

Update using `bash info_rewrite.sh --update`

- Using `curl`

`curl "https://raw.githubusercontent.com/jusdepatate/info.sh/master/info_rewrite.sh" -s | bash`

Download file : `curl "https://raw.githubusercontent.com/jusdepatate/info.sh/master/info_rewrite.sh" -LO`

Update using `bash info.sh --update`

And if you are an absolute fan of info.sh you can try this :
```
curl "https://raw.githubusercontent.com/jusdepatate/info.sh/master/info_rewrite.sh" -o info.sh
chmod +x info.sh
sudo mv info.sh /usr/bin/info.sh
```

### If you get a `grep` warning
As I'm too lazy to work, just add `2>/dev/null` at the end of you command (for example `info.sh 2>/dev/null`)

## Works on
- Ubuntu (tested with official Ubuntu and WSL)
- Termux
- Debian (official and WSL)
- Alpine Linux
- Fedora
- \*BSD
- Arch Linux
- NuTyX

## Doesn't works on
### Partially works
...
### Shows nothing
- Windows 10 (using cygwin)

## Features
- Shows IP (public, v4 and v6, and local)
- Shows OS and version
- Shows username and hostname (or phone manufacturer + phone model on Termux)
- Shows Mobile ISP (only on Termux)
- Shows ISP and ASN
- [~~Ultra bad code~~](https://github.com/jusdepatate/info.sh/blob/master/info_rewrite.sh) - Rewrite should have a better code

### Planned
- [~~Compatibility with iSH~~](https://github.com/jusdepatate/info.sh/commit/f3bbc05b6e4225d06757b54f31ecff7ef60b2448)
- [~~Compatibility with macOS~~](https://github.com/jusdepatate/info.sh/commit/609b744cc6ba6b9da350cfb3f979c2f53941368f)
- [~~Compatibility with \*BSD~~](https://github.com/jusdepatate/info.sh/commit/df4f9159a4f8e85af494e8216d3ae0124b9e7ab1)
- [~~Compatibility with Arch Linux~~](https://github.com/jusdepatate/info.sh/commit/40539e49c42bcd44eefa9ce71ae2fb89e53cfd73)
- [~~.bat version~~](https://github.com/jusdepatate/info.sh/commit/429e13447603005a4631155ed11b436d3561e29e)
- [~~Show IPv4 and IPv6 on two different line~~](https://github.com/jusdepatate/info.sh/commit/c2a929935705e8647f2cce32a9d5e4fc54d026a6)
- [~~Explain every line~~](https://github.com/jusdepatate/info.sh/commit/f45db7cf90e5f412541e4a05098dfabed694d5d0) [2](https://github.com/jusdepatate/info.sh/commit/3f146f235e72d52c1a30fa86bc43c73ef3b6a2d6)
- [~~Test if curl is here, if not present, use wget.~~](https://github.com/jusdepatate/info.sh/commit/f3c73c9e1414253f8dd1dee4871184b804cfb49a) [2](https://github.com/jusdepatate/info.sh/commit/0b3bb3e68c767872a8289fb3d4e4f9abae7fd23c)
- [~~Add success messages after update and don't execute the old code~~](https://github.com/jusdepatate/info.sh/commit/f3c73c9e1414253f8dd1dee4871184b804cfb49a)
- [~~Add a `-v` argument~~](https://github.com/jusdepatate/info.sh/commit/f3c73c9e1414253f8dd1dee4871184b804cfb49a)
- [~~Compatibility with Gentoo~~](https://github.com/jusdepatate/info.sh/blob/8457d9f332392a6554426166e13f71de0ea60442/info_rewrite.sh#L133)

## Example :
check folder `screenshot`

Pull requests and issues are welcome :)<br>
<img width="80px" src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/By-nc.svg/2560px-By-nc.svg">
