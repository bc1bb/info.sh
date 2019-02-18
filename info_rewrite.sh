#!/usr/bin/env bash
#
# Jus de Patate <yaume@ntymail.com>
# First release   :       2018.11.10-01
# Rewrite release :       2019.01.01-16
                 VERSION="2018.02.18-02"; indev=true
#                         yyyy.mm.dd
#
# info.sh is a little script that works like `neofetch` or `screenfetch`
# it shows infos and was originally made for Termux (Linux on Android).
# The version you are on is the rewrite from 2019.
# Same features, better.
#
# Copyright (c) 2018-2019, Jus de Patate
# under BSD-3-CLAUSE licence
# Arguments :
# -v / --version               : output version of info.sh
# -U / --update                : update info.sh
# -V / --verbose               : verbose (;p)
# -u / --upload                : upload output to transfer.sh (without public IPs)
# -n / --no-internet           : run info.sh without all request to internet
# -p / --partition [partition] : force partition to check space
# --force-os [OS]              : force to use the script adapted for some OSes
# --force-os list              :
# fedora
# debian
# ubuntu
# freebsd
# openbsd
# android-native
# android-termux
# ios-ish
# nutyx
# macos
# windows-cygwin
# unk-linux

if [ "$(which curl 2>/dev/null)" ]; then
        REQMNGR="curl -s --max-time 10"
        DWNMNGR="curl -s --max-time 10 -LO"
        UPMNGR="curl --upload-file"
elif [ "$(which wget 2>/dev/null)" ]; then
        REQMNGR="wget -qO- --timeout=10"
        DWNMNGR="wget -q --timeout=10"
else
        echo "Please install curl or wget"
        exit 1
fi

if [ "$(which tput 2>/dev/null)" ]; then
    BOLD=$(tput bold)
    NORMAL=$(tput sgr0)
    UNDER=$(tput smul)
    GREY=$(tput setab 0 && tput setaf 0)
    RED=$(tput setab 1 && tput setaf 1)
    GREEN=$(tput setab 2 && tput setaf 2)
    YELLOW=$(tput setab 3 && tput setaf 3)
    BLUE=$(tput setab 4 && tput setaf 4)
    MAG=$(tput setab 5 && tput setaf 5)
    CYAN=$(tput setab 6 && tput setaf 6)
    WHITE=$(tput setab 7 && tput setaf 7)
else
    BOLD="\e[1m"
    NORMAL="\e[0m"
    UNDER="\e[4m"
    GREY="\e[30;40m"
    RED="\e[31;41m"
    GREEN="\e[32;42m"
    YELLOW="\e[33;43m"
    BLUE="\e[34;44m"
    MAG="\e[35;45m"
    CYAN="\e[36;46m"
    WHITE="\e[97;107m"
fi

print() {
   echo -e "$*"
}
verbose() {
    if [ "$verbose" ]; then
        print "$*"
    fi
}
banner() {
    msg="# $* #"
    edge=$(echo "$msg" | sed 's/./#/g')
    echo "$edge"
    echo "$msg"
    echo "$edge"
}
# https://unix.stackexchange.com/a/250094

first() {
    banner $(date "+%A %d %B, %Y")
    print
    verbose "[first()] Execute 'whoami' and 'hostname' to get username and machine name"
    verbose "[first()] Read product_name from /sys/devices/virtual/dmi/id/"
    verbose
    
    PNAME="$(cat /sys/devices/virtual/dmi/id/product_name 2>/dev/null)"
    if [ ! -z "$PNAME" ]; then
    	print "${BOLD}$(whoami)${NORMAL}@${BOLD}$(hostname)${NORMAL} (${BOLD}$PNAME${NORMAL})"
    elif [ "$PNAME" = "System Product Name" ]; then
    	print "${BOLD}$(whoami)${NORMAL}@${BOLD}$(hostname)${NORMAL}"
    else
        print "${BOLD}$(whoami)${NORMAL}@${BOLD}$(hostname)${NORMAL}"
    fi
}
getos() {
    verbose
    verbose "[getos()] getting variables from /etc/os-release"
    verbose "[getos()] getting OS and kernel version"
    verbose
    
    if [ "$(cat /etc/os-release 2>/dev/null)" ]; then
         source /etc/os-release
         OS="$PRETTY_NAME"
    else
         OS="$(uname -o)"
    fi
    print "${BOLD}$OS${NORMAL} (${UNDER}$(uname -o) $(uname -r)${NORMAL})"
    
    verbose
    verbose "[getos()] Getting arch from uname"
    verbose
    
    print "Arch: ${BOLD}$(uname -m)${NORMAL}"
}
getpackages() {
    verbose
    verbose "[getpackages()] Testing package manager"
    verbose
    print "Packages: \c"
    if [ "$(which dpkg 2>/dev/null)" ]; then
        print "${BOLD}$(dpkg --get-selections | grep -c 'install')${NORMAL} (dpkg) \c"
    fi
    if [ "$(which apt 2>/dev/null)" ]; then
        print "${BOLD}$(apt list 2>/dev/null | grep -v 'Listing...' | grep 'installed' | wc -l)${NORMAL} (apt) \c"
    fi
    if [ "$(which apk 2>/dev/null)" ]; then
        print "${BOLD}$(apk list 2>/dev/null | grep -c 'installed')${NORMAL} (apk) \c"
    fi
    if [ "$(which pacman 2>/dev/null)" ]; then
        print "${BOLD}$(pacman -Q 2>/dev/null | wc -l)${NORMAL} (pacman) \c"
    fi
    if [ "$(which flatpak 2>/dev/null)" ]; then
        print "${BOLD}$(flatpak list 2>/dev/null | wc -l)${NORMAL} (flatpak) \c"
    fi
    #if [ "$(which getprop 2>/dev/null && $OS = 'Android' 2>/dev/null)" ]; then
    #    print "${BOLD}$(pkg list-all 2>/dev/null | grep -c 'installed')${NORMAL} (pkg) \c"
    #fi
    if [ "$(which pip2 2>/dev/null)" ]; then
	      print "${BOLD}$(pip2 list --format=columns 2>/dev/null | grep -v 'Package ' | grep -v '\-\-\-\-\-\-\-' | wc -l)${NORMAL} (pip2) \c"
    fi
    if [ "$(which pip3 2>/dev/null)" ]; then
	      print "${BOLD}$(pip3 list 2>/dev/null | grep -v 'Package ' | grep -v '\-\-\-\-\-\-\-' | wc -l)${NORMAL} (pip3) \c"
    fi
    if [ "$(which brew 2>/dev/null)" ]; then
        print "${BOLD}$(brew list | wc -l)${NORMAL} (brew) \c"
    fi
    print
}
getshell() {
    verbose
    verbose "[getshell()] looking at \$SHELL env var to get actual shell"
    verbose 
    
    case $SHELL in
       /bin/bash | */bin/bash) shell="Bash $BASH_VERSION";;
       /bin/ksh | /bin/pdksh | */bin/ksh | */bin/pdksh) shell="Korn Shell";;
       /bin/csh | */bin/csh) shell="C Shell";;
       /bin/tcsh | */bin/tcsh) shell "Tenex Shell";;
       /bin/zsh | */bin/zsh) shell="Z Shell $ZSH_VERSION";;
       /bin/fish | */bin/fish) shell="Fish $FISH_VERSION";;
    esac
    print "Shell: ${BOLD}$shell${NORMAL}"
}
getpubip4() {
  if [ ! "$norequest" ]; then
    verbose
    verbose "[getpubip4()] Checking if you use tor"
    if [ "$($REQMNGR https://check.torproject.org/api/ip | grep 'true')" ]; then
        verbose "[getpubip4()] Tor detected"
        verbose
        printf "Tor IPv4: "
    else
        verbose "[getpubip4()] Tor not detected"
        verbose
        printf "Public IPv4: "
    fi
    verbose "\n"
    verbose "[getpubip4()] Connecting to v4.ident.me, ifconfig.io, ipinfo.io to get \$ipv4, \$cc, \$as and \$operator"
    verbose
    ipv4="$($REQMNGR https://v4.ident.me)"
    cc="$($REQMNGR https://ifconfig.io/country_code)"
    as="$($REQMNGR https://ipinfo.io/org | awk '{print $1}')"
    operator="$($REQMNGR https://ipinfo.io/org | cut -d' ' -f2-)"
    print "${BOLD}$ipv4${NORMAL} (${BOLD}$as${NORMAL} - ${BOLD}$operator${NORMAL} - $cc)"
  else
    verbose
    verbose "[getpubip4()] \$norequest is true so skipping this part"
    verbose
  fi
}
getpubip6() {
  if [ ! "$norequest" ]; then
    verbose
    verbose "[getpubip6()] Checking if you have IPv6"
    ipv6="$($REQMNGR https://v6.ident.me)"
    if [ ! -z "$ipv6" ]; then
       verbose "[getpubip6()] I got an IPv6"
       print "Public IPv6 : ${BOLD}$ipv6${NORMAL} (${BOLD}$as${NORMAL} - ${BOLD}$operator${NORMAL} - $cc"
    fi
  else
    verbose
    verbose "[getpubip6()] \$norequest is true, so no skipping this part"
    verbose
  fi
}
getlocip() {
    if [ "$(hostname -I 2>/dev/null)" ]; then
        print "Local IP: ${BOLD}$(hostname -I)${NORMAL}"
    elif [ "$(which ifconfig 2>/dev/null)" ]; then
        print "Local IP: ${BOLD}$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')${NORMAL}"
    else
        verbose "[getlocip()] Unable to get local IP"
    fi
}
colors() {
   print
   print "${GREY}██${NORMAL}${RED}██${NORMAL}${GREEN}██${NORMAL}${YELLOW}██${NORMAL}${BLUE}██${NORMAL}${MAG}██${NORMAL}${CYAN}██${NORMAL}${WHITE}██${NORMAL}"
}
footer() {
   print "\nReport any errors here :"
   print "https://github.com/jusdepatate/info.sh"
}

# Arguments :
while [ ! -z "$1" ]; do
    if [ "$1" = "--version" ] || [ "$1" = "-v" ]; then
        print "info.sh $VERSION"
        shift
        exit 0
    elif [ "$1" = "--update" ] || [ "$1" = "-U" ]; then
        $DWNMNGR "https://raw.githubusercontent.com/jusdepatate/info.sh/master/info_rewrite.sh"
        print "Update done,\n$(chmod +x info_rewrite.sh &>/dev/null && bash info_rewrite.sh -v) was downloaded"
        shift
        exit 0
    elif [ "$1" = "--verbose" ] || [ "$1" = "-V" ]; then
        verbose=true
        verbose "[-v] Verbosity activated"
        
        # Test verbosity :
        # if [ "$verbose" ]; then echo "ok"; fi
        # or use the function verbose()
        # verbose ok
        
        if [ "$verbose" ] && [ "$indev" ]; then print "[-v] Using indev version can give error or spoil new features"; fi
        shift
    elif [ "$1" = "--upload" ] || [ "$1" = "-u" ]; then
        upload=true
        verbose "[-u] Will upload output to transfer.sh"
        shift
    elif [ "$1" = "--no-internet" ] || [ "$1" = "-n" ]; then
        verbose "[-n] No request to internet will be done"
        norequests=true
        if [ "$upload" ]; then
           verbose "[-n & -u] Can't upload without internet GG\n[-n && -u] Set upload to false"
            upload=false
        fi
        shift
    elif [ "$1" = "--partition" ] || [ "$1" = "-p" ]; then
        #verbose "[-p] Setting partition to what you said ($2)"
        #partition=$2
        print "this is actually useless, disk space checking is not developped for now"
        shift 2
    elif [ "$1" = "--force-os" ]; then
        #verbose "[--force-os] Setting OS to what you said ($2)"
        #OS=$2
        print "this is actually useless, special-os list is not developped for now"
        shift 2
    fi
done

verbose
if [ ! "$upload" ]; then
    first
    getos
    getpackages
    getshell
    getpubip4
    getpubip6
    getlocip
    colors
    footer
else
    first > /tmp/info.sh.log
    getos >> /tmp/info.sh.log
    getpackages >> /tmp/info.sh.log
    getshell >> /tmp/info.sh.log
    getlocip >> /tmp/info.sh.log
    colors >> /tmp/info.sh.log
    footer >> /tmp/info.sh.log
    $UPMNGR /tmp/info.sh.log https://transfer.sh
    print
fi
