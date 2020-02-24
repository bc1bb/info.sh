#!/usr/bin/env bash
#
# Jus de Patate <yaume@ntymail.com>
# First release   :       2018.11.10-01
# Rewrite release :       2019.01.01-16
                 VERSION="2020.02.22-02"; indev=true
#                         yyyy.mm.dd
#
# info.sh is a little script that works like `neofetch` or `screenfetch`
# it shows infos and was originally made for Termux (Linux on Android).
# The version you are on is the rewrite from 2019.
# Same features, better.
#
# Copyright (c) 2018-2020, Jus de Patate
# under BSD-3-CLAUSE licence
# Arguments :
# -v / --version               : output version of info.sh
# -U / --update                : update info.sh
# -V / --verbose               : verbose (;p)
# -u / --upload                : upload output to transfer.sh (without public IPs)
# -n / --no-internet           : run info.sh without all request to internet

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

if [ ! "$(which awk 2>/dev/null)" ]; then
   echo "Please install awk"
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
    
    if [ ! -z "$HOSTNAME" ]; then
        hostname="$HOSTNAME"
    elif [ "$(getprop net.hostname 2>/dev/null)" ]; then
        hostname="$(getprop net.hostname)"
    else
        hostname="$(hostname)"
    fi

    if [ ! -z "$(cat /sys/devices/virtual/dmi/id/product_name 2>/dev/null)" ] && [ ! "$(cat /sys/devices/virtual/dmi/id/product_name 2>/dev/null)" = "System Product Name" ]; then
    	PNAME="$(cat /sys/devices/virtual/dmi/id/product_name 2>/dev/null)"
    elif [ "$(getprop ro.product.manufacturer 2>/dev/null)" ]; then
        PNAME="$(getprop ro.product.manufacturer) $(getprop ro.rr.device)"
    fi

    # iDevices PNAMES (fml for adding them one by one):
    if [ "$(uname -m | grep 'iPhone')" ]; then
        iDevice="$(uname -m)"

        case $iDevice in
            iPhone1,2) PNAME="iPhone 3G";;
            iPhone2,1) PNAME="iPhone 3GS";;
            iPhone3,*) PNAME="iPhone 4";;
            iPhone4,1) PNAME="iPhone 4S";;
            iPhone5,1 | iPhone5,2) PNAME="iPhone 5";;
            iPhone5,3 | iPhone5,4) PNAME="iPhone 5C";;
            iPhone6,1 | iPhone6,2) PNAME="iPhone 5S";;
            iPhone7,1) PNAME="iPhone 6 Plus";;
            iPhone7,2) PNAME="iPhone 6";;
            iPhone8,1) PNAME="iPhone 6s";;
            iPhone8,2) PNAME="iPhone 6s Plus";;
            iPhone8,4) PNAME="iPhone SE";;
            iPhone9,1 | iPhone9,3) PNAME="iPhone 7";;
            iPhone9,2 | iPhone9,4) PNAME="iPhone 7 Plus";;
            iPhone10,1 | iPhone10,4) PNAME="iPhone 8";;
            iPhone10,2 | iPhone10,5) PNAME="iPhone 8 Plus";;
            iPhone10,3 | iPhone10,6) PNAME="iPhone X";;
            iPhone11,2) PNAME="iPhone Xs";;
            iPhone11,4 | iPhone11,6) PNAME="iPhone Xs Max";;
            iPhone11,8) PNAME="iPhone Xr";;
            iPhone12,1) PNAME="iPhone 11";;
            iPhone12,3) PNAME="iPhone 11 Pro";;
            iPhone12,5) PNAME="iPhone 11 Pro Max";;
            *) PNAME="$iDevice";;
        esac
    elif [ "$(uname -m | grep 'iPod')" ]; then
        iDevice="$(uname -m)"

        case $iDevice in
            iPod1,1) PNAME="iPod 1st Gen";;
            iPod2,1) PNAME="iPod 2nd Gen";;
            iPod3,1) PNAME="iPod 3rd Gen";;
            iPod4,1) PNAME="iPod 4th Gen";;
            iPod5,1) PNAME="iPod 5th Gen";;
            iPod7,1) PNAME="iPod 6th Gen";;
            iPod9,1) PNAME="iPod 7th Gen";;
            *) PNAME="$iDevice";;
        esac
    elif [ "$(uname -m | grep 'iPad')" ]; then
        iDevice="$(uname -m)"

        case $iDevice in
            iPad1,1 | iPad1,2) PNAME="iPad";;
            iPad2,1 | iPad2,2 | iPad2,3 | iPad2,4) PNAME="iPad 2nd Gen";;
            iPad3,1 | iPad3,2 | iPad3,3) PNAME="iPad 3rd Gen";;
            iPad2,5 | iPad2,6 | iPad2,7) PNAME="iPad Mini";;
            iPad3,4 | iPad3,5 | iPad3,6) PNAME="iPad 4th Gen";;
            iPad4,1 | iPad4,2 | iPad4,3) PNAME="iPad Air";;
            iPad4,4 | iPad4,5 | iPad4,6) PNAME="iPad Mini Retina";;
            iPad4,7 | iPad4,8 | iPad4,9) PNAME="iPad Mini 3";;
            iPad5,1 | iPad5,2) PNAME="iPad Mini 4";;
            iPad5,3 | iPad5,4) PNAME="iPad Air 2";;
            iPad6,3 | iPad6,4 | iPad6,7 | iPad6,8) PNAME="iPad Pro";;
            iPad6,11 | iPad6,12) PNAME="iPad 5th Gen";;
            iPad7,1 | iPad7,2 | iPad7,3 | iPad7,4) PNAME="iPad Pro 2th Gen";;
            iPad7,5 | iPad7,6) PNAME="iPad 6th Gen";;
            iPad7,11 | iPad7,12) PNAME="iPad 7th Gen";;
            iPad8,*) PNAME="iPad Pro 3rd Gen";;
            iPad11,1 | iPad11,2) PNAME="iPad Mini 5th Gen";;
            iPad11,3 | iPad11,4) PNAME="iPad Air 3rd Gen";;
            *) PNAME="$iDevice";;
        esac
    elif [ "$(uname -m | grep 'Watch')" ]; then
        iDevice="$(uname -m)"

        case $iDevice in
            Watch1,1 | Watch1,2) PNAME="Apple Watch";;
            Watch2,6 | Watch2,7) PNAME="Apple Watch Series 1";;
            Watch2,3 | Watch2,4) PNAME="Apple Watch Series 2";;
            Watch3,*) PNAME="Apple Watch Series 3";;
            Watch4,*) PNAME="Apple Watch Series 4";;
            Watch5,*) PNAME="Apple Watch Series 5";;
            *) PNAME="$iDevice";;
        esac
    elif [ "$(uname -m | grep 'AppleTV')" ]; then
        iDevice="$(uname -m)"

        case $iDevice in
            AppleTV1,1) PNAME="Apple TV 1st Gen";;
            AppleTV2,1) PNAME="Apple TV 2nd Gen";;
            AppleTV3,1 | AppleTV3,2) PNAME="Apple TV 3rd Gen";;
            AppleTV5,3) PNAME="Apple TV 4th Gen";;
            AppleTV6,2) PNAME="Apple TV 4K";;
            *) PNAME="$iDevice";;
        esac
    fi
    if [ ! -z "$PNAME" ]; then
        print "${BOLD}$(whoami)${NORMAL}@${BOLD}$hostname${NORMAL} (${BOLD}$PNAME${NORMAL})"
    else
        print "${BOLD}$(whoami)${NORMAL}@${BOLD}$hostname${NORMAL}"
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
    elif [ "$(sw_vers -productName 2>/dev/null)" ]; then
         verbose
	 verbose "[getos()] sw_vers detected, getting OS name/Version + build version from it"
	 verbose

         OS="$(sw_vers -productName) $(sw_vers -productVersion) ($(sw_vers -buildVersion))"
    elif [ "$(getprop | grep 'android' 2>/dev/null)" ]; then
         # command available on Termux and on native shell
         verbose
         verbose "[getos()] Android's getprop detected"
         verbose

         OS="Android $(getprop ro.build.version.release)"
    else
         verbose
         verbose "[getos()] Couldnt find os, using uname -o"
         verbose
         OS="$(uname -o)"
    fi
    print "${BOLD}$OS${NORMAL} (${UNDER}$(uname -o) $(uname -r)${NORMAL})"

    verbose
    verbose "[getos()] Getting arch from uname"
    verbose

    if [ "$(uname --processor)" ]; then
        ARCH="$(uname --processor)"
        if [ $ARCH == "unknown" ]; then
        	ARCH="$(uname -m)"
        fi
    else
        ARCH="$(uname -m)"
    fi

    print "Arch: ${BOLD}$ARCH${NORMAL}"
}
getpackages() {
    verbose
    verbose "[getpackages()] Testing package manager"
    verbose
    print "Packages: \c"
    if [ "$(which dpkg 2>/dev/null)" ]; then
        print "${BOLD}$(dpkg --get-selections | grep -c 'install')${NORMAL} (dpkg) \c"
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
       /bin/sh | */bin/sh) shell="sh";;
       *) shell="$SHELL";;
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
       verbose
       print "Public IPv6 : ${BOLD}$ipv6${NORMAL} (${BOLD}$as${NORMAL} - ${BOLD}$operator${NORMAL} - $cc)"
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
