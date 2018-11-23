#!/usr/bin/env bash
#
# Jus de Patate <yaume@ntymail.com>
# First release :       2018.11.10-01
               VERSION="2018.11.23-03"
#                       yyyy.mm.dd
#
# info.sh is a little script that works like `neofetch` or `screenfetch`
# it shows infos and was originally made for Termux (Linux on Android)
# but it was tested on Ubuntu, GhostBSD, Termux, iSH and Fedora
#
# License : CC-BY-NC "Jus de Patate, 2018"

if [ "$(which curl 2>/dev/null)" ]; then
# if curl is installed, then
	REQMNGR="curl -s --max-time 10 -LO"
	# use curl as request manager
elif [ "$(which wget 2>/dev/null)" ];then
# if wget is installed, then
	REQMNGR="wget -q --timeout=10"
	# use wget as request manager
else
# if curl and wget aren't installed, then
	echo "Please install curl or wget"
	# error message
	exit 1
	# stop program (with an error)
fi
# end of if

if [ "$1" = "--update" ]; then
# if user wants to update
    $REQMNGR "https://raw.githubusercontent.com/jusdepatate/info.sh/master/info.sh"
    # download new version
    echo -e "Update done,\n$(chmod +x info.sh &>/dev/null && ./info.sh -v) was downloaded"
    # output new version
    exit 0
    # stop program
elif [ "$1" = "-v" ]; then
# if user wants to see version installed
	echo "info.sh $VERSION"
	# output version
	exit 0
	# stop program
fi
# end of argument detection

KERNELNAME="$(uname -s)"
OS="$(uname -o)"
KERNEL="$(uname -r)"
USER="$(whoami)"
HOSTNAME="$(hostname)"
FIRST="\e[1m$USER\e[0m@\e[1m"
BONUS1=""
# set up basic variables

banner() {
    msg="# $* #"
    edge=$(echo "$msg" | sed 's/./#/g')
    echo "$edge"
    echo "$msg"
    echo "$edge"
}
# https://unix.stackexchange.com/a/250094

if [ $(uname -r | grep "ish") ]; then
    echo -e "$USER@$HOSTNAME"
    # user@machine name
    source /etc/os-release
    # get vars from /etc/os-release
    echo "iOS/$PRETTY_NAME ($OS $KERNEL)"
    # says the kernel name (Linux) and version
    echo "Arch: $(uname -m)"
    # says the arch of iSH
    if [ "$SHELL" = "/bin/ash" ]; then
        # if SHELL is ash
        echo "Shell: ash"
        # ...
    else
        # if SHELL isn't ash (as I know, for now it's impossible to use bash nor zsh on iSH)
        echo "Shell: $SHELL"
        # give the path to the shell
    fi
    # end of if
    echo "Public IP(v4): $(curl -s --max-time 10 https://v4.ident.me) ($(curl -s --max-time 10 ifconfig.io/country_code))"
    # says the public ipv4
    if [ "$(curl -s --max-time 10 https://v6.ident.me)" ]; then
        # if i can connect to v6.ident.me with timeout of 10s
        echo "Public IP(v6): $(curl -s --max-time 10 https://v6.ident.me) ($(curl -s --max-time 10 iconfig.io/country_code))"
        # says IPv6 of the user (for now it is impossible)
    else
        # if curl output is negative (error)
        echo "You probably have an IPv6 but iSH doesn't support it :("
        # :(
    fi
    # end of if
    echo "Due to limitation of iSH, this script can't show local ip"
    # :(

    echo
    # add a line
fi
# end of iSH detection

if [ "$OS" = "Android" ];then
    # If user's os is Android (Termux)
    # --- FOR ANDROID (Termux) ---
    ISPNAME="$(getprop gsm.sim.operator.alpha)"
    # set variable ISPNAME to the output of command 'getprop gsm.sim.operator.alpha', it's output is the operator name of the user (getprop is very useful on Termux)
    ISPCOUNTRY="$(getprop gsm.operator.iso-country)"
    # set variable ISPCOUNTRY to the output of command 'getprop gsm.operator.iso-country', it's output is the iso code of the user's operator
    ANDVERSION="$(getprop ro.build.version.release)"
    # set variable ANDVERSION to the output of command 'uname -r', it's output is the version of Android

    FIRST+="$(getprop ro.product.manufacturer)"
    # add to the variable FIRST (first line of output) the output of command 'getprop ro.product.manufacturer', it's output is the user's phone manufacturer (Huawei, Samsung, ...)
    FIRST+=" $(getprop ro.product.model)\e[0m"
    # add to the variable FIRST the output of command 'getprop ro.product.model', it's output is the user's phone model

    SECOND="\e[1m$OS"
    # set variable SECOND (second line of output) to the output of variable OS (Android in every case in this if)
    SECOND+=" $ANDVERSION\e[0m"
    # add to the variable SECOND the variable ANDVERSION
    SECOND+=" (\e[1m$KERNELNAME $KERNEL\e[0m)"
    # add to the variable SECOND the variable KERNELNAME and KERNEL

    BONUS1="Mobile ISP : \e[1m$ISPNAME\e[0m (\e[1m$ISPCOUNTRY\e[0m)"
    # set variable BONUS1 to "Mobile ISP : " and variable ISPNAME and ISPCOUNTRY
else
    # else :troll:
    # --- FOR ANYTHING ELSE (including cygwin) ---
    FIRST+="$HOSTNAME\e[0m"
    # add to variable FIRST the output of command 'hostname' (machine name)

    case "$OSTYPE" in
        # if env variable OSTYPE is equal to
        solaris*) OS="\e[1mSolaris\e[0m" ;;
        # solaris* then set varible OS to "Solaris"
        darwin*)  OS="\e[1mMac OS X\e[0m" ;;
        # darwin* then set varible OS to "Mac OS X"
        linux*)   OS="\e[1mGNU/Linux\e[0m" ;;
        # linux* then set varible OS to "GNU/Linux"
        bsd*)     OS="\e[1mBSD* $(uname -r | grep -o '[0-9]*\.[0-9]')\e[0m" ;;
        # bsd* then set varible OS to "BSD*" and version
        *bsd)  OS="\e[1m*BSD $(uname -r | grep -o '[0-9]*\.[0-9]')\e[0m" ;;
        # FreeBSD then set varible OS to "*BSD" and version
        msys*)    OS="\e[1mWindows\e[0m" ;;
        # msys* then set varible OS to "Windows" (not sure this can happen
        cygwin*)  OS="\e[1mWindows\e[0m" ;;
        # cygwin* then set varible OS to "Windows"
        *)        OS="\e[1m$OSTYPE\e[0m" ;;
        # anything else then set varible OS to env var OSTYPE
    esac
    # https://stackoverflow.com/a/18434831
    # end of case
    if [ "$OS" = "\e[1mGNU/Linux\e[0m" ]; then
        # if variable OS is equal to GNU/Linux (+ formatting
        if [ $(which yum 2>/dev/null) ]; then
            # and if which yum is true (package exist)
            source /etc/os-release
            OS="\e[1m$PRETTY_NAME\e[0m"
            # set variable OS to PRETTY_NAME
        elif [ $(which apt 2>/dev/null) ]; then
            # or if which apt is true (package exist)
            source /etc/os-release
            # take variables from /etc/os-release
            OS="\e[1m$PRETTY_NAME\e[0m"
            # set variable OS to PRETTY_NAME
        elif [ $(which apk 2>/dev/null) ]; then
            # or if which apk is positive (package exists)
            source /etc/os-release
            # get variables from /etc/os-release
            OS="\e[1m$PRETTY_NAME\e[0m"
            # set variable OS to the variable PRETTY_NAME of /etc/os_release
        elif [ $(which pacman 2>/dev/null) ]; then
            # or if which pacman is positive (package exists)
            source /etc/os-release
            # get vars from /etc/os-release
            OS="\e[1m$PRETTY_NAME\e[0m"
            # set variable Os to the variable PRETTY_NAME of /etc/os_release
        elif [ $(which cards 2>/dev/null) ]; then
			# or if which cards is positive (package exists)
			source /etc/lsb-release
			# get vars from /etc/lsb-release
			OS="\e[1m$DISTRIB_ID $DISTRIB_RELEASE ($DISTRIB_CODENAME)\e[0m"
        fi
        # end of if
    fi
    # end of if
    SECOND="\e[1m$OS\e[0m"
    # set variable SECOND (second line of output) to variable OS
    SECOND+=" (\e[4m$KERNELNAME $KERNEL\e[0m)"
    # add to variable SECOND the variable KERNELNAME and KERNEL
fi
# end of if

THIRD="Arch: \e[1m$(uname -m)\e[0m"
# set variable THIRD to architecture (using uname)

FOURTH="Shell:"
# set variable FOURTH to "Shell:"
if [ $(echo $SHELL | grep "zsh") ]; then
    # if env var SHELL contains "zsh"
    SH="$(zsh --version | grep -o 'zsh [0-9]\.[0-9]\.[0-9]')"
    # set SH variable to output of "zsh --version" (modified using grep)
    FOURTH+=" \e[1m$SH\e[0m"
    # add to variable FOURTH variable SH
elif [ $(echo $SHELL | grep "bash") ]; then
    # or if env var contains bash
    SH="$(bash --version | head -1 | cut -d ' ' -f 4)"
    # set SH variable to output of "bash --version" (modified using head and cut)
    # https://askubuntu.com/a/1008422
    FOURTH+=" \e[1mbash $SH\e[0m"
    # add to variable FOURTH "bash" and variable SH
elif [ $(echo $SHELL | grep "csh") ]; then
    # or if env var contains csh
    SH="$(csh --version | grep -o 'csh [0-9]*\.[0-9]*\.[0-9]')"
    FOURTH+=" \e[1m$SH\e[0m"
elif [ $(echo $SHELL | grep "/bin/sh") ]; then
    # or if env var contains /bin/sh
    FOURTH+=" \e[1msh\e[0m"
    # add to variable FOURTH "sh"
else
    # if shell isn't one listed above
    FOURTH+=" $SHELL"
    # add to variable FOURTH the variable SHELL
fi

FIFTH="Public IP(v4): "

if [ "$($REQMNGR https://v4.ident.me)" ]; then
    # set variable FIFTH "Public IP(v4): "
    FIFTH+=" \e[1m$($REQMNGR https://v4.ident.me)\e[0m"
    # connect to v4.ident.me with timeout of 10 seconds and put output into variable FIFTH
	FIFTH+=" (\e[1m$($REQMNGR ifconfig.io/country_code) - $($REQMNGR ipinfo.io/org | awk '{print $1}') - $($REQMNGR ipinfo.io/org | cut -d' ' -f2-)\e[0m)"
    # connect to ifconfig.io/country_code with timeout of 10 seconds and put output into variable FIFTH
else
    FIFTH=" Unable to connect to v4.ident.me (?)"
fi
if [ "$($REQMNGR https://v6.ident.me/)" ]; then
    # if i can connect to v6.ident.me with 10s of timeout (it means that user has an IPv6)
    FIFTH+="\nPublic IP(v6): \e[1m$($REQMNGR https://v6.ident.me/)\e[0m (\e[1m$($REQMNGR ifconfig.io/country_code) - $($REQMNGR ipinfo.io/org | awk '{print $1}') - $($REQMNGR ipinfo.io/org | cut -d' ' -f2-)\e[0m)"
    # add a line to variable FIFTH containing result of v6.ident.me and ifconfig.io with 10s of timeout for both
fi

SIXTH="Local IP: "
# set variable SIXTH to "Local IP: "

if [ "$(hostname -I 2>/dev/null)" ]; then
    SIXTH+="\e[1m$(hostname -I)\e[0m"
elif [ "$(which ifconfig 2>/dev/null)" ]; then
    SIXTH+="\e[1m$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')\e[0m"
else
    SIXTH+="Unable to get local IP"
fi
# --- ECHO ---

banner $(date "+%A %d %B, %Y")
# add a date with the date
echo
# new line

echo -e $FIRST
# -e because it supports \n, bold, ...
# First : user@host (or phone man + phone mod)

echo -e $SECOND
# Second : OS

echo -e $THIRD
# Third : Package Arch

echo -e $FOURTH
# Fourth : Shell + version (only for bash and zsh)

echo -e $FIFTH
# Fifth : Public IP

echo -e $SIXTH
# Sixth : Local IP

echo -e $BONUS1
# Bonus1 : Mobile ISP (Termux-only)

echo
echo "Report any errors here :"
echo "https://github.com/jusdepatate/info.sh"

# vim: ft=sh ts=4 sw=4
