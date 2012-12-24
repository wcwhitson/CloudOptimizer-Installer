#!/usr/bin/env bash
# cloudoptimizer-install.sh
# Copyright 2012 CloudOpt, Inc.
#
# This script detects the running distribution and installs cloudoptimizer for
# the user.


#############
# Constants #
#############

INSTALLER_VERSION="1.17"

CLOUDOPTIMIZER_PREVIOUS_VERSION="1.2.1"
CLOUDOPTIMIZER_CURRENT_VERSION="1.3.0"
CLOUDOPTIMIZER_TESTING_VERSION="1.3.0"

# CloudOpt Package Versions
CLOUDOPTIMIZER_RPM5_64_LABEL="1.3.0-222"
CLOUDOPTIMIZER_RPM6_64_LABEL="1.3.0-118"
CLOUDOPTIMIZER_RPM5_32_LABEL=""
CLOUDOPTIMIZER_RPM6_32_LABEL=""
CLOUDOPTIMIZER_DEB10_64_LABEL="1.3.0-229"
CLOUDOPTIMIZER_DEB12_64_LABEL="1.3.0-130"
CLOUDOPTIMIZER_DEB10_32_LABEL="1.1.7-26"
CLOUDOPTIMIZER_DEB12_32_LABEL="1.1.7-26"

CLOUDOPTIMIZER_PREV_RPM5_64_LABEL="1.2.1-120"
CLOUDOPTIMIZER_PREV_RPM6_64_LABEL="1.2.1-119"
CLOUDOPTIMIZER_PREV_RPM5_32_LABEL=""
CLOUDOPTIMIZER_PREV_RPM6_32_LABEL=""
CLOUDOPTIMIZER_PREV_DEB10_64_LABEL="1.2.1-124"
CLOUDOPTIMIZER_PREV_DEB12_64_LABEL="1.2.1-121"
CLOUDOPTIMIZER_PREV_DEB10_32_LABEL="1.1.7-26"
CLOUDOPTIMIZER_PREV_DEB12_32_LABEL="1.1.7-26"

CLOUDOPTIMIZER_TEST_RPM5_64_LABEL="1.3.0"
CLOUDOPTIMIZER_TEST_RPM6_64_LABEL="1.3.0"
CLOUDOPTIMIZER_TEST_DEB10_64_LABEL="1.3.0"
CLOUDOPTIMIZER_TEST_DEB12_64_LABEL="1.3.0"

# Other Packages
COLLECTD_4_10_3_RPM5_64="ftp://ftp.pbone.net/mirror/download.fedora.redhat.com/pub/fedora/epel/5/x86_64/collectd-4.10.3-1.el5.x86_64.rpm"
MONIT_5_1_1_RPM6_64="http://dl.fedoraproject.org/pub/epel/6/x86_64/monit-5.1.1-4.el6.x86_64.rpm"
MONIT_5_1_1_RPM5_64="http://yum.cloudopt.com/CentOS/x86_64/monit-5.1.1-1.el5.rf.x86_64.rpm"
XFSPROGS_RPM5_64="ftp://ftp.pbone.net/mirror/ftp.freshrpms.net/pub/freshrpms/pub/freshrpms/redhat/testing/EL5/xfs/x86_64/xfsprogs-2.9.4-4.el5/xfsprogs-2.9.4-4.el5.x86_64.rpm"
XFSPROGS_RPM6_64="ftp://ftp.pbone.net/mirror/ftp.centos.org/6.3/os/x86_64/Packages/xfsprogs-3.1.1-7.el6.x86_64.rpm"
LIBNETFILTER_QUEUE_RPM5_32="http://yum.cloudopt.com/CentOS/i386/libnetfilter_queue-1.0.0-1.el5.i386.rpm"
LIBNETFILTER_QUEUE_SO_1_RPM5_32="http://yum.cloudopt.com/CentOS/SRPMS/libnetfilter_queue-1.0.0-1.el5.src.rpm"
LIBNFNETLINK_SO_0_RPM5_32="http://yum.cloudopt.com/CentOS/i386/libnfnetlink-1.0.0-1.el5.i386.rpm"
LIBNET_RPM6_64="http://yum.cloudopt.com/CentOS-6/x86_64/libnet-1.1.5-2cnt6.x86_64.rpm"
LIBNET_DEVEL_RPM6_64="http://yum.cloudopt.com/CentOS-6/x86_64/libnet-devel-1.1.5-2cnt6.x86_64.rpm"
LIBNETFILTER_QUEUE_RPM6_64="http://yum.cloudopt.com/CentOS-6/x86_64/libnetfilter_queue-1.0.0-2cnt6.x86_64.rpm"
LIBNETFILTER_QUEUE_SO_1_RPM6_64="http://yum.cloudopt.com/CentOS-6/x86_64/libnetfilter_queue-devel-1.0.0-2cnt6.x86_64.rpm"
LIBNFNETLINK_RPM6_64="http://yum.cloudopt.com/CentOS-6/x86_64/libnfnetlink-1.0.0-2cnt6.x86_64.rpm"
LIBNFNETLINK_SO_0_RPM6_64="http://yum.cloudopt.com/CentOS-6/x86_64/libnfnetlink-devel-1.0.0-2cnt6.x86_64.rpm"
NC_RPM6_64="ftp://rpmfind.net/linux/centos/6.3/os/x86_64/Packages/nc-1.84-22.el6.x86_64.rpm"
GPERFTOOLS_LIBS_RPM6_64="ftp://fr2.rpmfind.net/linux/epel/6/x86_64/gperftools-libs-2.0-3.el6.2.x86_64.rpm"
GPERFTOOLS_LIBS_RPM5_64="http://puias.math.ias.edu/data/puias/computational/5/x86_64/gperftools-libs-2.0-3.el5.2.x86_64.rpm"
DEJAVU_FONTS_COMMON_RPM6_64="http://mirror.centos.org/centos/6/os/i386/Packages/dejavu-fonts-common-2.30-2.el6.noarch.rpm"
DEJAVU_LGC_SANS_MONO_FONTS_RPM6_64="http://dl.atrpms.net/el6-i386/atrpms/testing/dejavu-lgc-sans-mono-fonts-2.30-2.noarch.rpm"
DEJAVU_SANS_MONO_FONTS_RPM6_64="http://mirror.centos.org/centos/6/os/i386/Packages/dejavu-sans-mono-fonts-2.30-2.el6.noarch.rpm"
FONTPACKAGES_FILESYSTEM="http://mirror.centos.org/centos/6/os/i386/Packages/fontpackages-filesystem-1.41-1.1.el6.noarch.rpm"
RRDTOOL="http://mirror.centos.org/centos/6/os/x86_64/Packages/rrdtool-1.3.8-6.el6.x86_64.rpm"
COLLECTD_RRDTOOL_RPM6_64="http://dl.fedoraproject.org/pub/epel/6/x86_64/collectd-rrdtool-4.10.8-1.el6.x86_64.rpm"
LIBGOOGLE_PERFTOOLS0_DEB12_64="http://launchpadlibrarian.net/93406085/libgoogle-perftools0_1.7-1ubuntu1_amd64.deb"
LIBTCMALLOC_MINIMAL0_DEB12_64="http://launchpadlibrarian.net/93406083/libtcmalloc-minimal0_1.7-1ubuntu1_amd64.deb"
LIBUNWIND7_DEB12_64="http://launchpadlibrarian.net/83640348/libunwind7_0.99-0.3ubuntu1_amd64.deb"
GOOGLE_PERFTOOLS_RPM6_64="ftp://rpmfind.net/linux/epel/6/x86_64/gperftools-libs-2.0-3.el6.2.x86_64.rpm"

log="/var/log/cloudoptimizer-install.log"

rundir=`pwd "${BASH_SOURCE[0]}"`


#############
# Functions #
#############

# guessdist()
# Simple check to see if we are running on a supported version
guessdist() {
    command -v lsb_release >>$log && lsb="true" || lsb="false"

    if [ "$lsb" = "true" ]; then
        distro=`lsb_release -si`
        version=`lsb_release -sr`
    else
        issuelen=`head -n1 /etc/issue |wc -w`
        distro=`head -n1 /etc/issue |cut -d" " -f1`
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
    message "-a|--auto           Automatic installation: the same as using --accept-eula, --yes, --force, and --noupdate." nolog
    message "-c|--check          Check to see if installation is possible, but don't install any files." nolog
    message "-e|--accept-eula    Accept the CloudOptimizer end user license agreement (for automated installation)." nolog
    message "-f|--force          A stronger --yes, will bypass prompts for actions that may be destructive (for automated installation)." nolog
    message "-h|--help           Show this help screen." nolog
    message "-l|--local          Perform an install without connection to the Internet.  Package files must be located in the same directory as the script." nolog
    message "-m|--manifest       Generate a script that will download all the required packages on another system (for local install.)" nolog
    message "-n|--noupdate       Don't check for a more recent version of the installer (recommended for automated installation)." nolog
    message "-p|--previous       Install the previous version (not recommended unless advised by CloudOpt Support)." nolog
    message "-r|--reposonly      Only install the software repositories." nolog
    message "-s|--support        Collect diagnostic information in a file for CloudOpt support if this script failed." nolog
    message "-t|--tarball        Use a package archive created with --manifest for local installation." nolog
    message "-u|--remove         Remove CloudOptimizer but leave all cache and configuration files." nolog
    message "-y|--yes            Bypass most prompts, answering yes (for automated installation)." nolog
    message "-x|--purge          Remove CloudOptimizer and delete everything that is not removed by the package manager." nolog
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
        elif [ "$2" == "prompt" ]; then
            if [ "$skipyesno" == "0" ]; then
                echo -n -e "\033[1m${1}\033[0m" |cut -c $from_cut-$to_cut |tr -d '\n'
            fi
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
    apt-get -qqy install cloudoptimizer-tools=$cver >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer Tools! Exiting."
    message "Installing cloudoptimizer package" action
    apt-get -qqy install cloudoptimizer=$cver >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer! Exiting."
    message "Installing cloudoptimizer-webui package" action
    apt-get -qqy install cloudoptimizer-webui=$cver >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer WebUI! Exiting."
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
        message " Proceed? (y/n) " prompt
        if !  yesno force
            then die "Install cancelled."
        fi
        command -v cloudconfig && homedir=`cloudconfig get /config/home` || message "Couldn't determine home directory.  Continuing anyway.  You might need to do some manual cleanup." warning
        command -v cloudconfig && logdir=`cloudconfig get /config/log_dir` || message "Couldn't determine log directory.  Continuing anyway.  You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer-webui" action
        apt-get -qqy $action cloudoptimizer-webui >>$log && message "OK" status || message "Could not remove CloudOptimizer WebUI! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer" action
        apt-get -qqy $action cloudoptimizer >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer-tools" action
        apt-get -qqy $action cloudoptimizer-tools >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer Tools! You might need to do some manual cleanup." warning
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
        apt-get -qqy $action cloudoptimizer-webui >>$log && message "OK" status || message "Could not remove CloudOptimizer WebUI! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer" action
        apt-get -qqy $action cloudoptimizer >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer-tools" action
        apt-get -qqy $action cloudoptimizer-tools >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer Tools! You might need to do some manual cleanup." warning
    fi
}

install_yum() {
    message "Installing cloudoptimizer-tools package" action
    yum -q -y install cloudoptimizer-tools-$cver >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer Tools! Exiting."
    message "Installing cloudoptimizer package" action
    yum -q -y install cloudoptimizer-$cver >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer! Exiting."
    message "Installing cloudoptimizer-webui package" action
    yum -q -y install cloudoptimizer-webui-$cver >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer WebUI! Exiting."
}

remove_yum() {
    message " Remove CloudOptimizer? (y/n) " prompt
    if ! yesno
        then die "Failed to remove CloudOptimizer.  Exiting."
    fi
    message "Removing CloudOptimizer..."
    if [ "$purge" == "1" ]; then
        message "Purging will remove files that you have changed since installation." warning
        message " Proceed? (y/n) " prompt
        if !  yesno force
            then die "Install cancelled."
        fi
        command -v cloudconfig && homedir=`cloudconfig get /config/home` || message "Couldn't determine home directory.  Continuing anyway.  You might need to do some manual cleanup." warning
        command -v cloudconfig && logdir=`cloudconfig get /config/log_dir` || message "Couldn't determine log directory.  Continuing anyway.  You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer-webui" action
        yum -q -y remove cloudoptimizer-webui >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer WebUI! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer" action
        yum -q -y remove cloudoptimizer >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer-tools" action
        yum -q -y remove cloudoptimizer-tools >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer Tools! You might need to do some manual cleanup." warning
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
        else
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
        yum -q -y remove cloudoptimizer-webui >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer WebUI! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer" action
        yum -q -y remove cloudoptimizer >>$log 2>&1 && message "OK" status || message "Could not remove CloudOptimizer! You might need to do some manual cleanup." warning
        message "Removing cloudoptimizer-tools" action
        yum -q -y remove cloudoptimizer-tools >>$log 2>&1 && message "OK" message || die "Could not remove CloudOptimizer Tools! You might need to do some manual cleanup." warning
    fi
}

install_rpm() {
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
        # Install / obtain cloudoptimizer-tools
        if [ "$manifest" == "1" ]; then
            message "$averb cloudoptimizer-tools package" action
            echo "wget $repopath/$tpkg" >>$dl_script && echo "tar -rf cloudoptimizer-packages.tar $tpkg" >>$dl_script && message "OK" status || die "Could not write to script! Exiting."
        else
            download $rundir/$tpkg
            message "$averb cloudoptimizer-tools package" action
            rpm -q cloudoptimizer-tools >>$log 2>&1 || rpm -i $rundir/$tpkg >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer Tools ($tpkg)! Exiting."
        fi
        # Install / obtain cloudoptimizer
        if [ "$manifest" == "1" ]; then
            message "$averb cloudoptimizer package" action
            echo "wget $repopath/$mpkg" >>$dl_script && echo "tar -rf cloudoptimizer-packages.tar $mpkg" >>$dl_script && message "OK" status || die "Could not write to script! Exiting."
        else
            download $rundir/$mpkg
            message "$averb cloudoptimizer package" action
            rpm -q cloudoptimizer >>$log 2>&1 || rpm -i $rundir/$mpkg >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer ($mpkg)! Exiting."
        fi
        # Install / obtain cloudoptimizer-webui
        if [ "$manifest" == "1" ]; then
            message "$averb cloudoptimizer-webui package" action
            echo "wget $repopath/$wpkg" >>$dl_script && echo "tar -rf cloudoptimizer-packages.tar $wpkg" >>$dl_script && message "OK" status || die "Could not write to script! Exiting."
        else
            download $rundir/$wpkg
            message "$averb cloudoptimizer-webui package" action
            rpm -q cloudoptimizer-webui >>$log 2>&1 || rpm -i $rundir/$wpkg >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer WebUI ($wpkg)! Exiting."
        fi
    else
        message "Installing cloudoptimizer-tools package" action
        rpm -Uvh $repopath/$tpkg && message "OK" status || die "Could not install Cloudoptimizer Tools! Exiting."
        message "Installing cloudoptimizer package" action
        rpm -Uvh $repopath/$mpkg && message "OK" status || die "Could not install Cloudoptimizer! Exiting."
        message "Installing cloudoptimizer-webui package" action
        rpm -Uvh $repopath/$wpkg && message "OK" status || die "Could not install Cloudoptimizer WebUI! Exiting."
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
    if [ "$version" == "12.10" ] || [ "$version" == "13.04" ] || [ "$version" == "14" ]; then
        download $LIBTCMALLOC_MINIMAL0_DEB12_64
        gdebi --n --q `basename $LIBTCMALLOC_MINIMAL0_DEB12_64`
        download $LIBUNWIND7_DEB12_64
        gdebi --n --q `basename $LIBUNWIND7_DEB12_64`
        download $LIBGOOGLE_PERFTOOLS0_DEB12_64
        gdebi --n --q `basename $LIBGOOGLE_PERFTOOLS0_DEB12_64`
    fi
    message "Downloading CloudOptimizer packages..."
    download $repopath/$tpkg && download $repopath/$mpkg && download $repopath/$wpkg
    message "Installing cloudoptimizer-tools package" action
    gdebi --n --q $tpkg >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer Tools! Exiting."
    message "Installing cloudoptimizer package" action
    gdebi --n --q $mpkg >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer! Exiting."
    if [ "$version" != "12.10" ]; then
        message "Installing cloudoptimizer-webui package" action
        gdebi --n --q $wpkg >>$log 2>&1 && message "OK" status || die "Could not install Cloudoptimizer WebUI! Exiting."
    fi
}


##################
#   Main Script  #
##################

message "CloudOptimizer Linux Client Installer version $INSTALLER_VERSION" title

# Check for bash
(( true )) && message "This script requires bash! Don't use sh!" error && exit 1

# Require superuser privileges
id | grep "uid=0(" >>$log
if [ "$?" != "0" ]; then
    die "The Cloudoptimizer install script must be run as root" error
fi

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

while [ "$1" != "" ]; do
    case $1 in
        --help|-h)
            showhelp
            exit 0
        ;;
        --auto|-a)
            accepteula=1
            force=1
            skipyesno=1
            noupdate=1
        ;;
        --accept-eula|-e)
            accepteula=1
        ;;
        --check|-c)
            skipyesno=1
            onlycheck=1
        ;;
        --force|-f)
            force=1
        ;;
        --yes|-y)
            skipyesno=1
        ;;
        --noupdate|-n)
            noupdate=1
        ;;
        --testing)
            testing=1
        ;;
        --reposonly|-r)
            reposonly=1
        ;;
        --previous|-p)
            previous=1
        ;;
        --remove|-u)
            remove=1
        ;;
        --manifest|-m)
            noupdate=1
            local=1
            manifest=1
            dl_script="$rundir/cloudoptimizer-download.sh"
            echo "#!/bin/sh" >$dl_script
            echo "tar -c -T /dev/null -f cloudoptimizer-packages.tar" >>$dl_script
        ;;
        --purge|-x)
            remove=1
            purge=1
        ;;
        --local|-l)
            noupdate=1
            local=1
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
        --support|-s)
            tar -cz $TMPDIR/.cloudopt-* $log > $TMPDIR/co-support.tgz \
              && message "${TMPDIR}/co-support.tgz file created. E-mail this to support@cloudopt.com" \
              || message "Something broke, e-mail support@cloudopt.com for help!" error
            exit 0
        ;;
        *)
            message "Unrecognized flag."
            show help
            exit 0
        ;;
    esac
    shift
done

# Check to make sure installer is up to date
if [ $noupdate != 1 ]; then
    download "http://kb.cloudopt.com/instver.txt" silent
    instver=`cat instver.txt`
    if [ $instver != $INSTALLER_VERSION ]; then
      message "This installer is out of date." error
      die "Please download a new copy at http://kb.cloudopt.com/cloudoptimizer-install.sh.gz or run again with --noupdate."
    else
      message "Installer version $INSTALLER_VERSION is up to date."
    fi
fi

# Guess the distro and version
guessdist

# Handle x86_64 vs amd64
if [ "$arch" == "x86_64" ]; then
     parch="amd64"
else
     parch="$arch"
fi

# Find the right version to install
is_supported=0
case $distro in
    Ubuntu)
        os_type="ubuntu"
        case $version in
            10.04|11.04|11.10)
                if [ $arch = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_DEB10_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_DEB10_64_LABEL
                    else 
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_DEB10_64_LABEL
                    fi
                elif [ "$arch" = "i386" ]; then
                    is_supported=1
                    supports_ver="1.1.7"
                    cver=$CLOUDOPTIMIZER_DEB10_32_LABEL
                else
		            is_supported=0
                fi
            ;;
            12.04|12.10)
                if [ "$version" == "12.10" ]; then
                    message "The CloudOptimizer WebUI is not currently supported on this version of Linux." warning
                    message " Continue with installation? (y/n) " prompt
                    if ! yesno
                        then die "Install cancelled."
                    fi
                fi
                if [ "$arch" = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_DEB12_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_DEB12_64_LABEL
                    else
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_DEB12_64_LABEL
                    fi
                elif [ "$arch" = "i386" ]; then
                    is_supported=1
                    supports_ver="1.1.7"
                    cver=$CLOUDOPTIMIZER_DEB12_32_LABEL
                else
                    is_supported=0
                fi
            ;;
            *)
                is_supported=0
            ;;
            10.10)
                die "CloudOpt has tested Ubuntu version 10.10 and determined that CloudOptimizer cannot be installed successfully at this time."
            ;;
            13.04)
                die "CloudOpt has tested Ubuntu 13.03 and determined that CloudOptimizer cannot be installed successfully at this time.  We are working it."
            ;; 
        esac
        mpkg="cloudoptimizer_${cver}_${parch}.deb"
        wpkg="cloudoptimizer-webui_${cver}_${parch}.deb"
        tpkg="cloudoptimizer-tools_${cver}_${parch}.deb"
    ;;
    CentOS)
        os_type="rhel"
        case $version in
            5.4|5.5|5.6|5.7|5.8)
                if [ "$arch" = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then 
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_RPM5_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_RPM5_64_LABEL
                    else
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_RPM5_64_LABEL
                    fi
                    dep_packages=($LIBNET_RPM5_64)
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
                    dep_packages+=($COLLECTD_RRDTOOL_RPM5_64)
                elif [ "$arch" = "i386" ]; then
                    is_supported=0
                    supports_ver="1.1.5"
                    cver=$CLOUDOPTIMIZER_RPM5_32_LABEL
                else
                    is_supported=0
                fi
            ;;
            6.0|6.2|6.3)
                if [ "$arch" = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_RPM6_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_RPM6_64_LABEL
                    else
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_RPM6_64_LABEL
                    fi
                    dep_packages=($LIBNET_RPM6_64)
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
                else
                    is_supported=0
                fi
            ;;

            *)
                is_supported=0
            ;;
        esac
        mpkg="cloudoptimizer-${cver}.${arch}.rpm"
        wpkg="cloudoptimizer-webui-${cver}.${arch}.rpm"
        tpkg="cloudoptimizer-tools-${cver}.${arch}.rpm"
    ;;
    Scientific)
        os_type="rhel"
        case $version in
            5.8)
                if [ "$arch" = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_RPM5_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1 
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_RPM5_64_LABEL
                    else
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_RPM5_64_LABEL
                    fi
                elif [ "$arch" = "i386" ]; then
                    is_supported=0
                    supports_ver="1.1.5"
                    cver=$CLOUDOPTIMIZER_RPM5_32_LABEL
                else
                    is_supported=0
                fi
            ;;
            6.2|6.3)
                if [ "$arch" = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_RPM6_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_RPM6_64_LABEL
                    else
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_RPM6_64_LABEL
                    fi
                else
                    is_supported=0
                fi
            ;;

            *)
                is_supported=0
            ;;
        esac
        mpkg="cloudoptimizer-${cver}.${arch}.rpm"
        wpkg="cloudoptimizer-webui-${cver}.${arch}.rpm"
        tpkg="cloudoptimizer-tools_${cver}.${arch}.rpm"
    ;;
    Amazon)
        os_type="rhel"
        case $version in
            2011.09|2012.03|2012.09)
                if [ "$arch" = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_RPM6_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_RPM6_64_LABEL
                    else
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_RPM6_64_LABEL
                    fi
                elif [ "$arch" = "i386" ]; then
                    is_supported=0
                else
                    is_supported=0
                fi
            ;;
            *)
                is_supported=0
            ;;
        esac
        mpkg="cloudoptimizer-${cver}.${arch}.rpm"
        wpkg="cloudoptimizer-webui-${cver}.${arch}.rpm"
        tpkg="cloudoptimizer-tools-${cver}.${arch}.rpm"
    ;;
    Oracle)
        os_type="rhel"
        case $version in
            5.6|5.8)
                if [ "$arch" = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_RPM5_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_RPM5_64_LABEL
                    else
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_RPM5_64_LABEL
                    fi
                elif [ "$arch" = "i386" ]; then
                    is_supported=0
                    supports_ver="1.1.5"
                    cver=$CLOUDOPTIMIZER_RPM5_32_LABEL
                else
                    is_supported=0
                fi
            ;;
            6.3)
                if [ "$arch" = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_RPM6_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_RPM6_64_LABEL
                    else
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_RPM6_64_LABEL
                    fi
                else
                    is_supported=0
                fi
            ;;

            *)
                is_supported=0
            ;;
        esac
        mpkg="cloudoptimizer-${cver}.${arch}.rpm"
        wpkg="cloudoptimizer-webui-${cver}.${arch}.rpm"
        tpkg="cloudoptimizer-tools_${cver}.${arch}.rpm"
    ;; 
    RedHatEnterpriseServer)
        os_type="rhel"
        case $version in
            5.4|5.5|5.6|5.7|5.8)
                if [ "$arch" = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_RPM5_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_RPM5_64_LABEL
                    else
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_RPM5_64_LABEL
                    fi
                elif [ "$arch" = "i386" ]; then
                    is_supported=0
                    supports_ver="1.1.5"
                    cver=$CLOUDOPTIMIZER_RPM5_32_LABEL
                else
                    is_supported=0
                fi
            ;;
            6.0|6.1|6.2|6.3)
                if [ "$arch" = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_RPM6_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_RPM6_64_LABEL
                    else
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_RPM6_64_LABEL
                    fi 
                else
                    is_supported=0
                fi
            ;;

            *)
                is_supported=0
            ;;
        esac
        mpkg="cloudoptimizer-${cver}.${arch}.rpm"
        wpkg="cloudoptimizer-webui-${cver}.${arch}.rpm"
        tpkg="cloudoptimizer-tools-${cver}.${arch}.rpm"
    ;;
    Fedora)
        os_type="rhel"
        case $version in
            13|14|15|16|17)
                if [ "$arch" = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_RPM6_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_RPM6_64_LABEL
                    else
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_RPM6_64_LABEL
                    fi
                else
                    is_supported=0
                fi
            ;;

            *)
                is_supported=0
            ;;
        esac
        mpkg="cloudoptimizer-${cver}.${arch}.rpm"
        wpkg="cloudoptimizer-webui-${cver}.${arch}.rpm"
        tpkg="cloudoptimizer-tools_${cver}.${arch}.rpm"
    ;;
    Mageia)
        os_type="rhel"
        case $version in
            2|3)
                die "CloudOpt has tested Mageia versions 2 and 3 and determined that CloudOptimizer cannot be installed successfully at this time." 
            ;;

            *)
                is_supported=0
            ;;
        esac
    ;;
    Debian)
        os_type="ubuntu"
        case $version in
            6.0|6.0.1|6.0.2|6.0.3|6.0.4|6.0.5|6.0.6)
                if [ "$arch" = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_DEB10_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_DEB10_64_LABEL
                    else
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_DEB10_64_LABEL
                    fi 
                elif [ "$arch" = "i386" ]; then
                    is_supported=1
                    supports_ver="1.1.7"
                    cver=$CLOUDOPTIMIZER_DEB10_32_LABEL
                else
                    is_supported=0
                fi
            ;;
            *)
                is_supported=0
            ;;
        esac
        mpkg="cloudoptimizer_${cver}_${parch}.deb"
        wpkg="cloudoptimizer-webui_${cver}_${parch}.deb"
        tpkg="cloudoptimizer-tools_${cver}_${parch}.deb"
    ;;
    LinuxMint)
        os_type="ubuntu"
        case $version in
            13|14)
                if [ "$arch" = "x86_64" ]; then
                    if [ "$testing" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_TESTING_VERSION
                        cver=$CLOUDOPTIMIZER_TEST_DEB10_64_LABEL
                    elif [ "$previous" = "1" ]; then
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_PREVIOUS_VERSION
                        cver=$CLOUDOPTIMIZER_PREV_DEB10_64_LABEL
                    else
                        is_supported=1
                        supports_ver=$CLOUDOPTIMIZER_CURRENT_VERSION
                        cver=$CLOUDOPTIMIZER_DEB10_64_LABEL
                    fi
                elif [ "$arch" = "i386" ]; then
                    is_supported=1
                    supports_ver="1.1.7"
                    cver=$CLOUDOPTIMIZER_DEB10_32_LABEL
                else
                    is_supported=0
                fi
            ;;
            *)
                is_supported=0
            ;;
        esac
        mpkg="cloudoptimizer_${cver}_${parch}.deb"
        wpkg="cloudoptimizer-webui_${cver}_${parch}.deb"
        tpkg="cloudoptimizer-tools_${cver}_${parch}.deb"
    ;;
esac

if [ "$is_supported" == "0" ]; then
    message "$distro $version $arch is not supported by this installer." error
    die "Please contact CloudOpt Support for assistance."
elif [ "$remove" == "1" ]; then
    message "Preparing to remove CloudOptimizer..."
else
    message "This appears to be a supported operating system ($distro $version $arch)."
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
    message "No existing CloudOptimizer installation."
fi

# Determine if CloudOptimizer is running
if [ "$installed" == "1" ] && [ "$manifest" == "0" ]; then
    ps aux |grep "/usr/bin/cloudoptimizer" |grep -v "grep" >>$log 2>&1 && running=1 || running=0
    command -v cloudconfig >>$log 2>&1 && co_version=`service cloudoptimizer show-version |cut -d- -f1` || co_version="unknown"
    if [ "$running" == "1" ]; then
        message "CloudOptimizer version $co_version is installed and running.  If you continue, service will be interrupted." warning
        message " Continue? (y/n) " prompt
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
    else
        remove_yum
    fi
    exit 0
fi

# If installed, back up the existing configuration
if [ "$installed" == "1" ] && [ "$manifest" == "0" ]; then
    datestamp=`date +%y%m%d%H%M`
    message "There is an existing CloudOptimizer installation.  Backing up the configuration to:"
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
        message " Are you sure that you want to downgrade? " prompt
        if !  yesno force
            then die "Install cancelled."
        fi
    elif [ "$rver_d1" == "$iver_d1" ] && [ "$rver_d2" -gt "$iver_d2" ]; then
        downgrade=1
        message "This is a downgrade from $co_version to $supports_ver." warning
        message " Are you sure that you want to downgrade? " prompt
        if !  yesno force
            then die "Install cancelled."
        fi
    elif [ "$rver_d1" == "$iver_d1" ] && [ "$rver_d2" == "$iver_d2" ] && [ "$rver_d3" -gt "$iver_d3" ]; then
        downgrade=1
        message "This is a downgrade from $co_version to $supports_ver." warning
        message " Are you sure that you want to downgrade? " prompt
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
if [ "$accepteula" = 1 ]; then
    export DEBIAN_FRONTEND=noninteractive # No apt prompt for EULA
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
    export DEBIAN_FRONTEND=noninteractive # No apt prompt for EULA
    mkdir -p ${eula_file%/*}
    touch $eula_file
    if [ ! -f "$eula_file" ]; then
        die "ERROR: Could not write to ${eula_file}.  Exiting.."
    fi
fi

installer_lib="http://s3.amazonaws.com/cloudopt-installer/lib"

if [ $testing = 1 ]; then
    aptrepotype="testing"
    yumrepotype="Testing"
else
    aptrepotype="release"
    yumrepotype="Release"
fi

# Check for existing cloudopt repositories
if [ "$local" == "0" ]; then
    if [ "$distro" == "Mageia" ]; then
        repodir="/etc/yum/repos.d"
    elif [ $os_type == "rhel" ]; then
        repodir="/etc/yum.repos.d"
    elif [ $os_type == "ubuntu" ]; then
        repodir="/etc/apt/sources.list.d"
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
        if [ $testing = 1 ]; then
            repo="http://kb.cloudopt.com"
        else
            repo="http://yum.cloudopt.com"
        fi

        # Set EPEL version for Amazon and Fedora Linux
        if [ $majorver = "2012" ] || [ "$majorver" == "2011" ] || [ "$distro" == "Fedora" ] || [ "$distro" == "Mageia" ]; then
            os_version=6
        fi

        # EPEL check
        message "Checking for EPEL repository" action
        rpm --quiet -q epel-release >>$log 2&>1 || [ "$distro" == "Fedora" ] || [ "$distro" == "Mageia" ]
        if [ "$?" != "0" ]; then
            message "The Extra Packages for Enterprise Linux repository is not installed on your machine. This is required to provide dependencies for CloudOptimizer." warning
            message " Would you like us to install it now? (y/n) " prompt
            if ! yesno
                then die "We require EPEL for installation.  Exiting."
            fi
            if [ "$distro" == "RedHatEnterpriseLinux" ] && [ "$version" == "5.5" ]; then
                message "Installing EPEL rpm" action
                rpm -Uvh ftp://ftp.pbone.net/mirror/download.fedora.redhat.com/pub/fedora/epel/5/x86_64/epel-release-5-4.noarch.rpm && message "OK" status || die "Could not install EPEL repo!  Exiting."
            else
                download "$installer_lib/epel-release-$os_version.noarch.rpm"
                message "Installing EPEL rpm" action
                yum -y localinstall ${tempdir}/epel-release-$os_version.noarch.rpm >>$log 2&>1 && message "OK" status || die "Could not install EPEL repo!  Exiting."
                rpm --quiet -q epel-release || die "Failed to install EPEL!  Exiting."
            fi
        fi

        # Install repo key
        download $repo/RPM-GPG-KEY-cloudopt.com
        message "Installing CentOS signing key" action
        rpm --import $tempdir/RPM-GPG-KEY-cloudopt.com  && message "OK" status || die "Could not import Cloudopt RPM GPG key! Exiting."
    
        # Install repo file
        download $repo/repo/Cloudopt-$yumrepotype.$os_version.repo
        message "Installing CentOS repository settings" action
        
        cp $tempdir/Cloudopt-$yumrepotype.$os_version.repo "$repodir" && message "OK" status || die "Could not copy repo file to "$repodir" ! Exiting."

    elif [ $os_type == "ubuntu" ] && [ $distro != "Debian" ] && [ "$distro" != "LinuxMint" ]; then
        if [ "$version" != "11.10" ] && [ "$version" != "12.10" ] && [ "$version" != "13.04" ]; then
            repo="http://apt.cloudopt.com"
            download $repo/keys/cloudopt-release-ubuntu.key
            message "Importing Ubuntu signing key" action
            apt-key add $tempdir/cloudopt-release-ubuntu.key >>$log 2&>1 && message "OK" status || die "Could not import Cloudopt APT GPG key! Exiting."
            download $repo/repo/cloudopt-$aptrepotype.`lsb_release -cs`.list
            message "Installing Ubuntu repository settings" action
            cp $tempdir/cloudopt-$aptrepotype.`lsb_release -cs`.list /etc/apt/sources.list.d/ && message "OK" status || die "Could not copy repo file to '/etc/apt/sources.list.d/' ! Exiting."
            message "Updating APT package index (this may take a while)" action
            apt-get -qq update && message "OK" status || die "Could not update repository data! Exiting."
        fi
    fi
fi

if [ "$reposonly" == "0" ]; then
    message "Installing CloudOptimizer"
    if [ "$manifest" == "1" ]; then
        message "Creating download script."
    elif [ "$local" == "1" ]; then
        message "Attempting a local install." warning
        rpmflags="-i"
    else
        rpmflags="-Uvh"
    fi
    if [ $os_type == "rhel" ]; then
        if [ "$manifest" == "0" ] && [ "$installed" == "1" ] || [ "$downgrade" == "1" ]; then
            message "We must remove the previous version before installing on RHEL variants." warning
            remove_yum
        fi
        if [ "$local" == "1" ]; then
            message "Installing dependencies locally"
            if [ $distro = "RedHatEnterpriseServer" ] || [ "$distro" == "Oracle" ]; then
                rpm -q xfsprogs >>$log 2>&1 && xfsprogs=1 || xfsprogs=0
                if [ "$xfsprogs" = "0" ]; then
                    message "Installing xfsprogs" action
                    if [ $majorver = "5" ]; then
                        download `basename $XFSPROGS_RPM5_64`
                        rpm $rpmflags `basename $XFSPROGS_RPM5_64` >>$log 2>&1 && message "OK" status || die "Could not install xfsprogs!  Exiting."
                    elif [ $majorver = "6" ]; then
                        download `basename $XFSPROGS_RPM6_64`
                        rpm $rpmflags `basename $XFSPROGS_RPM6_64` >>$log 2>&1 && message "OK" status || die "Could not install xfsprogs!  Exiting."
                    fi
                fi
            fi
            if [ $distro = "Amazon" ] || [ "$distro" == "Fedora" ]; then
                rpm -q monit >>$log 2>&1 && monit=1 || monit=0
                if [ "$monit" = "0" ]; then
                    message "Installing monit" action
                    download `basename $MONIT_5_1_1_RPM6_64`
                    rpm $rpmflags `basename $MONIT_5_1_1_RPM6_64` >>$log 2>&1 && message "OK" status || die "Could not install monit!  Exiting."
                fi
            fi
            if [ "$distro" == "Fedora" ]; then
                if [ "$version" == "13" ] || [ "$version" == "14" ] || [ "$version" == "15" ]; then
                    message "Installing $GOOGLE_PERFTOOLS_RPM6_64" action
                    yum -y localinstall --nogpgcheck $GOOGLE_PERFTOOLS_RPM6_64 && message "OK" status || die "Could not install `basename $GOOGLE_PERFTOOLS_RPM6_64`.  Exiting."
                fi
            fi
            if [ $majorver = "5" ]; then
                rpm -q collectd >>$log 2>&1 && collectd=1 || collectd=0
                if [ "$collectd" = "0" ]; then
                    message "Installing collectd" action
                    download `basename $COLLECTD_4_10_3_RPM5_64`
                    rpm $rpmflags `basename $COLLECTD_4_10_3_RPM5_64` >>$log 2>&1 && message "OK" status || die "Could not install collectd!  Exiting."
                fi
            fi
        fi
        if [ $arch = "x86_64" ]; then
            if [ $majorver = "5" ]; then
                repopath="http://yum.cloudopt.com/CentOS/x86_64"
            else
                repopath="http://yum.cloudopt.com/CentOS-6/x86_64"
            fi
            if [ "$local" == "1" ]; then
                install_rpm
            else
                install_yum
            fi
        elif [ $arch = "i386" ]; then
            repopath="http://yum.cloudopt.com/CentOS/i386"
            yum install python26
            rpm $rpmflags $LIBNETFILTER_QUEUE_RPM5_32
            rpm $rpmflags $LIBNETFILTER_QUEUE_SO_1_RPM5_32
            rpm $rpmflags $LIBNFNETLINK_SO_0_RPM5_32
            rpm $rpmflags $MONIT_5_1_1_RPM6_64
            install_rpm
        fi
        if [ "$distro" == "Scientific" ]; then
            message "Patching init script for Scientific Linux" action
            download "http://kb.cloudopt.com/sci-init.patch" && patch /etc/init.d/cloudoptimizer sci-init.patch && message "OK" status || die "Couldn't patch init script.  Exiting."
        fi
        if [ "$distro" == "Oracle" ]; then
            message "Patching init script for Oracle Linux" action
            download "http://kb.cloudopt.com/ora-init.patch" && patch /etc/init.d/cloudoptimizer ora-init.patch && message "OK" status || die "Couldn't patch init script.  Exiting."
        fi
        if [ "$distro" == "Fedora" ]; then
            message "Patching init script for Fedora Linux" action
            download "http://kb.cloudopt.com/fed-init.patch" && patch /etc/init.d/cloudoptimizer fed-init.patch && message "OK" status || die "Couldn't patch init script.  Exiting."
        fi
        if [ "$distro" == "Amazon" ]; then
            message "Patching init script for Amazon Linux" action
            download "http://kb.cloudopt.com/aws-init.patch" && patch /etc/init.d/cloudoptimizer aws-init.patch && message "OK" status || die "Couldn't patch init script.  Exiting."
        fi
    elif [ $os_type == "ubuntu" ]; then
        message "Updating apt cache (this make take a while)" action
        apt-get update >>$log 2>&1 && message "OK" status || message "Apt update failed.  We'll try to install anyway, but this might be a problem." warning
        if [ "$downgrade" == "1" ]; then
            message "We must remove the previous version in order to downgrade with apt." warning
            remove_apt
        fi
        if [ $distro = "Ubuntu" ]; then
            if [ $arch = "x86_64" ]; then
                if [ "$previous" == "1" ] || [ "$version" == "11.10" ] || [ "$version" == "12.10" ] || [ "$version" == "13.04" ]; then
                    repopath="http://apt.cloudopt.com/ubuntu/pool/main/c/cloudoptimizer"
                    if [ "$local" == "1" ]; then
                        install_dpkg
                    else
                        install_gdebi
                    fi
                else
                    repopath="http://apt.cloudopt.com/ubuntu/pool/main/c/cloudoptimizer"
                    if [ "$local" == "1" ]; then
                        install_dpkg
                    else
                        install_apt
                    fi
                fi
            elif [ $arch = "i386" ]; then
                repopath="http://apt.cloudopt.com/ubuntu/pool/main/c/cloudoptimizer"
                install_gdebi
            fi
        elif [ $distro = "Debian" ]; then
            repopath="http://apt.cloudopt.com/ubuntu/pool/main/c/cloudoptimizer"
            install_gdebi
        fi
    fi
    if [ "$distro" == "LinuxMint" ]; then
        message "Patching init script for Mint Linux" action
        download "http://kb.cloudopt.com/mint-init.patch" && patch /etc/init.d/cloudoptimizer mint-init.patch && message "OK" status || die "Couldn't patch init script.  Exiting."
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
message "Cleaning up..."
if [ -f $rundir/cloudoptimizer-packages.tar.gz ]; then
    for file in `tar -ztf $rundir/cloudoptimizer-packages.tar.gz`; do
        rm -f $rundir/$file
    done
fi
if [ -f "$tempdir" ] && [ "$tempdir" != "/" ]; then
    rm -rf "$tempdir"
fi
exit 0

