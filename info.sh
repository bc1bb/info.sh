#!/usr/bin/env bash
#
# Jus de Patate <yaume@ntymail.com>
# First release :       2018.11.10-01 (private)
# Actual release :      2018.11.17-01 (public)
#                       yyyy.mm.dd
#
# info.sh is a little script that works like `neofetch` or `screenfetch`
# it shows infos and was originally made for Termux (Linux on Android)
# but it was tested on Ubuntu, GhostBSD, Termux, iSH and Fedora
#
# License : CC-BY-NC "Jus de Patate, 2018"

KERNELNAME="$(uname -s)"
OS="$(uname -o)"
KERNEL="$(uname -r)"
USER="$(whoami)"
HOSTNAME="$(hostname)"
FIRST="$USER@"
BONUS1=""

if [ $(uname -r | grep "ish") ]; then
    echo "$USER@$HOSTNAME"
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
    FIRST+=" $(getprop ro.product.model)"
    # add to the variable FIRST (''                  ) the output of command 'getprop ro.product.model', it's output is the user's phone model

    SECOND="$OS"
    # set variable SECOND (second line of output) to the output of variable OS (Android in every case in this if)
    SECOND+=" $ANDVERSION"
    # add to the variable SECOND the variable ANDVERSION
    SECOND+=" ($KERNELNAME $KERNEL)"
    # add to the variable SECOND the variable KERNELNAME and KERNEL

    BONUS1="Mobile ISP : $ISPNAME ($ISPCOUNTRY)"
    # set variable BONUS1 to "Mobile ISP : " and variable ISPNAME and ISPCOUNTRY
else
    # else :troll:
    # --- FOR ANYTHING ELSE (including cygwin) ---
    FIRST+="$HOSTNAME"
    # add to variable FIRST the output of command 'hostname' (machine name)

    case "$OSTYPE" in
        # if env variable OSTYPE is equal to
        solaris*) OS="Solaris" ;;
        # solaris* then set varible OS to "Solaris"
        darwin*)  OS="Mac OS X" ;;
        # darwin* then set varible OS to "Mac OS X"
        linux*)   OS="GNU/Linux" ;;
        # linux* then set varible OS to "GNU/Linux" (yes, thats how we should call it)
        bsd*)     OS="BSD* $(uname -r | grep -o '[0-9]*\.[0-9]')" ;;
        # bsd* then set varible OS to "BSD"
        *BSD)  OS="*BSD $(uname -r | grep -o '[0-9]*\.[0-9]')" ;;
        # FreeBSD then set varible OS to "FreeBSD"
        msys*)    OS="Windows" ;;
        # msys* then set varible OS to "Windows" (not sure this can happen
        cygwin*)  OS="Windows" ;;
        # cygwin* then set varible OS to "Windows"
        *)        OS="$OSTYPE" ;;
        # anything else then set varible OS to env var OSTYPE
    esac
    # end of case
    if [ "$OS" = "GNU/Linux" ]; then
        # if variable OS is equal to GNU/Linux
        if [ $(which yum 2>/dev/null) ]; then
            # and if which yum is true (package exist)
            source /etc/os-release
            OS="$PRETTY_NAME"
            # set variable OS to Red Hat
        elif [ $(which apt 2>/dev/null) ]; then
            # or if which apt is true (package exist)
            source /etc/os-release
            # take variables from /etc/os-release
            OS="$PRETTY_NAME"
            # set variable OS to PRETTY_NAME
        elif [ $(which apk 2>/dev/null) ]; then
            # or if which apk is positive (package exists)
            source /etc/os-release
            # get variables from /etc/os-release
            OS="$PRETTY_NAME"
            # set variable OS to the variable PRETTY_NAME of /etc/os_release
        else
            # NO ! I WON´T DO THIS JOKE TWO TIMES IN ONE FILE
            Aba="dakor"
            # random bullshit
        fi
        # end of if
    fi
    # end of if
    SECOND="$OS"
    # set variable SECOND (second line of output) to variable OS
    SECOND+=" ($KERNELNAME $KERNEL)"
    # add to variable SECOND the variable KERNELNAME and KERNEL
fi
# end of if

THIRD="Arch: $(uname -m)"
# set variable THIRD to variable PKGARCH

FOURTH="Shell:"
# set variable FOURTH to "Shell:"
if [ $(echo $SHELL | grep "zsh") ]; then
    # if env var SHELL contains "zsh"
    SH="$(zsh --version | grep -o 'zsh [0-9]\.[0-9]\.[0-9]')"
    # set SH variable to output of "zsh --version" (modified using grep)
    FOURTH+=" $SH"
    # add to variable FOURTH variable SH
elif [ $(echo $SHELL | grep "bash") ]; then
    # or if env var contains bash
    SH="$(bash --version | head -1 | cut -d ' ' -f 4)"
    # set SH variable to output of "bash --version" (modified using head and cut)
    # https://askubuntu.com/a/1008422
    FOURTH+=" bash $SH"
    # add to variable FOURTH "bash" and variable SH
elif [ $(echo $SHELL | grep "csh") ]; then
    # or if env var contains csh
    SH="$(csh --version | grep -o 'csh [0-9]*\.[0-9]*\.[0-9]')"
    FOURTH+=" $SH"
elif [ $(echo $SHELL | grep "/bin/sh") ]; then
    # or if env var contains /bin/sh
    FOURTH+=" sh"
    # add to variable FOURTH "sh"
else
    # No.
    FOURTH+=" $SHELL"
    # add to variable FOURTH the variable SHELL
fi

FIFTH="Public IP(v4): "
# set variable FIFTH "Public IP(v4): "
FIFTH+=" $(curl -s --max-time 10 https://v4.ident.me)"
# connect to v4.ident.me with timeout of 10 seconds and put output into variable FIFTH
FIFTH+=" ($(curl -s --max-time 10 ifconfig.io/country_code))"
# connect to ifconfig.io/country_code with timeout of 10 seconds and put output into variable FIFTH

if [ "$(curl -s --max-time 10 https://v6.ident.me/)" ]; then
    # if i can connect to v6.ident.me with 10s of timeout
    FIFTH+="\nPublic IP(v6): $(curl -s --max-time 10 https://v6.ident.me/) ($(curl -s --max-time 10 ifconfig.io/country_code))"
    # add a line to variable FIFTH containing result of v6.ident.me and ifconfig.io with 10s of timeout for both
fi

SIXTH="Local IP: "
# set variable SIXTH to "Local IP: "

if [ "$(hostname -I 2>/dev/null)" ]; then
        SIXTH+="$(hostname -I)"
elif [ "$(which ifconfig 2>/dev/null)" ]; then
        SIXTH+="$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')"
else
        SIXTH+="Unable to get local IP"
fi
# --- ECHO ---

echo $FIRST
# do I really need to explain 'echo' ?
# First : user@host (or phone man + phone mod)

echo $SECOND
# Second : OS

echo $THIRD
# Third : Package Arch

echo $FOURTH
# Fourth : Shell + version (only for bash and zsh)

echo -e $FIFTH
# -e because it supports \n (new line)
# Fifth : Public IP

echo $SIXTH
# Sixth : Local IP

echo $BONUS1
# Bonus1 : Mobile ISP (Termux-only)

echo
echo "Report any errors here :"
echo "https://github.com/jusdepatate/info.sh"
