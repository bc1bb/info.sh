#! /bin/bash
#
# Jus de Patate <yaume@ntymail.com>
# First release :       2018.11.10-01 (private)
# Actual release :      2018.11.11-10 (public)
#                       yyyy.mm.dd
#
# info.sh is a little script that works like `neofetch` or `screenfetch`
# it shows infos and was originally made for Termux (Linux on Android)
# but it was tested on Ubuntu, GhostBSD and Termux.
#
# License : CC-BY-NC "Jus de Patate, 2018"

KERNELNAME="$(uname -s)"
OS="$(uname -o)"
KERNEL="$(uname -r)"
PKGARCH="$(dpkg --print-architecture)"
USER="$(whoami)"

FIRST="$USER@"

if [ "$OS" = "Android" ];then
        # --- FOR ANDROID (Termux) ---
        ISPNAME="$(getprop gsm.sim.operator.alpha)"
        ISPCOUNTRY="$(getprop gsm.operator.iso-country)"
        ANDVERSION="$(getprop ro.build.version.release)"

        FIRST+="$(getprop ro.product.manufacturer)"
        FIRST+=" $(getprop ro.product.model)"

        SECOND="$OS"
        SECOND+=" $ANDVERSION"
        SECOND+=" ($KERNELNAME $KERNEL)"

        BONUS1="Mobile ISP : $ISPNAME ($ISPCOUNTRY)"
else
        # --- FOR ANYTHING ELSE (including cygwin) ---
        FIRST+="$(uname -n)"

        case "$OSTYPE" in
                solaris*) OS="Solaris" ;;
                darwin*)  OS="MAC OS X" ;;
                linux*)   OS="GNU/Linux" ;;
                bsd*)     OS="BSD" ;;
                FreeBSD)  OS="FreeBSD" ;;
                msys*)    OS="Windows" ;;
                cygwin*)  OS="Windows" ;;
                *)        OS="$OSTYPE" ;;
        esac
        if [ "$OS" = "GNU/Linux" ]; then
                if [ `which yum` ]; then
                        OS="Red Hat"
                elif [ `which apt` ]; then
                        source /etc/os-release
                        source /etc/lsb-release
                        OS="$DISTRIB_ID ${DISTRIB_CODENAME^} $DISTRIB_RELEASE"
                elif [ `which apk` ]; then
                        OS="Alpine Linux"
                else
                        Aba="dakor"
                fi
        fi
        SECOND="$OS"
        SECOND+=" ($KERNELNAME $KERNEL)"
fi

THIRD="Package Arch: $PKGARCH"

FOURTH="Shell:"
if [ $(echo $SHELL || grep "zsh") ]; then
        SH="$(zsh --version | grep -o 'zsh [0-9]\.[0-9]\.[0-9]')"
        FOURTH+=" $SH"
elif [ $(echo $SHELL || grep "bash") ]; then
        SH="$(bash --version | head -1 | cut -d ' ' -f 4)"
        # https://askubuntu.com/a/1008422
        FOURTH+=" bash $SH"
elif [ $(echo $SHELL || grep "sh") ]; then
        FOURTH+=" sh"
else
        FOURTH+=" $SHELL"
fi

FIFTH="Public IP: "
FIFTH+=" $(curl -s https://ifconfig.io/ip)"
FIFTH+=" ($(curl -s --max-time 10 ifconfig.io/country_code))"

SIXTH="Local IP:"

# Works for *BSD and Linux... Who use MAC OS X ? :troll:
SIXTH+="$(ip route get 1 | awk -F'src' '{print $2; exit}')"


# --- ECHO ---

echo $FIRST
# First : user@host (or phone man + phone mod)

echo $SECOND
# Second : OS

echo $THIRD
# Third : Package Arch

echo $FOURTH
# Fourth : Shell + version (only for bash and zsh)

echo $FIFTH
# Fifth : Public IP

echo $SIXTH
# Sixth : Local IP

echo $BONUS1
# Bonus1 : Mobile ISP (Termux-only)

echo
echo "Report any errors here :"
echo "https://github.com/jusdepatate/info.sh"
