#!/usr/bin/env bash
# cloudoptimizer-install.sh
# Copyright 2012 CloudOpt, Inc.
#
# This script detects the running distribution and installs cloudoptimizer for
# the user.


#############
# Constants #
#############

# Update the following for each new version

INSTALLER_VERSION="1.20"

CLOUDOPT_REPO_APT="http://apt.cloudopt.com"
CLOUDOPT_REPO_YUM="http://yum.cloudopt.com"

CLOUDOPT_REPO_PATH_RPM5_64="CentOS/x86_64"
CLOUDOPT_REPO_PATH_RPM5_32="CentOS/i386"
CLOUDOPT_REPO_PATH_RPM6_64="CentOS-6/x86_64"
CLOUDOPT_REPO_PATH_DEB10_64="ubuntu/pool/main/c/cloudoptimizer"
CLOUDOPT_REPO_PATH_DEB12_64="ubuntu/pool/main/c/cloudoptimizer"

CLOUDOPTIMIZER_PREVIOUS_VERSION="1.2.1"
CLOUDOPTIMIZER_CURRENT_VERSION="1.3.0"
CLOUDOPTIMIZER_TESTING_VERSION="1.3.0"

CLOUDOPTIMIZER_CURRENT_RPM5_64_BUILD="222"
CLOUDOPTIMIZER_CURRENT_RPM6_64_BUILD="118"
CLOUDOPTIMIZER_CURRENT_RPM5_32_BUILD=""
CLOUDOPTIMIZER_CURRENT_RPM6_32_BUILD=""
CLOUDOPTIMIZER_CURRENT_DEB10_64_BUILD="229"
CLOUDOPTIMIZER_CURRENT_DEB12_64_BUILD="130"
CLOUDOPTIMIZER_CURRENT_DEB10_32_BUILD="26"
CLOUDOPTIMIZER_CURRENT_DEB12_32_BUILD="26"

CLOUDOPTIMIZER_PREVIOUS_RPM5_64_BUILD="120"
CLOUDOPTIMIZER_PREVIOUS_RPM6_64_BUILD="119"
CLOUDOPTIMIZER_PREVIOUS_RPM5_32_BUILD=""
CLOUDOPTIMIZER_PREVIOUS_RPM6_32_BUILD=""
CLOUDOPTIMIZER_PREVIOUS_DEB10_64_BUILD="124"
CLOUDOPTIMIZER_PREVIOUS_DEB12_64_BUILD="121"
CLOUDOPTIMIZER_PREVIOUS_DEB10_32_BUILD="26"
CLOUDOPTIMIZER_PREVIOUS_DEB12_32_BUILD="26"

# The following don't need to be changed

CLOUDOPTIMIZER_CURRENT_RPM5_64_LABEL="${CLOUDOPTIMIZER_CURRENT_VERSION}-${CLOUDOPTIMIZER_CURRENT_RPM5_64_BUILD}"
CLOUDOPTIMIZER_CURRENT_RPM6_64_LABEL="${CLOUDOPTIMIZER_CURRENT_VERSION}-${CLOUDOPTIMIZER_CURRENT_RPM6_64_BUILD}"
CLOUDOPTIMIZER_CURRENT_RPM5_32_LABEL="${CLOUDOPTIMIZER_CURRENT_VERSION}-${CLOUDOPTIMIZER_CURRENT_RPM5_64_BUILD}"
CLOUDOPTIMIZER_CURRENT_RPM6_32_LABEL="${CLOUDOPTIMIZER_CURRENT_VERSION}-${CLOUDOPTIMIZER_CURRENT_RPM6_64_BUILD}"
CLOUDOPTIMIZER_CURRENT_DEB10_64_LABEL="${CLOUDOPTIMIZER_CURRENT_VERSION}-${CLOUDOPTIMIZER_CURRENT_DEB10_64_BUILD}"
CLOUDOPTIMIZER_CURRENT_DEB12_64_LABEL="${CLOUDOPTIMIZER_CURRENT_VERSION}-${CLOUDOPTIMIZER_CURRENT_DEB12_64_BUILD}"
CLOUDOPTIMIZER_CURRENT_DEB10_32_LABEL="${CLOUDOPTIMIZER_CURRENT_VERSION}-${CLOUDOPTIMIZER_CURRENT_DEB10_64_BUILD}"
CLOUDOPTIMIZER_CURRENT_DEB12_32_LABEL="${CLOUDOPTIMIZER_CURRENT_VERSION}-${CLOUDOPTIMIZER_CURRENT_DEB12_64_BUILD}"

CLOUDOPTIMIZER_PREVIOUS_RPM5_64_LABEL="${CLOUDOPTIMIZER_PREVIOUS_VERSION}-${CLOUDOPTIMIZER_PREVIOUS_RPM5_64_BUILD}"
CLOUDOPTIMIZER_PREVIOUS_RPM6_64_LABEL="${CLOUDOPTIMIZER_PREVIOUS_VERSION}-${CLOUDOPTIMIZER_PREVIOUS_RPM6_64_BUILD}"
CLOUDOPTIMIZER_PREVIOUS_RPM5_32_LABEL="${CLOUDOPTIMIZER_PREVIOUS_VERSION}-${CLOUDOPTIMIZER_PREVIOUS_RPM5_64_BUILD}"
CLOUDOPTIMIZER_PREVIOUS_RPM6_32_LABEL="${CLOUDOPTIMIZER_PREVIOUS_VERSION}-${CLOUDOPTIMIZER_PREVIOUS_RPM6_64_BUILD}"
CLOUDOPTIMIZER_PREVIOUS_DEB10_64_LABEL="${CLOUDOPTIMIZER_PREVIOUS_VERSION}-${CLOUDOPTIMIZER_PREVIOUS_DEB10_64_BUILD}"
CLOUDOPTIMIZER_PREVIOUS_DEB12_64_LABEL="${CLOUDOPTIMIZER_PREVIOUS_VERSION}-${CLOUDOPTIMIZER_PREVIOUS_DEB12_64_BUILD}"
CLOUDOPTIMIZER_PREVIOUS_DEB10_32_LABEL="${CLOUDOPTIMIZER_PREVIOUS_VERSION}-${CLOUDOPTIMIZER_PREVIOUS_DEB10_64_BUILD}"
CLOUDOPTIMIZER_PREVIOUS_DEB12_32_LABEL="${CLOUDOPTIMIZER_PREVIOUS_VERSION}-${CLOUDOPTIMIZER_PREVIOUS_DEB12_64_BUILD}"

# CloudOptimizer Main Packages

CLOUDOPTIMIZER_CURRENT_RPM5_64_FILE="cloudoptimizer-${CLOUDOPTIMIZER_CURRENT_RPM5_64_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_CURRENT_RPM6_64_FILE="cloudoptimizer-${CLOUDOPTIMIZER_CURRENT_RPM6_64_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_CURRENT_RPM5_32_FILE="cloudoptimizer-${CLOUDOPTIMIZER_CURRENT_RPM5_32_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_CURRENT_RPM6_32_FILE="cloudoptimizer-${CLOUDOPTIMIZER_CURRENT_RPM6_32_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_CURRENT_DEB10_64_FILE="cloudoptimizer_${CLOUDOPTIMIZER_CURRENT_DEB10_64_LABEL}_amd64.deb"
CLOUDOPTIMIZER_CURRENT_DEB12_64_FILE="cloudoptimizer_${CLOUDOPTIMIZER_CURRENT_DEB12_64_LABEL}_amd64.deb"
CLOUDOPTIMIZER_CURRENT_DEB10_32_FILE="cloudoptimizer_${CLOUDOPTIMIZER_CURRENT_DEB10_32_LABEL}_amd64.deb"
CLOUDOPTIMIZER_CURRENT_DEB12_32_FILE="cloudoptimizer_${CLOUDOPTIMIZER_CURRENT_DEB12_32_LABEL}_amd64.deb"

CLOUDOPTIMIZER_PREVIOUS_RPM5_64_FILE="cloudoptimizer-${CLOUDOPTIMIZER_PREVIOUS_RPM5_64_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_PREVIOUS_RPM6_64_FILE="cloudoptimizer-${CLOUDOPTIMIZER_PREVIOUS_RPM6_64_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_PREVIOUS_RPM5_32_FILE="cloudoptimizer-${CLOUDOPTIMIZER_PREVIOUS_RPM5_32_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_PREVIOUS_RPM6_32_FILE="cloudoptimizer-${CLOUDOPTIMIZER_PREVIOUS_RPM6_32_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_PREVIOUS_DEB10_64_FILE="cloudoptimizer_${CLOUDOPTIMIZER_PREVIOUS_DEB10_64_LABEL}_amd64.deb"
CLOUDOPTIMIZER_PREVIOUS_DEB12_64_FILE="cloudoptimizer_${CLOUDOPTIMIZER_PREVIOUS_DEB12_64_LABEL}_amd64.deb"
CLOUDOPTIMIZER_PREVIOUS_DEB10_32_FILE="cloudoptimizer_${CLOUDOPTIMIZER_PREVIOUS_DEB10_32_LABEL}_amd64.deb"
CLOUDOPTIMIZER_PREVIOUS_DEB12_32_FILE="cloudoptimizer_${CLOUDOPTIMIZER_PREVIOUS_DEB12_32_LABEL}_amd64.deb"

# CloudOptimizer S3 Packages

CLOUDOPTIMIZER_S3_CURRENT_RPM5_64_FILE="cloudoptimizer-s3-${CLOUDOPTIMIZER_CURRENT_RPM5_64_LABEL}.noarch.rpm"
CLOUDOPTIMIZER_S3_CURRENT_RPM6_64_FILE="cloudoptimizer-s3-${CLOUDOPTIMIZER_CURRENT_RPM6_64_LABEL}.noarch.rpm"
CLOUDOPTIMIZER_S3_CURRENT_RPM5_32_FILE="cloudoptimizer-s3-${CLOUDOPTIMIZER_CURRENT_RPM5_32_LABEL}.noarch.rpm"
CLOUDOPTIMIZER_S3_CURRENT_RPM6_32_FILE="cloudoptimizer-s3-${CLOUDOPTIMIZER_CURRENT_RPM6_32_LABEL}.noarch.rpm"
CLOUDOPTIMIZER_S3_CURRENT_DEB10_64_FILE="cloudoptimizer-s3_${CLOUDOPTIMIZER_CURRENT_DEB10_64_LABEL}_all.deb"
CLOUDOPTIMIZER_S3_CURRENT_DEB12_64_FILE="cloudoptimizer-s3_${CLOUDOPTIMIZER_CURRENT_DEB12_64_LABEL}_all.deb"
CLOUDOPTIMIZER_S3_CURRENT_DEB10_32_FILE="cloudoptimizer-s3_${CLOUDOPTIMIZER_CURRENT_DEB10_32_LABEL}_all.deb"
CLOUDOPTIMIZER_S3_CURRENT_DEB12_32_FILE="cloudoptimizer-s3_${CLOUDOPTIMIZER_CURRENT_DEB12_32_LABEL}_all.deb"

CLOUDOPTIMIZER_S3_PREVIOUS_RPM5_64_FILE="cloudoptimizer-s3-${CLOUDOPTIMIZER_PREVIOUS_RPM5_64_LABEL}.noarch.rpm"
CLOUDOPTIMIZER_S3_PREVIOUS_RPM6_64_FILE="cloudoptimizer-s3-${CLOUDOPTIMIZER_PREVIOUS_RPM6_64_LABEL}.noarch.rpm"
CLOUDOPTIMIZER_S3_PREVIOUS_RPM5_32_FILE="cloudoptimizer-s3-${CLOUDOPTIMIZER_PREVIOUS_RPM5_32_LABEL}.noarch.rpm"
CLOUDOPTIMIZER_S3_PREVIOUS_RPM6_32_FILE="cloudoptimizer-s3-${CLOUDOPTIMIZER_PREVIOUS_RPM6_32_LABEL}.noarch.rpm"
CLOUDOPTIMIZER_S3_PREVIOUS_DEB10_64_FILE="cloudoptimizer-s3_${CLOUDOPTIMIZER_PREVIOUS_DEB10_64_LABEL}_all.deb"
CLOUDOPTIMIZER_S3_PREVIOUS_DEB12_64_FILE="cloudoptimizer-s3_${CLOUDOPTIMIZER_PREVIOUS_DEB12_64_LABEL}_all.deb"
CLOUDOPTIMIZER_S3_PREVIOUS_DEB10_32_FILE="cloudoptimizer-s3_${CLOUDOPTIMIZER_PREVIOUS_DEB10_32_LABEL}_all.deb"
CLOUDOPTIMIZER_S3_PREVIOUS_DEB12_32_FILE="cloudoptimizer-s3_${CLOUDOPTIMIZER_PREVIOUS_DEB12_32_LABEL}_all.deb"

# CloudOptimizer Tools Packages

CLOUDOPTIMIZER_TOOLS_CURRENT_RPM5_64_FILE="cloudoptimizer-tools-${CLOUDOPTIMIZER_CURRENT_RPM5_64_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_TOOLS_CURRENT_RPM6_64_FILE="cloudoptimizer-tools-${CLOUDOPTIMIZER_CURRENT_RPM6_64_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_TOOLS_CURRENT_RPM5_32_FILE="cloudoptimizer-tools-${CLOUDOPTIMIZER_CURRENT_RPM5_32_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_TOOLS_CURRENT_RPM6_32_FILE="cloudoptimizer-tools-${CLOUDOPTIMIZER_CURRENT_RPM6_32_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_TOOLS_CURRENT_DEB10_64_FILE="cloudoptimizer-tools_${CLOUDOPTIMIZER_CURRENT_DEB10_64_LABEL}_amd64.deb"
CLOUDOPTIMIZER_TOOLS_CURRENT_DEB12_64_FILE="cloudoptimizer-tools_${CLOUDOPTIMIZER_CURRENT_DEB12_64_LABEL}_amd64.deb"
CLOUDOPTIMIZER_TOOLS_CURRENT_DEB10_32_FILE="cloudoptimizer-tools_${CLOUDOPTIMIZER_CURRENT_DEB10_32_LABEL}_amd64.deb"
CLOUDOPTIMIZER_TOOLS_CURRENT_DEB12_32_FILE="cloudoptimizer-tools_${CLOUDOPTIMIZER_CURRENT_DEB12_32_LABEL}_amd64.deb"

CLOUDOPTIMIZER_TOOLS_PREVIOUS_RPM5_64_FILE="cloudoptimizer-tools-${CLOUDOPTIMIZER_PREVIOUS_RPM5_64_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_TOOLS_PREVIOUS_RPM6_64_FILE="cloudoptimizer-tools-${CLOUDOPTIMIZER_PREVIOUS_RPM6_64_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_TOOLS_PREVIOUS_RPM5_32_FILE="cloudoptimizer-tools-${CLOUDOPTIMIZER_PREVIOUS_RPM5_32_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_TOOLS_PREVIOUS_RPM6_32_FILE="cloudoptimizer-tools-${CLOUDOPTIMIZER_PREVIOUS_RPM6_32_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_TOOLS_PREVIOUS_DEB10_64_FILE="cloudoptimizer-tools_${CLOUDOPTIMIZER_PREVIOUS_DEB10_64_LABEL}_amd64.deb"
CLOUDOPTIMIZER_TOOLS_PREVIOUS_DEB12_64_FILE="cloudoptimizer-tools_${CLOUDOPTIMIZER_PREVIOUS_DEB12_64_LABEL}_amd64.deb"
CLOUDOPTIMIZER_TOOLS_PREVIOUS_DEB10_32_FILE="cloudoptimizer-tools_${CLOUDOPTIMIZER_PREVIOUS_DEB10_32_LABEL}_amd64.deb"
CLOUDOPTIMIZER_TOOLS_PREVIOUS_DEB12_32_FILE="cloudoptimizer-tools_${CLOUDOPTIMIZER_PREVIOUS_DEB12_32_LABEL}_amd64.deb"

# CloudOptimizer WebUI Packages

CLOUDOPTIMIZER_WEBUI_CURRENT_RPM5_64_FILE="cloudoptimizer-webui-${CLOUDOPTIMIZER_CURRENT_RPM5_64_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_WEBUI_CURRENT_RPM6_64_FILE="cloudoptimizer-webui-${CLOUDOPTIMIZER_CURRENT_RPM6_64_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_WEBUI_CURRENT_RPM5_32_FILE="cloudoptimizer-webui-${CLOUDOPTIMIZER_CURRENT_RPM5_32_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_WEBUI_CURRENT_RPM6_32_FILE="cloudoptimizer-webui-${CLOUDOPTIMIZER_CURRENT_RPM6_32_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_WEBUI_CURRENT_DEB10_64_FILE="cloudoptimizer-webui_${CLOUDOPTIMIZER_CURRENT_DEB10_64_LABEL}_amd64.deb"
CLOUDOPTIMIZER_WEBUI_CURRENT_DEB12_64_FILE="cloudoptimizer-webui_${CLOUDOPTIMIZER_CURRENT_DEB12_64_LABEL}_amd64.deb"
CLOUDOPTIMIZER_WEBUI_CURRENT_DEB10_32_FILE="cloudoptimizer-webui_${CLOUDOPTIMIZER_CURRENT_DEB10_32_LABEL}_amd64.deb"
CLOUDOPTIMIZER_WEBUI_CURRENT_DEB12_32_FILE="cloudoptimizer-webui_${CLOUDOPTIMIZER_CURRENT_DEB12_32_LABEL}_amd64.deb"

CLOUDOPTIMIZER_WEBUI_PREVIOUS_RPM5_64_FILE="cloudoptimizer-webui-${CLOUDOPTIMIZER_PREVIOUS_RPM5_64_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_WEBUI_PREVIOUS_RPM6_64_FILE="cloudoptimizer-webui-${CLOUDOPTIMIZER_PREVIOUS_RPM6_64_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_WEBUI_PREVIOUS_RPM5_32_FILE="cloudoptimizer-webui-${CLOUDOPTIMIZER_PREVIOUS_RPM5_32_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_WEBUI_PREVIOUS_RPM6_32_FILE="cloudoptimizer-webui-${CLOUDOPTIMIZER_PREVIOUS_RPM6_32_LABEL}.x86_64.rpm"
CLOUDOPTIMIZER_WEBUI_PREVIOUS_DEB10_64_FILE="cloudoptimizer-webui_${CLOUDOPTIMIZER_PREVIOUS_DEB10_64_LABEL}_amd64.deb"
CLOUDOPTIMIZER_WEBUI_PREVIOUS_DEB12_64_FILE="cloudoptimizer-webui_${CLOUDOPTIMIZER_PREVIOUS_DEB12_64_LABEL}_amd64.deb"
CLOUDOPTIMIZER_WEBUI_PREVIOUS_DEB10_32_FILE="cloudoptimizer-webui_${CLOUDOPTIMIZER_PREVIOUS_DEB10_32_LABEL}_amd64.deb"
CLOUDOPTIMIZER_WEBUI_PREVIOUS_DEB12_32_FILE="cloudoptimizer-webui_${CLOUDOPTIMIZER_PREVIOUS_DEB12_32_LABEL}_amd64.deb"

# Other Packages - These will have to be updated on occasion
#
# We only use these packages for manual installation or as a supplement to automatic installation when the required
# packages are not available from repositories for the distribution

# collectd

COLLECTD_4_10_3_RPM5_64="ftp://ftp.pbone.net/mirror/download.fedora.redhat.com/pub/fedora/epel/5/x86_64/collectd-4.10.3-1.el5.x86_64.rpm"
COLLECTD_RRDTOOL_RPM6_64="http://dl.fedoraproject.org/pub/epel/6/x86_64/collectd-rrdtool-4.10.8-1.el6.x86_64.rpm"

# dejavu

DEJAVU_FONTS_COMMON_RPM6_64="http://mirror.centos.org/centos/6/os/i386/Packages/dejavu-fonts-common-2.30-2.el6.noarch.rpm"
DEJAVU_LGC_SANS_MONO_FONTS_RPM6_64="http://dl.atrpms.net/el6-i386/atrpms/testing/dejavu-lgc-sans-mono-fonts-2.30-2.noarch.rpm"
DEJAVU_SANS_MONO_FONTS_RPM6_64="http://mirror.centos.org/centos/6/os/i386/Packages/dejavu-sans-mono-fonts-2.30-2.el6.noarch.rpm"

# fontpackages_filesystem

FONTPACKAGES_FILESYSTEM="http://mirror.centos.org/centos/6/os/i386/Packages/fontpackages-filesystem-1.41-1.1.el6.noarch.rpm"

# gperftools

LIBGOOGLE_PERFTOOLS0_DEB12_64="http://launchpadlibrarian.net/93406085/libgoogle-perftools0_1.7-1ubuntu1_amd64.deb"
GOOGLE_PERFTOOLS_RPM6_64="ftp://rpmfind.net/linux/epel/6/x86_64/gperftools-libs-2.0-3.el6.2.x86_64.rpm"
GPERFTOOLS_LIBS_RPM5_64="http://puias.math.ias.edu/data/puias/computational/5/x86_64/gperftools-libs-2.0-3.el5.2.x86_64.rpm"
GPERFTOOLS_LIBS_RPM6_64="ftp://fr2.rpmfind.net/linux/epel/6/x86_64/gperftools-libs-2.0-3.el6.2.x86_64.rpm"

# libnet

LIBNET_DEVEL_RPM6_64="http://yum.cloudopt.com/CentOS-6/x86_64/libnet-devel-1.1.5-2cnt6.x86_64.rpm"
LIBNET_RPM6_64="http://yum.cloudopt.com/CentOS-6/x86_64/libnet-1.1.5-2cnt6.x86_64.rpm"

# libnetfilter_queue

LIBNETFILTER_QUEUE_RPM5_32="http://yum.cloudopt.com/CentOS/i386/libnetfilter_queue-1.0.0-1.el5.i386.rpm"
LIBNETFILTER_QUEUE_SO_1_RPM5_32="http://yum.cloudopt.com/CentOS/SRPMS/libnetfilter_queue-1.0.0-1.el5.src.rpm"
LIBNETFILTER_QUEUE_RPM6_64="http://yum.cloudopt.com/CentOS-6/x86_64/libnetfilter_queue-1.0.0-2cnt6.x86_64.rpm"
LIBNETFILTER_QUEUE_SO_1_RPM6_64="http://yum.cloudopt.com/CentOS-6/x86_64/libnetfilter_queue-devel-1.0.0-2cnt6.x86_64.rpm"

# libnfnetlink

LIBNFNETLINK_RPM6_64="http://yum.cloudopt.com/CentOS-6/x86_64/libnfnetlink-1.0.0-2cnt6.x86_64.rpm"
LIBNFNETLINK_SO_0_RPM5_32="http://yum.cloudopt.com/CentOS/i386/libnfnetlink-1.0.0-1.el5.i386.rpm"
LIBNFNETLINK_SO_0_RPM6_64="http://yum.cloudopt.com/CentOS-6/x86_64/libnfnetlink-devel-1.0.0-2cnt6.x86_64.rpm"

# libtcmalloc_minimal

LIBTCMALLOC_MINIMAL0_DEB12_64="http://launchpadlibrarian.net/93406083/libtcmalloc-minimal0_1.7-1ubuntu1_amd64.deb"

# libunwind

LIBUNWIND7_DEB12_64="http://launchpadlibrarian.net/83640348/libunwind7_0.99-0.3ubuntu1_amd64.deb"

# monit

MONIT_5_1_1_RPM5_64="http://yum.cloudopt.com/CentOS/x86_64/monit-5.1.1-1.el5.rf.x86_64.rpm"
MONIT_5_1_1_RPM6_64="http://dl.fedoraproject.org/pub/epel/6/x86_64/monit-5.1.1-4.el6.x86_64.rpm"

# netcat

NC_RPM6_64="ftp://rpmfind.net/linux/centos/6.3/os/x86_64/Packages/nc-1.84-22.el6.x86_64.rpm"

# rrdtool

RRDTOOL="http://mirror.centos.org/centos/6/os/x86_64/Packages/rrdtool-1.3.8-6.el6.x86_64.rpm"

# xfsprogs

XFSPROGS_RPM5_64="ftp://ftp.pbone.net/mirror/ftp.freshrpms.net/pub/freshrpms/pub/freshrpms/redhat/testing/EL5/xfs/x86_64/xfsprogs-2.9.4-4.el5/xfsprogs-2.9.4-4.el5.x86_64.rpm"
XFSPROGS_RPM6_64="ftp://ftp.pbone.net/mirror/ftp.centos.org/6.3/os/x86_64/Packages/xfsprogs-3.1.1-7.el6.x86_64.rpm"


log="/var/log/cloudoptimizer-install.log"

rundir=`pwd "${BASH_SOURCE[0]}"`


#############
# Functions #
#############

# guessdist()
# Check to see if we are running on a supported version
guessdist() {
    if [ "$forcedist" == "1" ] && [ "$forcever" == "1" ]; then
        distro="$force_distro"
        version="$force_version"
        ddesc="User Defined"
        message "You have chosen to force the Linux distribution and version." warning
        message "You should not continue unless you know what you are doing.  Forcing the distribution could leave your system in an unstable state." warning
        message "You have specified the distribution \"$distro\" and the version \"$version\"."
        message " Continue? (y/n) " prompt
        if ! yesno force
            then die "Installation cancelled."
        fi
    elif [ "$forcedist" == "1" ] || [ "$forcever" == "1" ]; then
        die "You must set both a distribution and version when forcing the Linux type."
    else
        command -v lsb_release >>$log && lsb="true" || lsb="false"

        if [ "$lsb" = "true" ]; then
            distro=`lsb_release -si`
            version=`lsb_release -sr`
            ddistro=`lsb_release -sd |cut -d" " -f1`
            dversion=`lsb_release -sd |cut -d" " -f2`
            ddesc=`lsb_release -sd`
        else
            issuelen=`head -n1 /etc/issue |wc -w`
            distro=`head -n1 /etc/issue |cut -d" " -f1`
            ddistro="$distro"
            if [ "$distro" == "Debian" ]; then
                version=`head -n1 /etc/debian_version`
            elif [ "$distro" == "Fedora" ]; then
                version=`head -n1 /etc/issue |cut -d" " -f3`
            elif [ "$distro" == "Scientific" ]; then
                version=`head -n1 /etc/issue |cut -d" " -f4`
            else
                version=`head -n1 /etc/issue |cut -d" " -f$issuelen`
            fi
        fi
    fi
    
    if [ "$ddistro" != "$distro" ]; then
        deriv="$ddistro $dversion"
    else
        deriv="$distro"
    fi
    
    majorver=`echo "$version" |cut -d. -f1`
    os_version="$majorver"
    arch=`uname -m`

    # Handle Fedora/CentOS differing 32-bit arch type
    if [ "$arch" = "i686" ]; then
        arch="i386"
    fi
    if [ "$distro" == "RedHatEnterpriseLinux" ]; then
        distro="RedHatEnterpriseServer"
    fi
    if [ "$distro" == "OracleServer" ] || [ "$distro" == "EnterpriseEnterpriseServer" ]; then
        distro="Oracle"
    fi
    if [ "$distro" == "AmazonAMI" ]; then
        distro="Amazon"
    fi
    if [ "$distro" == "SUSE LINUX" ]; then
        distro="SUSE"
    fi
}

# die()
# Fails the script with a blurb about support
die() {
    if [ "$1" != "" ]; then message "$1" error; fi
    message "If this script failed unexpectedly, please re-run the script with '--support' as a parameter and e-mail the resulting file to support@cloudopt.com."
    exit 1
}

# yesno()
# Provides a yes/no prompt
yesno() {
    if [ "$skipyesno" == "1" ] && [ "$1" != "force" ]; then
        echo
        return 0
    elif [ "$skipyesno" == "1" ] && [ "$force" == "1" ]; then
        echo
        return 0
    fi
    while read line; do
        datestamp=`date +%y%m%d%H%M`
        echo "$datestamp - User entered $line" >>$log
        case $line in
            y|Y|Yes|YES|yes|yES|yEs|YeS|yeS) echo;return 0
            ;;
            n|N|No|no|nO) echo;return 1
            ;;
            *)
            message "Please enter y or n: " bold
            ;;
        esac
    done
}

# download()
# Uses $download to download the provided filename or exit with an error.
download() {
    if [ "$local" == "1" ]; then
        message "Local install: checking for presence of the required package" action
        [ -f "$1" ] && message "OK" status || die "Required package $1 is not present.  You must put it in the same directory as this installer."  
    elif [ "$2" == "silent" ]; then
        $download $1
        if [ $? = 0 ]; then
            return $?
        else
            die "Failed to download $1."
        fi
    else
        message "Downloading $1" action
        $download $1 && message "OK" status
        if [ $? = 0 ]; then
            return $?
        else
            die "Failed to download $1."
        fi
    fi

}

showhelp() {
    message "-a|--auto                Automatic installation: the same as using --accept-eula, --yes, --force, and --noupdate." nolog
    message "-c|--check               Check to see if installation is possible, but don't install any files." nolog
    message "--distro <distro>        Specify a Linux distribution that the script recognizes in order to try installing on an unsupported distro." nolog
    message "-e|--accept-eula         Accept the CloudOptimizer end user license agreement (for automated installation)." nolog
    message "-f|--force               A stronger --yes, will bypass prompts for actions that may be destructive (for automated installation)." nolog
    message "-h|--help                Show this help screen." nolog
    message "-l|--local               Perform an install without connection to the Internet.  Package files must be located in the same directory as the script." nolog
    message "-m|--manifest            Generate a script that will download all the required packages on another system (for local install.)" nolog
    message "-n|--noupdate            Don't check for a more recent version of the installer (recommended for automated installation)." nolog
    message "--noclean                Don't clean up the script's temp directory, downloaded files, etc."
    message "-p|--previous            Install the previous version (not recommended unless advised by CloudOpt Support)." nolog
    message "--password <password>    Set the WebUI password from the command line for automated installation." nolog
    message "-r|--reposonly           Only install the software repositories." nolog
    message "-s|--support             Collect diagnostic information in a file for CloudOpt support if this script failed." nolog
    message "-t|--tarball             Use a package archive created with --manifest for local installation." nolog
    message "-u|--remove              Remove CloudOptimizer but leave all cache and configuration files." nolog
    message "--version <version>      Specify a Linux version that the script recognizes in order to try installing on an unsupported distro." nolog
    message "-y|--yes                 Bypass most prompts, answering yes (for automated installation)." nolog
    message "-x|--purge               Remove CloudOptimizer and delete everything that is not removed by the package manager." nolog
}

# message()
# Prints messages to the screen and to the log file
# Does some simple formatting for terminals that don't wrap
message() {
    term_width=`stty size| cut -d' ' -f2`
    width_90=`expr $term_width - $term_width / 10`
    if [ "$width_90" -lt "160" ]; then
        use_width="$width_90"
    else
        use_width=160
    fi
    chars=`echo "{$1}" |wc -m`
    if [ "$2" == "error" ]; then
        chars=`expr $chars + 7`
    elif [ "$2" == "warning" ]; then
        chars=`expr $chars + 9`
    fi
    lines_int=`expr $chars / $use_width`
    lines_rem=`expr $chars % $use_width`
    if [ "$lines_rem" != "0" ]; then
        lines=`expr $lines_int + 2`
    else
        lines=`expr $lines_int + 1`
    fi
    line_num=0
    if [ "$2" == "error" ] || [ "$2" == "warning" ]; then
        echo
    fi
    while [ $lines -gt 0 ]; do
        from_cut=`expr $line_num \* $use_width + 1`
        to_cut=`expr $from_cut - 1 + $use_width`
        if [ "$2" == "title" ]; then
            echo -e "\033[1m${1}\033[0m" |cut -c $from_cut-$to_cut
        elif [ "$2" == "error" ]; then
            echo -e "\e[7mERROR:\e[27m ${1}" |cut -c $from_cut-$to_cut
        elif [ "$2" == "warning" ]; then
            echo -e "\e[7mWarning:\e[27m ${1}" |cut -c $from_cut-$to_cut
        elif [ "$2" == "prompt" ] && [ "$3" == "force" ] && [ "$force" == "0" ]; then
            echo -n -e "\033[1m${1}\033[0m" |cut -c $from_cut-$to_cut |tr -d '\n'
        elif [ "$2" == "prompt" ] && [ "$skipyesno" == "0" ]; then
            echo -n -e "\033[1m${1}\033[0m" |cut -c $from_cut-$to_cut |tr -d '\n'
        elif [ "$2" == "action" ]; then
            echo -n "${1}...  " |cut -c $from_cut-$to_cut |tr -d '\n'
        elif [ "$2" == "status" ]; then
            echo -n -e "\033[1m[\033[0m${1}\033[1m]\033[0m" |cut -c $from_cut-$to_cut
        else
            echo "${1}" |cut -c $from_cut-$to_cut
        fi
        lines=`expr $lines - 1`
        line_num=`expr $line_num + 1`
    done 
    datestamp=`date +%y%m%d%H%M`
    if [ "$2" != "nolog" ]; then
        echo "$datestamp - ${1}" >>$log
    fi
}

install_apt() {
    message "Installing cloudoptimizer-tools package" action
    apt-get -qqy install cloudoptimizer-tools=$vlabel >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer Tools! Exiting."
    message "Installing cloudoptimizer package" action
    apt-get -qqy install cloudoptimizer=$vlabel >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer! Exiting."
    message "Installing cloudoptimizer-webui package" action
    apt-get -qqy install cloudoptimizer-webui=$vlabel >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer WebUI! Exiting."
}

remove_apt() {
    message " Remove CloudOptimizer? (y/n) " prompt
    if ! yesno
        then die "Failed to remove CloudOptimizer.  Exiting."
    fi
    action="remove"
    message "Removing CloudOptimizer..."
    if [ "$purge" == "1" ]; then
        action="purge"
        message "Purging will remove files that you have changed since installation." warning
        message " Proceed? (y/n) " prompt force
        if !  yesno force
            then die "Install cancelled."
        fi
        command -v cloudconfig >>$log 2>&1 && homedir=`cloudconfig get /config/home` || message "Couldn't determine home directory.  Continuing anyway.  You might need to do some manual cleanup." warning
        command -v cloudconfig >>$log 2>&1 && logdir=`cloudconfig get /config/log_dir` || message "Couldn't determine log directory.  Continuing anyway.  You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer-webui" action
        apt-get -qqy $action --auto-remove cloudoptimizer-webui >>$log && message "OK" status || message "Could not remove CloudOptimizer WebUI! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer" action
        apt-get -qqy $action --auto-remove cloudoptimizer >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer-tools" action
        apt-get -qqy $action --auto-remove cloudoptimizer-tools >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer Tools! You might need to do some manual cleanup." warning
        message "Removing CloudOptimizer home directory" action
        rm -rf $homedir && message "OK" status || message "Couldn't remove home directory.  You might need to do some manual cleanup." warning
        message "Removing /etc/cloudoptimizer" action
        rm -rf /etc/cloudoptimizer && message "OK" status || message "Couldn't remove /etc/cloudoptimizer! You might need to do some manual cleanup." warning
        message "Removing /var/run/cloudopt-webserver" action
        rm -rf /var/run/cloudopt-webserver && message "OK" status || message "Couldn't remove /var/run/cloudopt-webserver! You might need to do some manual cleanup." warning
        message "Removing cores" action
        rm -f /var/crash/cloudopt* && message "OK" status || message "Couldn't remove cores! You might need to do some manual cleanup." warning
        message "Removing /var/log/cloudoptimizer" action
        rm -rf $logdir && message "OK" status || message "Couldn't remove log directory.  You might need to do some manual cleanup." warning
        message "Removing init scripts" action
        rm -f /etc/init.d/cloudoptimizer* && message "OK" status || message "Couldn't remove init scripts.  You might need to do some manual cleanup." warning
        repodir="/etc/apt/sources.list.d"
        existing_repos=(`find $repodir | egrep [Cc]loud[Oo]pt`)
        for existing_repo in ${existing_repos[@]}; do
            message "Removing repo ${existing_repo}" action 
            rm ${existing_repo} && message "OK" status || message "Could not remove ${existing_repo}! You might need to do some manual cleanup." warning
        done
    else
        message "Removing cloudoptimizer-webui" action
        apt-get -qqy $action --auto-remove cloudoptimizer-webui >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer WebUI! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer" action
        apt-get -qqy $action --auto-remove cloudoptimizer >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer-tools" action
        apt-get -qqy $action --auto-remove cloudoptimizer-tools >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer Tools! You might need to do some manual cleanup." warning
    fi
}

install_yum() {
    message "Installing cloudoptimizer-tools package" action
    yum -q -y install cloudoptimizer-tools-$supports_ver >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer Tools! Exiting."
    message "Installing cloudoptimizer package" action
    yum -q -y install cloudoptimizer-$supports_ver >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer! Exiting."
    message "Installing cloudoptimizer-webui package" action
    yum -q -y install cloudoptimizer-webui-$supports_ver >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer WebUI! Exiting."
}

remove_yum() {
    message " Remove CloudOptimizer? (y/n) " prompt
    if ! yesno
        then die "Failed to remove CloudOptimizer.  Exiting."
    fi
    message "Removing CloudOptimizer..."
    if [ "$purge" == "1" ]; then
        message "Purging will remove files that you have changed since installation." warning
        message " Proceed? (y/n) " prompt force
        if !  yesno force
            then die "Install cancelled."
        fi
        command -v cloudconfig >>$log 2>&1 && homedir=`cloudconfig get /config/home` || message "Couldn't determine home directory.  Continuing anyway.  You might need to do some manual cleanup." warning
        command -v cloudconfig >>$log 2>&1 && logdir=`cloudconfig get /config/log_dir` || message "Couldn't determine log directory.  Continuing anyway.  You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer-webui" action
        yum -q -y remove cloudoptimizer-webui --setopt=clean_requirements_on_remove=1 >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer WebUI! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer" action
        yum -q -y remove cloudoptimizer --setopt=clean_requirements_on_remove=1 >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer-tools" action
        yum -q -y remove cloudoptimizer-tools --setopt=clean_requirements_on_remove=1 >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer Tools! You might need to do some manual cleanup." warning
        message "Removing CloudOptimizer home directory" action
        rm -rf $homedir && message "OK" status || message "Couldn't remove home directory.  You might need to do some manual cleanup." warning
        message "Removing /etc/cloudoptimizer" action
        rm -rf /etc/cloudoptimizer && message "OK" status || message "Couldn't remove /etc/cloudoptimizer! You might need to do some manual cleanup." warning
        message "Removing /var/run/cloudopt-webserver" action
        rm -rf /var/run/cloudopt-webserver && message "OK" status || message "Couldn't remove /var/run/cloudopt-webserver! You might need to do some manual cleanup." warning
        message "Removing cores" action
        rm -f /var/crash/cloudopt* && message "OK" status || message "Couldn't remove cores!  You might need to do some manual cleanup." warning
        message "Removing /var/log/cloudoptimizer" action
        rm -rf $logdir && message "OK" status || message "Couldn't remove log directory.  You might need to do some manual cleanup." warning
        message "Removing init scripts" action
        rm -f /etc/init.d/cloudoptimizer* && message "OK" status || message "Couldn't remove init scripts.  You might need to do some manual cleanup." warning
        if [ "$distro" == "Mageia" ]; then
            repodir="/etc/yum/repos.d"
        elsen
            repodir="/etc/yum.repos.d"
        fi
        existing_repos=(`find $repodir | egrep [Cc]loud[Oo]pt`)
        for existing_repo in ${existing_repos[@]}; do
            message "Removing repo ${existing_repo}" action 
            rm ${existing_repo} && message "OK" status || message "Could not remove ${existing_repo}! You might need to do some manual cleanup." warning
        done
        message "Clearing yum caches" action
        rm -rf /var/cache/yum/$arch/$majorver/CloudOpt* >>$log 2>&1 && yum clean all >>$log && message "OK" status || "Could not purge yum caches.  You might need to do some manual cleanup." warning
    else
        message "Removing cloudoptimizer-webui" action
        yum -q -y remove cloudoptimizer-webui --setopt=clean_requirements_on_remove=1 >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer WebUI! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer" action
        yum -q -y remove cloudoptimizer --setopt=clean_requirements_on_remove=1 >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer-tools" action
        yum -q -y remove cloudoptimizer-tools --setopt=clean_requirements_on_remove=1 >>$log 2>&1 && message "OK" message || die "Could not remove CloudOptimizer Tools! You might need to do some manual cleanup." warning
    fi
}

install_deps_rpm() {
    if [ "$manifest" == "1" ]; then
        averb="Finding"
    else
        averb="Installing"
    fi
    if [ "$local" == "1" ]; then
        # Install / obtain dependencies
        num_packages=${#dep_packages[@]}
        for (( i = 0; i < $num_packages; i++)); do
            pkg_url=${dep_packages[i]}
            pkg_name=`basename ${dep_packages[i]}`
            if [ "$manifest" == "1" ]; then
                message "$averb $pkg_name package" action
                echo "wget $pkg_url" >>$dl_script && echo "tar -rf cloudoptimizer-packages.tar $pkg_name" >>$dl_script && message "OK" status || die "Could not write to script! Exiting."
            else
                download $rundir/$pkg_name
                message "$averb $pkg_name package" action
                pkg_short_name=`rpm --qf "%{NAME}\n" -qp $rundir/$pkg_name`
                rpm -q $pkg_short_name >>$log 2>&1 || rpm -i $rundir/$pkg_name >>$log 2>&1 && message "OK" status || die "Could not install $pkg_name! Exiting."
            fi
        done
    else
        num_packages=${#dep_packages[@]}
        for (( i = 0; i < $num_packages; i++)); do
            pkg_url=${dep_packages[i]}
            pkg_name=`basename ${dep_packages[i]}`
            if [ "$manifest" == "1" ]; then
                message "$averb $pkg_name package" action
                echo "wget $pkg_url" >>$dl_script && echo "tar -rf cloudoptimizer-packages.tar $pkg_name" >>$dl_script && message "OK" status || die "Could not write to script! Exiting."
            else
                download $pkg_url
                message "$averb $pkg_name package" action
                pkg_short_name=`rpm --qf "%{NAME}\n" -qp $pkg_name`
                rpm -q $pkg_short_name >>$log 2>&1 || rpm -i $pkg_name >>$log 2>&1 && message "OK" status || die "Could not install $pkg_name! Exiting."
            fi
        done
    fi
}

install_rpm() {
    if [ "$manifest" == "1" ]; then
        averb="Finding"
    else
        averb="Installing"
    fi
    rpm_cmd="rpm"
    if [ "$local" == "1" ]; then
        # Install / obtain cloudoptimizer-tools
        if [ "$manifest" == "1" ]; then
            message "$averb cloudoptimizer-tools package" action
            echo "wget $repopath/$tpkg" >>$dl_script && echo "tar -rf cloudoptimizer-packages.tar $tpkg" >>$dl_script && message "OK" status || die "Could not write to script! Exiting."
        else
            download $rundir/$tpkg
            message "$averb cloudoptimizer-tools package" action
            rpm -q cloudoptimizer-tools >>$log 2>&1 || $rpm_cmd -i $rundir/$tpkg >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer Tools ($tpkg)! Exiting."
        fi
        # Install / obtain cloudoptimizer
        if [ "$manifest" == "1" ]; then
            message "$averb cloudoptimizer package" action
            echo "wget $repopath/$mpkg" >>$dl_script && echo "tar -rf cloudoptimizer-packages.tar $mpkg" >>$dl_script && message "OK" status || die "Could not write to script! Exiting."
        else
            download $rundir/$mpkg
            message "$averb cloudoptimizer package" action
            rpm -q cloudoptimizer >>$log 2>&1 || $rpm_cmd -i $rundir/$mpkg >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer ($mpkg)! Exiting."
        fi
        # Install / obtain cloudoptimizer-webui
        if [ "$manifest" == "1" ]; then
            message "$averb cloudoptimizer-webui package" action
            echo "wget $repopath/$wpkg" >>$dl_script && echo "tar -rf cloudoptimizer-packages.tar $wpkg" >>$dl_script && message "OK" status || die "Could not write to script! Exiting."
        else
            download $rundir/$wpkg
            message "$averb cloudoptimizer-webui package" action
            rpm -q cloudoptimizer-webui >>$log 2>&1 || $rpm_cmd -i $rundir/$wpkg >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer WebUI ($wpkg)! Exiting."
        fi
    else
        message "Installing cloudoptimizer-tools package" action
        $rpm_cmd -Uvh $repopath/$tpkg && message "OK" status || die "Could not install Cloudoptimizer Tools! Exiting."
        message "Installing cloudoptimizer package" action
        $rpm_cmd -Uvh $repopath/$mpkg && message "OK" status || die "Could not install Cloudoptimizer! Exiting."
        message "Installing cloudoptimizer-webui package" action
        $rpm_cmd -Uvh $repopath/$wpkg && message "OK" status || die "Could not install Cloudoptimizer WebUI! Exiting."
    fi
}

install_deps_gdebi() {
    command -v gdebi >>$log 2>&1 && gdebi=1 || gdebi=0
    if [ "$gdebi" == "0" ]; then
        message "We need to install and use gdebi-core in order to install on this version of Linux." warning
        message " Would you like us to install it now? (y/n) " prompt
        if ! yesno
            then die "We can't install without gdebi.  Exiting."
        fi
        message "Installing gdebi-core" action
        apt-get -qqy install gdebi-core >>$log 2>&1 && message "OK" status || die "Could not install gdebi-core!  Exiting."
    fi
    if [ "$manifest" == "1" ]; then
        averb="Finding"
    else
        averb="Installing"
    fi
    if [ "$local" == "1" ]; then
        # Install / obtain dependencies
        num_packages=${#dep_packages[@]}
        for (( i = 0; i < $num_packages; i++)); do
            pkg_url=${dep_packages[i]}
            pkg_name=`basename ${dep_packages[i]}`
            if [ "$manifest" == "1" ]; then
                message "$averb $pkg_name package" action
                echo "wget $pkg_url" >>$dl_script && echo "tar -rf cloudoptimizer-packages.tar $pkg_name" >>$dl_script && message "OK" status || die "Could not write to script! Exiting."
            else
                download $rundir/$pkg_name
                message "$averb $pkg_name package" action
                pkg_short_name=`dpkg -f $rundir/$pkg_name Package`
                dpkg-query -W $pkg_short_name >>$log 2>&1 || gdebi --n --q $rundir/$pkg_name >>$log 2>&1 && message "OK" status || die "Could not install $pkg_name! Exiting."
            fi
        done
    else
        num_packages=${#dep_packages[@]}
        for (( i = 0; i < $num_packages; i++)); do
            pkg_url=${dep_packages[i]}
            pkg_name=`basename ${dep_packages[i]}`
            if [ "$manifest" == "1" ]; then
                message "$averb $pkg_name package" action
                echo "wget $pkg_url" >>$dl_script && echo "tar -rf cloudoptimizer-packages.tar $pkg_name" >>$dl_script && message "OK" status || die "Could not write to script! Exiting."
            else
                download $pkg_url
                message "$averb $pkg_name package" action
                pkg_short_name=`dpkg -f $pkg_name Package`
                dpkg-query -W $pkg_short_name >>$log 2>&1 || gdebi --n --q $pkg_name >>$log 2>&1 && message "OK" status || die "Could not install $pkg_name! Exiting."
            fi
        done
    fi
}

install_gdebi() {
    command -v gdebi >>$log 2>&1 && gdebi=1 || gdebi=0
    if [ "$gdebi" == "0" ]; then
        message "We need to install and use gdebi-core in order to install on this version of Linux." warning
        message " Would you like us to install it now? (y/n) " prompt
        if ! yesno
            then die "We can't install without gdebi.  Exiting."
        fi
        message "Installing gdebi-core" action
        apt-get -qqy install gdebi-core >>$log 2>&1 && message "OK" status || die "Could not install gdebi-core!  Exiting."
    fi
    message "Downloading CloudOptimizer packages..."
    download $repopath/$tpkg && download $repopath/$mpkg && download $repopath/$wpkg
    message "Installing cloudoptimizer-tools package" action
    gdebi --n --q $tpkg >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer Tools! Exiting."
    message "Installing cloudoptimizer package" action
    gdebi --n --q $mpkg >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer! Exiting."
    message "Installing cloudoptimizer-webui package" action
    gdebi --n --q $wpkg >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer WebUI! Exiting."
}


##################
#   Main Script  #
##################

# Check for bash
(( true )) && message "This script requires bash! Don't use sh!" error && exit 1

# Require superuser privileges
id | grep "uid=0(" >>$log
if [ "$?" != "0" ]; then
    die "The Cloudoptimizer install script must be run as root" error
fi

message "CloudOptimizer Linux Client Installer version $INSTALLER_VERSION" title

# Check whether /tmp is mounted noexec (everything will fail, if so)
TMPNOEXEC=`grep /tmp /etc/mtab | grep noexec`
if [ "$TMPNOEXEC" != "" ]; then
    message "/tmp directory is mounted noexec. Installation cannot continue." error
    exit 1
fi

# Check for wget, curl or fetch
if [ -x "/usr/bin/curl" ]; then
    download="/usr/bin/curl -sf -O "
elif [ -x "/usr/bin/wget" ]; then
    download="/usr/bin/wget -q"
elif [ -x "/usr/bin/fetch" ]; then
    download="/usr/bin/fetch -q"
else
    message "No web download program available: Please install curl, wget or fetch and try again." error
    exit 1
fi

# Find temp directory
if [ "$TMPDIR" = "" ]; then
    TMPDIR=/tmp
fi
if [ "$tempdir" = "" ]; then
    tempdir=$TMPDIR/.cloudopt-$$
    if [ -e "$tempdir" ]; then
        rm -rf $tempdir
    fi
    mkdir $tempdir
fi

cd $tempdir

# Options defaults
is_supported=0
accepteula=0
skipyesno=0
onlycheck=0
testing=0
noupdate=0
reposonly=0
force=0
previous=0
remove=0
purge=0
local=0
manifest=0
tarball=0
noclean=0
password=0
forcedist=0
forcever=0

while [ "$1" != "" ]; do
    if [[ "$2" != -* ]]; then
        flagarg="$2"
    else
        flagarg="null"
    fi
    case $1 in
        --accept-eula|-e)
            accepteula=1
        ;;
        --auto|-a)
            accepteula=1
            force=1
            skipyesno=1
            noupdate=1
        ;;
        --check|-c)
            skipyesno=1
            onlycheck=1
        ;;
        --distro)
            if [ "$flagarg" == "null" ]; then
                showhelp
                die "Bad argument for $1"
            else
                forcedist=1
                force_distro="$flagarg"
            fi
        ;;
        --force|-f)
            skipyesno=1
            force=1
        ;;
        --help|-h)
            showhelp
            exit 0
        ;;
        --local|-l)
            noupdate=1
            local=1
        ;;
        --manifest|-m)
            noupdate=1
            local=1
            manifest=1
            dl_script="$rundir/cloudoptimizer-download.sh"
            echo "#!/bin/sh" >$dl_script
            echo "tar -c -T /dev/null -f cloudoptimizer-packages.tar" >>$dl_script
        ;;
        --noclean)
            noclean=1
        ;;
        --noupdate|-n)
            noupdate=1
        ;;
        --password)
            if [ "$flagarg" == "null" ]; then
                showhelp
                die "Bad argument for $1"
            else
                password=1
                ui_password="$flagarg"
            fi
        ;;
        --previous|-p)
            previous=1
        ;;
        --purge|-x)
            remove=1
            purge=1
        ;;
        --remove|-u)
            remove=1
        ;;
        --reposonly|-r)
            reposonly=1
        ;;
        --support|-s)
            tar -cz $TMPDIR/.cloudopt-* $log > $TMPDIR/co-support.tgz \
              && message "${TMPDIR}/co-support.tgz file created. E-mail this to support@cloudopt.com" \
              || message "Something broke, e-mail support@cloudopt.com for help!" error
            exit 0
        ;;
        --tarball|-t)
            tarball=1
            if [ -f "$rundir/cloudoptimizer-packages.tar.gz" ]; then
                noupdate=1
                local=1
                message "Removing packages from archive" action
                tar -xzf $rundir/cloudoptimizer-packages.tar.gz -C $rundir >>$log 2>&1 && message "OK" status || die "Could not open archive."
            else
                die "Didn't find cloudoptimizer-packages.tar.gz in $rundir"
            fi
        ;;
        --testing)
            testing=1
        ;;
        --version)
            if [ "$flagarg" == "null" ]; then
                showhelp
                die "Bad argument for $1"
            else
                forcever=1
                force_version="$flagarg"
            fi
        ;;
        --yes|-y)
            skipyesno=1
        ;;
        *)
            message "Unrecognized flag."
            show help
            exit 0
        ;;
    esac
    if [[ "$2" != -* ]]; then
        shift;shift
    else
        shift
    fi
done

# Check to make sure installer is up to date
if [ "$noupdate" != "1" ]; then
    download "http://kb.cloudopt.com/instver.txt" silent
    instver=`cat instver.txt`
    if [ "$instver" != "$INSTALLER_VERSION" ]; then
        message "This installer is out of date." warning
        message " Do you want to download the update now? (y/n) " prompt
        if ! yesno force
            then die "Please download a new copy at http://kb.cloudopt.com/cloudoptimizer-install.sh.gz or run again with --noupdate."
        fi
        cd $rundir
        message "Backing up the existing script" action
        mv cloudoptimizer-install.sh cloudoptimizer-install-$INSTALLER_VERSION.sh && message "OK" status || die "Couldn't back up existing script."
        download http://kb.cloudopt.com/cloudoptimizer-install.sh.gz
        message "Unpacking install script" action
        gunzip cloudoptimizer-install.sh.gz && message "OK" status || die "Couldn't unpack the installer."
        message "The script has been updated and will now exit.  Run it again to use the updated version."
        exit 0
    else
      message "Installer version $INSTALLER_VERSION is up to date."
    fi
fi

# Guess the distro and version
guessdist

# Classify Linux distributions
# This is where you add new distros to the script
case $distro in
    Amazon)
        case $version in
            2011.09|2012.03|2012.09)
                if [ "$local" == "1" ]; then
                    inst_type="RPM6_MANUAL"
                else
                    inst_type="RPM6_AUTO"
                fi
            ;;
        esac
    ;;
    CentOS)
        case $version in
            5.4|5.5|5.6|5.7|5.8)
                if [ "$local" == "1" ]; then
                    inst_type="RPM5_MANUAL"
                else
                    inst_type="RPM5_AUTO"
                fi
            ;;
            6.0|6.1|6.2|6.3)
                if [ "$local" == "1" ]; then
                    inst_type="RPM6_MANUAL"
                else
                    inst_type="RPM6_AUTO"
                fi
            ;;
        esac
    ;;
    Debian)
        case $version in
            6.0|6.0.1|6.0.2|6.0.3|6.0.4|6.0.5|6.0.6)
                inst_type="DEB10_MANUAL"
            ;;
        esac
    ;;
    Fedora)
        case $version in
            13|14|15|16|17)
                if [ "$local" == "1" ]; then
                    inst_type="RPM6_MANUAL"
                else
                    inst_type="RPM6_AUTO"
                fi
            ;;
        esac
    ;;
    LinuxDeepin)
        case $version in
            12.06)
                inst_type="DEB10_MANUAL"
            ;;
        esac
    ;;
    LinuxMint)
        case $version in
            13|14)
                inst_type="DEB10_MANUAL"
            ;;
        esac
    ;;
    Mageia)
        case $version in
            2|3)
                inst_type="NONE"
            ;;
        esac
    ;;
    Oracle)
        case $version in
            5.8)
                if [ "$local" == "1" ]; then
                    inst_type="RPM5_MANUAL"
                else
                    inst_type="RPM5_AUTO"
                fi
            ;;
            6.0|6.1|6.2|6.3)
                if [ "$local" == "1" ]; then
                    inst_type="RPM6_MANUAL"
                else
                    inst_type="RPM6_AUTO"
                fi
            ;;
        esac
    ;;
    RedHatEnterpriseServer)
        case $version in
            5.4|5.5|5.6|5.7|5.8)
                if [ "$local" == "1" ]; then
                    inst_type="RPM5_MANUAL"
                else
                    inst_type="RPM5_AUTO"
                fi
            ;;
            6.0|6.1|6.2|6.3)
                if [ "$local" == "1" ]; then
                    inst_type="RPM6_MANUAL"
                else
                    inst_type="RPM6_AUTO"
                fi
            ;;
        esac
    ;;
    Scientific)
        case $version in
            5.8)
                if [ "$local" == "1" ]; then
                    inst_type="RPM5_MANUAL"
                else
                    inst_type="RPM5_AUTO"
                fi
            ;;
            6.0|6.1|6.2|6.3)
                if [ "$local" == "1" ]; then
                    inst_type="RPM6_MANUAL"
                else
                    inst_type="RPM6_AUTO"
                fi
            ;;
        esac
    ;;
    SUSE)
        case $version in
            11.4|12|12.1|12.2)
                inst_type="NONE"
            ;;
        esac
    ;;
    Ubuntu)
        case $version in
            10.04|11.04)
                if [ "$local" == "1" ]; then
                    inst_type="DEB10_MANUAL"
                else
                    inst_type="DEB10_AUTO"
                fi
            ;;
            8.04|10.10)
                inst_type="NONE"
            ;;
            11.10)
                inst_type="DEB10_MANUAL"
            ;;
            12.04)
                if [ "$local" == "1" ]; then
                    inst_type="DEB12_MANUAL"
                else
                    inst_type="DEB12_AUTO"
                fi
            ;;
            12.10|13.04)
                inst_type="DEB12_MANUAL" 
            ;;
        esac
    ;;
    Zorin)
        case $version in
            6)
                inst_type="DEB12_MANUAL" 
            ;;
        esac
    ;;
esac

# Find the right version to install
# Classified distros belong to one of the following main types
# Only add new package types here, not new RPM or DEB distros
case $inst_type in
    DEB10_AUTO)
        os_type="ubuntu"
        os_version="10"
        inst_process="auto"
        if [ "$arch" = "x86_64" ]; then
            repopath="${CLOUDOPT_REPO_APT}/${CLOUDOPT_REPO_PATH_DEB10_64}"
            if [ "$testing" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_TESTING_VERSION}"
                vlabel="${CLOUDOPTIMIZER_CURRENT_DEB10_64_LABEL}"
            elif [ "$previous" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_PREVIOUS_VERSION}"
                vlabel="${CLOUDOPTIMIZER_PREVIOUS_DEB10_64_LABEL}"
                mpkg="${CLOUDOPTIMIZER_PREVIOUS_DEB10_64_FILE}"
                wpkg="${CLOUDOPTIMIZER_WEBUI_PREVIOUS_DEB10_64_FILE}"
                tpkg="${CLOUDOPTIMIZER_TOOLS_PREVIOUS_DEB10_64_FILE}"
            else 
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_CURRENT_VERSION}"
                vlabel="${CLOUDOPTIMIZER_CURRENT_DEB10_64_LABEL}"
                mpkg="${CLOUDOPTIMIZER_CURRENT_DEB10_64_FILE}"
                wpkg="${CLOUDOPTIMIZER_WEBUI_CURRENT_DEB10_64_FILE}"
                tpkg="${CLOUDOPTIMIZER_TOOLS_CURRENT_DEB10_64_FILE}"
            fi
        elif [ "$arch" = "i386" ]; then
            is_supported=1
            supports_ver="1.1.7"
        else
            die "Architecture $arch not recognized."
        fi
    ;;
    DEB10_MANUAL)
        os_type="ubuntu"
        os_version="10"
        inst_process="manual"
        if [ "$arch" = "x86_64" ]; then
            repopath="${CLOUDOPT_REPO_APT}/${CLOUDOPT_REPO_PATH_DEB10_64}"
            if [ "$testing" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_TESTING_VERSION}"
            elif [ "$previous" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_PREVIOUS_VERSION}"
                mpkg="${CLOUDOPTIMIZER_PREVIOUS_DEB10_64_FILE}"
                wpkg="${CLOUDOPTIMIZER_WEBUI_PREVIOUS_DEB10_64_FILE}"
                tpkg="${CLOUDOPTIMIZER_TOOLS_PREVIOUS_DEB10_64_FILE}"
            else 
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_CURRENT_VERSION}"
                mpkg="${CLOUDOPTIMIZER_CURRENT_DEB10_64_FILE}"
                wpkg="${CLOUDOPTIMIZER_WEBUI_CURRENT_DEB10_64_FILE}"
                tpkg="${CLOUDOPTIMIZER_TOOLS_CURRENT_DEB10_64_FILE}"
            fi
        elif [ "$arch" = "i386" ]; then
            is_supported=0
        else
            die "Architecture $arch not recognized."
        fi
    ;;
    DEB12_AUTO)
        os_type="ubuntu"
        os_version="12"
        inst_process="auto"
        if [ "$arch" = "x86_64" ]; then
            repopath="${CLOUDOPT_REPO_APT}/${CLOUDOPT_REPO_PATH_DEB12_64}"
            if [ "$testing" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_TESTING_VERSION}"
                vlabel="${CLOUDOPTIMIZER_CURRENT_DEB12_64_LABEL}"
            elif [ "$previous" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_PREVIOUS_VERSION}"
                vlabel="${CLOUDOPTIMIZER_PREVIOUS_DEB12_64_LABEL}"
                mpkg="${CLOUDOPTIMIZER_PREVIOUS_DEB12_64_FILE}"
                wpkg="${CLOUDOPTIMIZER_WEBUI_PREVIOUS_DEB12_64_FILE}"
                tpkg="${CLOUDOPTIMIZER_TOOLS_PREVIOUS_DEB12_64_FILE}"
            else 
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_CURRENT_VERSION}"
                vlabel="${CLOUDOPTIMIZER_CURRENT_DEB12_64_LABEL}"
                mpkg="${CLOUDOPTIMIZER_CURRENT_DEB12_64_FILE}"
                wpkg="${CLOUDOPTIMIZER_WEBUI_CURRENT_DEB12_64_FILE}"
                tpkg="${CLOUDOPTIMIZER_TOOLS_CURRENT_DEB12_64_FILE}"
            fi
        elif [ "$arch" = "i386" ]; then
            is_supported=1
            supports_ver="1.1.7"
        else
            die "Architecture $arch not recognized."
        fi
    ;;
    DEB12_MANUAL)
        os_type="ubuntu"
        os_version="12"
        inst_process="manual"
        if [ "$arch" = "x86_64" ]; then
            repopath="${CLOUDOPT_REPO_APT}/${CLOUDOPT_REPO_PATH_DEB12_64}"
            if [ "$testing" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_TESTING_VERSION}"
            elif [ "$previous" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_PREVIOUS_VERSION}"
                mpkg="${CLOUDOPTIMIZER_PREVIOUS_DEB12_64_FILE}"
                wpkg="${CLOUDOPTIMIZER_WEBUI_PREVIOUS_DEB12_64_FILE}"
                tpkg="${CLOUDOPTIMIZER_TOOLS_PREVIOUS_DEB12_64_FILE}"
            else 
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_CURRENT_VERSION}"
                mpkg="${CLOUDOPTIMIZER_CURRENT_DEB12_64_FILE}"
                wpkg="${CLOUDOPTIMIZER_WEBUI_CURRENT_DEB12_64_FILE}"
                tpkg="${CLOUDOPTIMIZER_TOOLS_CURRENT_DEB12_64_FILE}"
            fi
            dep_packages=($LIBTCMALLOC_MINIMAL0_DEB12_64)
            dep_packages+=($LIBUNWIND7_DEB12_64)
            dep_packages+=($LIBGOOGLE_PERFTOOLS0_DEB12_64)
        elif [ "$arch" = "i386" ]; then
            is_supported=0
        else
            die "Architecture $arch not recognized."
        fi
    ;;
    RPM5_AUTO)
        os_type="rhel"
        os_version="5"
        inst_process="auto"
        if [ "$arch" = "x86_64" ]; then
            repopath="${CLOUDOPT_REPO_YUM}/${CLOUDOPT_REPO_PATH_RPM5_64}"
            if [ "$testing" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_TESTING_VERSION}"
            elif [ "$previous" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_PREVIOUS_VERSION}"
            else 
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_CURRENT_VERSION}"
            fi
            dep_packages=($XFSPROGS_RPM5_64)
            dep_packages+=($COLLECTD_4_10_3_RPM5_64)
        elif [ "$arch" = "i386" ]; then
            is_supported=0
        else
            die "Architecture $arch not recognized."
        fi
    ;;
    RPM5_MANUAL)
        os_type="rhel"
        os_version="5"
        inst_process="manual"
        if [ "$arch" = "x86_64" ]; then
            repopath="${CLOUDOPT_REPO_YUM}/${CLOUDOPT_REPO_PATH_RPM5_64}"
            if [ "$testing" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_TESTING_VERSION}"
            elif [ "$previous" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_PREVIOUS_VERSION}"
                mpkg="${CLOUDOPTIMIZER_PREVIOUS_RPM5_64_FILE}"
                wpkg="${CLOUDOPTIMIZER_WEBUI_PREVIOUS_RPM5_64_FILE}"
                tpkg="${CLOUDOPTIMIZER_TOOLS_PREVIOUS_RPM5_64_FILE}"
            else 
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_CURRENT_VERSION}"
                mpkg="${CLOUDOPTIMIZER_CURRENT_RPM5_64_FILE}"
                wpkg="${CLOUDOPTIMIZER_WEBUI_CURRENT_RPM5_64_FILE}"
                tpkg="${CLOUDOPTIMIZER_TOOLS_CURRENT_RPM5_64_FILE}"
            fi
            dep_packages=($XFSPROGS_RPM5_64)
            dep_packages+=($LIBNET_RPM5_64)
            dep_packages+=($LIBNET_DEVEL_RPM5_64)
            dep_packages+=($LIBNETFILTER_QUEUE_RPM5_64)
            dep_packages+=($LIBNETFILTER_QUEUE_SO_1_RPM5_64)
            dep_packages+=($LIBNFNETLINK_RPM5_64)
            dep_packages+=($LIBNFNETLINK_SO_0_RPM5_64)
            dep_packages+=($NC_RPM5_64)
            dep_packages+=($MONIT_5_1_1_RPM5_64)
            dep_packages+=($GPERFTOOLS_LIBS_RPM5_64)
            dep_packages+=($DEJAVU_FONTS_COMMON_RPM5_64)
            dep_packages+=($DEJAVU_LGC_SANS_MONO_FONTS_RPM5_64)
            dep_packages+=($DEJAVU_SANS_MONO_FONTS_RPM5_64)
            dep_packages+=($FONTPACKAGES_FILESYSTEM_RPM5_64)
            dep_packages+=($RRDTOOL_RPM5_64)
            dep_packages+=($COLLECTD_4_10_3_RPM5_64)
            dep_packages+=($COLLECTD_RRDTOOL_RPM5_64)
        elif [ "$arch" = "i386" ]; then
            is_supported=0
        else
            die "Architecture $arch not recognized."
        fi
    ;;
    RPM6_AUTO)
        os_type="rhel"
        os_version="6"
        inst_process="auto"
        if [ "$arch" = "x86_64" ]; then
            repopath="${CLOUDOPT_REPO_YUM}/${CLOUDOPT_REPO_PATH_RPM6_64}"
            if [ "$testing" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_TESTING_VERSION}"
            elif [ "$previous" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_PREVIOUS_VERSION}"
            else 
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_CURRENT_VERSION}"
            fi
            dep_packages=($XFSPROGS_RPM6_64)
            dep_packages+=($MONIT_5_1_1_RPM6_64)
            dep_packages+=($GPERFTOOLS_LIBS_RPM6_64)
            dep_packages+=($GOOGLE_PERFTOOLS_RPM6_64)
        elif [ "$arch" = "i386" ]; then
            is_supported=0
        else
            die "Architecture $arch not recognized."
        fi
    ;;
    RPM6_MANUAL)
        os_type="rhel"
        os_version="6"
        inst_process="manual"
        if [ "$arch" = "x86_64" ]; then
            repopath="${CLOUDOPT_REPO_YUM}/${CLOUDOPT_REPO_PATH_RPM6_64}"
            if [ "$testing" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_TESTING_VERSION}"
            elif [ "$previous" = "1" ]; then
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_PREVIOUS_VERSION}"
                mpkg="${CLOUDOPTIMIZER_PREVIOUS_RPM6_64_FILE}"
                wpkg="${CLOUDOPTIMIZER_WEBUI_PREVIOUS_RPM6_64_FILE}"
                tpkg="${CLOUDOPTIMIZER_TOOLS_PREVIOUS_RPM6_64_FILE}"
            else 
                is_supported=1
                supports_ver="${CLOUDOPTIMIZER_CURRENT_VERSION}"
                mpkg="${CLOUDOPTIMIZER_CURRENT_RPM6_64_FILE}"
                wpkg="${CLOUDOPTIMIZER_WEBUI_CURRENT_RPM6_64_FILE}"
                tpkg="${CLOUDOPTIMIZER_TOOLS_CURRENT_RPM6_64_FILE}"
            fi
            dep_packages=($XFSPROGS_RPM6_64)
            dep_packages+=($LIBNET_RPM6_64)
            dep_packages+=($LIBNET_DEVEL_RPM6_64)
            dep_packages+=($LIBNETFILTER_QUEUE_RPM6_64)
            dep_packages+=($LIBNETFILTER_QUEUE_SO_1_RPM6_64)
            dep_packages+=($LIBNFNETLINK_RPM6_64)
            dep_packages+=($LIBNFNETLINK_SO_0_RPM6_64)
            dep_packages+=($NC_RPM6_64)
            dep_packages+=($MONIT_5_1_1_RPM6_64)
            dep_packages+=($GPERFTOOLS_LIBS_RPM6_64)
            dep_packages+=($DEJAVU_FONTS_COMMON_RPM6_64)
            dep_packages+=($DEJAVU_LGC_SANS_MONO_FONTS_RPM6_64)
            dep_packages+=($DEJAVU_SANS_MONO_FONTS_RPM6_64)
            dep_packages+=($FONTPACKAGES_FILESYSTEM_RPM6_64)
            dep_packages+=($RRDTOOL_RPM6_64)
            dep_packages+=($COLLECTD_RRDTOOL_RPM6_64)
        elif [ "$arch" = "i386" ]; then
            is_supported=0
        else
            die "Architecture $arch not recognized."
        fi
    ;;
    NONE)
        message "CloudOpt has tested this version of Linux and determined that CloudOptimizer cannot be successfully installed at this time."
        message "If you require compatibility with this Linux version, please contact CloudOpt Support for assistance."
        die "Installation cancelled."
    ;;
esac
    
    
if [ "$is_supported" == "0" ]; then
    message "$distro $version $arch is not supported by this installer." error
    message "If this distribution is very similar to a supported version, you may be able to install with --distro and --version."
    die "Installation cancelled. Please contact CloudOpt Support for assistance."
elif [ "$remove" == "1" ]; then
    message "Preparing to remove CloudOptimizer..."
else
    message "This appears to be a supported operating system ($distro $version $arch ($ddesc))."
    message "CloudOptimizer version $supports_ver will be installed."
fi

(( $onlycheck )) && exit 0

# Determine if CloudOptimizer is already installed
command -v cloudoptimizer >>$log 2>&1 && installed=1 || installed=0

if [ "$installed" == "1" ]; then
    if [ "$force" == "1" ]; then
        message "CloudOptimizer is installed, but you chose to force, so we are ignoring it." warning
    fi
else
    message "There is no existing CloudOptimizer installation."
fi

# Determine if CloudOptimizer is running
if [ "$installed" == "1" ] && [ "$manifest" == "0" ]; then
    ps aux |grep "/usr/bin/cloudoptimizer" |grep -v "grep" >>$log 2>&1 && running=1 || running=0
    command -v cloudconfig >>$log 2>&1 && co_version=`service cloudoptimizer show-version |cut -d- -f1` >>$log 2>&1 || co_version="unknown"
    if [ "$running" == "1" ]; then
        message "CloudOptimizer version $co_version is installed and running.  If you continue, service will be interrupted." warning
        message " Continue? (y/n) " prompt force
        if !  yesno force
            then die "Install cancelled."
        fi
        message "Stopping cloudoptimizer-webui" action
        service cloudoptimizer-webui stop >>$log 2>&1 && message "OK" status || message "Could not stop cloudoptimizer-webui!  Continuing anyway." warning
        message "Stopping cloudoptimizer" action
        service cloudoptimizer stop >>$log 2>&1 && message "OK" status || message "Could not stop cloudoptimizer!  Continuing anyway." warning
    fi
fi

# Remove CloudOptimizer
if [ "$remove" == "1" ] && [ "$manifest" == "0" ]; then
    if [ "$os_type" == "ubuntu" ]; then
        remove_apt
    elif [ "$os_type" == "rhel" ]; then
        remove_yum
    else
        die "Unrecognized os_type ($os_type) when preparing to remove CloudOptimizer."
    fi
    exit 0
fi

# If installed, back up the existing configuration
if [ "$installed" == "1" ] && [ "$manifest" == "0" ]; then
    datestamp=`date +%y%m%d%H%M`
    message "There is an existing CloudOptimizer installation." warning
    message "Backing up the configuration to:"
    message "/etc/cloudoptimizer/cloudoptimizer.conf.installer.$datestamp" action
    if [ -f "/etc/cloudoptimizer.conf" ] && [ -d "/etc/cloudoptimizer" ]; then
        cp /etc/cloudoptimizer.conf /etc/cloudoptimizer/cloudoptimizer.conf.installer.$datestamp && message "OK" status
    elif [ -f "/etc/cloudoptimizer.conf" ]; then
        mkdir /etc/cloudoptimizer
        cp /etc/cloudoptimizer.conf /etc/cloudoptimizer/cloudoptimizer.conf.installer.$datestamp && message "OK" status
    elif [ "$force" == "0"]; then
        die "CloudOptimizer is installed but some files are missing.  Either correct or run again with --force."
    else
        message "CloudOptimizer is installed but some files are missing.  Ignoring because you chose to force." warning
    fi
fi

# Check to see if this is a downgrade

if [ "$installed" == "1" ] && [ "$co_version" != "unknown" ] && [ "$manifest" == "0" ]; then
    rver_d1=`echo "$co_version" |cut -d. -f1`
    rver_d2=`echo "$co_version" |cut -d. -f2`
    rver_d3=`echo "$co_version" |cut -d. -f3`
    iver_d1=`echo "$supports_ver" |cut -d. -f1`
    iver_d2=`echo "$supports_ver" |cut -d. -f2`
    iver_d3=`echo "$supports_ver" |cut -d. -f3`
    if [ "$rver_d1" -gt "$iver_d1" ]; then
        downgrade=1
        message "This is a downgrade from $co_version to $supports_ver." warning
        message " Are you sure that you want to downgrade? " prompt force
        if !  yesno force
            then die "Install cancelled."
        fi
    elif [ "$rver_d1" == "$iver_d1" ] && [ "$rver_d2" -gt "$iver_d2" ]; then
        downgrade=1
        message "This is a downgrade from $co_version to $supports_ver." warning
        message " Are you sure that you want to downgrade? " prompt force
        if !  yesno force
            then die "Install cancelled."
        fi
    elif [ "$rver_d1" == "$iver_d1" ] && [ "$rver_d2" == "$iver_d2" ] && [ "$rver_d3" -gt "$iver_d3" ]; then
        downgrade=1
        message "This is a downgrade from $co_version to $supports_ver." warning
        message " Are you sure that you want to downgrade? " prompt force
        if !  yesno force
            then die "Install cancelled."
        fi
    else
        downgrade=0
    fi
 fi


# Present EULA and handle EULA pre-acceptance
eula_file="/etc/cloudoptimizer/accept-eula.txt"

if [ -f "$eula_file" ]; then
    accepteula=1
fi
if [ "$accepteula" == "1" ]; then
    # Don't prompt for EULA in apt
    export DEBIAN_FRONTEND=noninteractive
    mkdir -p ${eula_file%/*}
    touch $eula_file
    if [ ! -f "$eula_file" ]; then
        die "ERROR: Could not write to ${eula_file}.  Exiting.."
    fi
else
    if [ "$local" == "1" ]; then
        message "Please go read the CloudOptimizer End User License Agreement at the following URL:" title
        message "http://kb.cloudopt.com/index.php/CloudOptimizer_End_User_License_Agreement"
    else
        message "We will now display the CloudOptimizer End User License Agreement."
        sleep 5
        download "http://kb.cloudopt.com/eula.txt"
        more eula.txt
    fi
    message "Do you accept the terms of the CloudOptimizer End User License Agreement? " prompt
    if ! yesno
        then die "You must accept the EULA.  Install cancelled."
    fi
    # Don't prompt for EULA in apt
    export DEBIAN_FRONTEND=noninteractive
    mkdir -p ${eula_file%/*}
    touch $eula_file
    if [ ! -f "$eula_file" ]; then
        die "ERROR: Could not write to ${eula_file}.  Exiting.."
    fi
fi

installer_lib="http://s3.amazonaws.com/cloudopt-installer/lib"

# Install extra repos for Ubuntu 12.x
if [ "$inst_process" == "manual" ]; then
    if [ "$distro" == "Ubuntu" ] && [ "$version" == "12.10" ]; then
        if [ ! -f /etc/apt/sources.list.d/ubuntu-quantal.list ]; then
            download http://kb.cloudopt.com/ubuntu-quantal.list
            message "Installing supplemental repos for Ubuntu 12.10 and dervivatives." action
            cp ubuntu-quantal.list /etc/apt/sources.list.d/ && message "OK" status || die "Couldn't install supplemental Ubuntu 12.10 repositories."
        fi
    elif [ "$distro" == "LinuxMint" ] && [ "$version" == "14" ]; then
        if [ ! -f /etc/apt/sources.list.d/ubuntu-quantal.list ]; then
            download http://kb.cloudopt.com/ubuntu-quantal.list
            message "Installing supplemental repos for Ubuntu 12.10 and dervivatives." action
            cp ubuntu-quantal.list /etc/apt/sources.list.d/ && message "OK" status || die "Couldn't install supplemental Ubuntu 12.10 repositories."
        fi
    fi
fi

# Set repo type (main or testing)
if [ $testing = 1 ]; then
    aptrepotype="testing"
    yumrepotype="Testing"
else
    aptrepotype="release"
    yumrepotype="Release"
fi

# Check for existing cloudopt repositories      
if [ "$local" == "0" ] && [ "$inst_process" == "auto" ]; then
    if [ "$os_type" == "rhel" ]; then
        repodir="/etc/yum.repos.d"
    elif [ "$os_type" == "ubuntu" ]; then
        repodir="/etc/apt/sources.list.d"
    else
        die "Unrecognized os_type ($os_type) when preparing to install repositories."
    fi
    existing_repos=(`find $repodir | egrep [Cc]loud[Oo]pt`)
    if [ ${#existing_repos[@]} != "0" ]; then
        message "Existing repo files found in $repodir.  These will be removed by the installer script." warning
        message " Continue? (y/n) " prompt
        if ! yesno
            then die "Install cancelled."
        fi
        for existing_repo in ${existing_repos[@]}; do
            if [ "$installed" = "1" ]; then
                repo_file=`basename ${existing_repo}`
                message "Backing up previous repo $repo_file to /etc/cloudoptimizer/$repo_file.installer.$datestamp" action 
                cp ${existing_repo} /etc/cloudoptimizer/$repo_file.installer.$datestamp && message "OK" status
            fi
            message "Removing old repo" action 
            rm ${existing_repo} && message "OK" status || die "Could not remove ${existing_repo}, exiting."
        done
        if [ $os_type == "rhel" ]; then
            message "Clearing yum caches" action
            rm -rf /var/cache/yum/$arch/$majorver/CloudOpt* && yum clean all >>$log && message "OK" status
        fi
    fi

    if [ $os_type == "rhel" ]; then
        # Where to get the repo definitions for the testing repos
        # This is not the actual testing repository
        if [ $testing = 1 ]; then
            repo="http://kb.cloudopt.com"
        else
            repo="http://yum.cloudopt.com"
        fi

        # EPEL check
        message "Checking for EPEL repository" action
        rpm --quiet -q epel-release >>$log 2>&1
        if [ "$?" != "0" ]; then
            message "The Extra Packages for Enterprise Linux repository is not installed. This is required to provide dependencies for CloudOptimizer." warning
            message " Would you like us to install it now? (y/n) " prompt
            if ! yesno
                then die "We require EPEL for installation.  Exiting."
            fi
            download "$installer_lib/epel-release-$os_version.noarch.rpm"
            message "Installing EPEL rpm" action
            rpm -i ${tempdir}/epel-release-${os_version}.noarch.rpm >>$log 2>&1 && message "OK" status || die "Could not install EPEL repo!  Exiting."
            rpm --quiet -q epel-release || die "Failed to install EPEL!  Exiting."
        fi

        # Install repo key
        download $repo/RPM-GPG-KEY-cloudopt.com
        message "Installing yum signing key" action
        rpm --import $tempdir/RPM-GPG-KEY-cloudopt.com  && message "OK" status || die "Could not import Cloudopt RPM GPG key! Exiting."
    
        # Install repo file
        download $repo/repo/Cloudopt-$yumrepotype.$os_version.repo
        message "Installing yum repository settings" action
        
        cp $tempdir/Cloudopt-$yumrepotype.$os_version.repo "$repodir" && message "OK" status || die "Could not copy repo file to "$repodir" ! Exiting."

    elif [ $os_type == "ubuntu" ]; then
        repo="http://apt.cloudopt.com"
        download $repo/keys/cloudopt-release-ubuntu.key
        message "Importing apt signing key" action
        apt-key add $tempdir/cloudopt-release-ubuntu.key >>$log 2>&1 && message "OK" status || die "Could not import Cloudopt APT GPG key! Exiting."
        download $repo/repo/cloudopt-$aptrepotype.`lsb_release -cs`.list
        message "Installing apt repository settings" action
        cp $tempdir/cloudopt-$aptrepotype.`lsb_release -cs`.list /etc/apt/sources.list.d/ && message "OK" status || die "Could not copy repo file to '/etc/apt/sources.list.d/' ! Exiting."
    fi
fi

# Update package cache before attempting to install anything
if [ "$os_type" == "ubuntu" ]; then
    message "Updating apt package cache (this may take a while)" action
    apt-get update >>$log 2>&1 && message "OK" status || message "Apt update failed.  We'll try to install anyway, but this might be a problem." warning
fi


if [ "$reposonly" == "0" ]; then
    message "Preparing to install CloudOptimizer"
    if [ "$manifest" == "1" ]; then
        message "Creating download script."
    elif [ "$local" == "1" ]; then
        message "Attempting a local install." warning
    fi

    if [ "$os_type" == "rhel" ] && [ "$manifest" == "0" ]; then
        if [ "$installed" == "1" ]; then
            message "We must remove the previous version before installing on RHEL variants." warning
            remove_yum
        fi
    elif [ "$os_type" == "ubuntu" ] && [ "$manifest" == "0" ] && [ "$downgrade" == "1" ]; then
        message "We must remove the previous version in order to downgrade." warning
        remove_apt
    fi
    
    
    if [ "$inst_type" == "RPM5_MANUAL" ] || [ "$inst_type" == "RPM6_MANUAL" ]; then
        install_deps_rpm
        install_rpm
    elif [ "$inst_type" == "DEB10_MANUAL" ] || [ "$inst_type" == "DEB12_MANUAL" ]; then
        install_deps_gdebi
        install_gdebi
    elif [ "$inst_type" == "RPM5_AUTO" ] ||  [ "$inst_type" == "RPM6_AUTO" ]; then
        install_deps_rpm
        install_yum
    elif [ "$inst_type" == "DEB10_AUTO" ] ||  [ "$inst_type" == "DEB12_AUTO" ]; then
        if [ "$previous" == "0" ]; then
            install_apt
        else
            install_gdebi
        fi
    else
        die "Couldn't determine an appropriate installer for $inst_type."
    fi
    
    download "http://kb.cloudopt.com/init.patch"
    message "Patching init script for additional distribution support" action
    patch /etc/init.d/cloudoptimizer init.patch --ignore-whitespace >>$log 2>&1 && message "OK" status || die "Couldn't patch init script.  Exiting."

    if [ "$password" == "1" ]; then
        if [ "$os_type" == "ubuntu" ]; then
            echo "uiadmin:$ui_password" | chpasswd && \
              echo;message "You can access the WebUI at https://localhost:8000/ and log in as uiadmin with the password you just set." || \
              message "Failed to set password.  CloudOptimizer WebUI remains disabled.  Enable it at any time by executing 'passwd uiadmin'." warning
        else
            echo "$ui_password" | passwd --stdin uiadmin  && \
              echo;message "You can access the WebUI at https://localhost:8000/ and log in as uiadmin with the password you just set." || \
              message "Failed to set password.  CloudOptimizer WebUI remains disabled.  Enable it at any time by executing 'passwd uiadmin'." warning
        fi
    elif [ "$skipyesno" != "1" ] && [ "$force" != "1" ]; then
        message " Do you want to enable the CloudOptimizer WebUI? " prompt
        if ! yesno; then
            message "CloudOptimizer WebUI remains disabled.  Enable it at any time by executing 'passwd uiadmin'."
        else
            message "Please set the WebUI password:"
            passwd uiadmin && \
              echo;message "You can access the WebUI at https://localhost:8000/ and log in as uiadmin with the password you just set." || \
              message "Failed to set password.  CloudOptimizer WebUI remains disabled.  Enable it at any time by executing 'passwd uiadmin'." warning
        fi
    else
        message "CloudOptimizer WebUI remains disabled.  Enable it at any time by executing 'passwd uiadmin'."
    fi
fi


echo
if [ "$reposonly" == "1" ]; then
    message "CloudOpt repos have been successfully installed." title
elif [ "$tarball" == "1" ]; then
    message "Cloudoptimizer has been successfully installed." title
elif [ "$manifest" == "1" ]; then
    echo "gzip cloudoptimizer-packages.tar" >>$dl_script
    echo "echo \"Created cloudoptimizer-packages.tar.gz.\"" >>$dl_script
    echo "echo \"Transfer this file to the system on which you want to install CloudOptimizer,\"" >>$dl_script
    echo "echo \"into the same directory as the installer.\"" >>$dl_script
    message "Download script created: $dl_script" title
    message "Transfer this script to a machine that is connected to the Internet and run it, using the following syntax:"
    message " bash cloudoptimizer-download.sh"
    message "It will download the necessary packages to a tar file, which you must then transfer to this system."
else
    message "Cloudoptimizer has been successfully installed." title
fi

if [ "$noclean" == "1" ]; then
    message "Skipping clean up."
else
    message "Cleaning up..."
    if [ -f $rundir/cloudoptimizer-packages.tar.gz ]; then
        for file in `tar -ztf $rundir/cloudoptimizer-packages.tar.gz`; do
            rm -f $rundir/$file
        done
    fi
    if [ -f "$tempdir" ] && [ "$tempdir" != "/" ]; then
        rm -rf "$tempdir"
    fi
    if [ -f "/etc/apt/sources.list.d/ubuntu-quantal.list" ]; then
        rm -f /etc/apt/sources.list.d/ubuntu-quantal.list
    fi
fi
exit 0

