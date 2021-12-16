# `info.sh`
([info.sh](info.sh) is the 2018 script, [info_rewrite.sh](info_rewrite.sh) is the rewrote and updated script.)<br>
A little script that works like `screenfetch` or `neofetch` it shows infos about your device.

#### Thanks to
Neofetch, DoomQuakeKeen, Dryusdan, Outout, Oräkle, Leeo97one, and the whole community from Gnous (French Linux Discord).

## Install

### Package you need
- `curl` (or `wget`),
- `awk` (package name is sometimes `gawk`), `cut`, `head` and `grep`,
- `bash` (most shells should be supported).

### Fast execution
`curl https://raw.githubusercontent.com/jusdepatate/info.sh/master/info_rewrite.sh | bash`

### Download
```shell
wget https://raw.githubusercontent.com/jusdepatate/info.sh/master/info_rewrite.sh
chmod +x info_rewrite.sh
./info_rewrite.sh
```

### If you get a `grep` warning
As I'm too lazy to work, just add `2>/dev/null` at the end of you command (for example `info.sh 2>/dev/null`)

## Works on
- Ubuntu
- Termux
- Native Android shell
- Debian
- Alpine Linux
- Fedora
- BSD
- Arch Linux
- NuTyX
- iSH
- Native iOS shell

## Doesn't work on
### Partially works
[??](https://github.com/jusdepatate/info.sh/issues)

## Features
- Shows IP (public/tor, v4 and v6, and local)
- Shows OS and version
- Shows username and hostname (or phone manufacturer + phone model on Termux/iOS)
- Shows Mobile ISP (only on Termux)
- Shows ISP and ASN

## Example :
check folder [`screenshot`](screenshot/)

Pull requests and issues are welcome :)
