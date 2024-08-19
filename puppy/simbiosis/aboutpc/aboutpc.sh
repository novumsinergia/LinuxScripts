#!/bin/bash

#i18n nilsonmorales
#l10n nilsonmorales
export TEXTDOMAIN=
export OUTPUT_CHARSET=UTF-8
. /etc/DISTRO_SPECS
HERE="$(dirname "$(readlink -f "$0")")"
VERSION="FOSSAPUP64 F96CE-4"
OS="F96CE_XFCE_FUSILLI"
name=`uname -s`
arch=`uname -m`
hostname=`hostname`
#OS=`uname -o`
newname=`source /etc/DISTRO_SPECS && echo "$DISTRO_NAME"`
user=`whoami`
ver=`uname -r`
shell=`echo $SHELL`
cpu=$(awk -F':' '/model name/{ print $2 }' /proc/cpuinfo | head -n 1 | tr -s " " | sed 's/^ //');
uptime=`uptime`
Memory=`free -m | awk 'NR==2{printf "%s/%sMB  (%.2f%) In use\n", $3,$2,$3*100/$2 }'`
wm=`wmctrl -m | grep "Name:" | awk '{print $2}'`
disk=`df -h | awk '$NF=="/"{printf "%d/%dGB  (%s) In use\n", $3,$2,$5}'`
thunar=`thunar -V| awk 'NR==1 {print $2; exit}'`
glibc=`ldd --version | awk 'NR==1 {print $3, $5; exit}'`
OpenGl=`glxinfo | awk -F': ' '/OpenGL version/ {print $2}'`
computer=`dmidecode -t system | grep -E 'Manufacturer|Product Name' | awk -F': ' '{print $2}'`
mtype=`dmidecode -t memory | awk '/Type:/ && !/Correction/ {if ($2 != "Unknown") print $2}' | sort -u`
mfreq=`dmidecode -t memory | awk '/Speed:/ && !/Memory/ {print $2 " MHz"}' | sort -u`
verificar_disco=`if [ "$(cat /sys/block/sda/queue/rotational)" = 0 ] && [ -d "/sys/class/nvme" ]; then
    echo "NVMe."
elif [ "$(cat /sys/block/sda/queue/rotational)" = 0 ] && [ ! -d "/sys/class/nvme" ]; then
    echo "SSD."
else
    echo "HDD."
fi`
diskstatus=`hdsentinel -nodevs /dev/sdb -dev /dev/sda | grep -E 'HDD Model ID'`
diskstatus2=`hdsentinel -nodevs /dev/sdb -dev /dev/sda | grep -E 'Health'`
#psock=$(dmidecode -t processor | awk '/Socket Designation:/ {print $3}'; [[ $(dmidecode -s chassis-type) != *"Laptop"* ]] && echo "$psock")
psock=`dmidecode -t processor | awk -F ': ' '/Socket Designation/ {print $2}'`
hdcapacity=`echo "$(hdsentinel -nodevs /dev/sdb -dev /dev/sda -solid -size | awk '{print $NF}') / 1024" | bc`
Tpart=`fdisk -l /dev/sda | grep -q "gpt" && echo "GPT" || echo "MBR"`

export ABOUT='
<window title="About this computer" resizable="false" icon-name="computer">
<vbox>
    <frame>
    	        <text use-markup="True" width-chars="20">
        <label>"<span color='"'#b42900'"'><b> '$DISTRO_NAME'  '$DISTRO_COMPAT_VERSION'</b></span>"</label>
      </text>
      <pixmap>
      <input file>'"/usr/share/pixmaps/puppy-white.svg"'</input>
	  </pixmap>
	             <text>
        <label>**************************************************</label>
              </text>
	      	        <text use-markup="True" width-chars="20">
        <label>"<span color='"'yellow'"'><b>SOFTWARE</b></span>"</label>
      </text>

          <text use-markup="True" width-chars="30">
        <label>"<b>'$(gettext 'Desktop Version:')'</b> '"$thunar"'"</label>
      </text>
                  <text use-markup="True" width-chars="30">
        <label>"<b>'$(gettext 'Kernel:')'</b> '"$ver"'"</label>
      </text>
                        <text use-markup="True" width-chars="30">
        <label>"<b>'$(gettext 'Glibc:')'</b> '"$glibc"'"</label>
      </text>
                              <text use-markup="True" width-chars="30">
        <label>"<b>'$(gettext 'OpenGL:')'</b> '"$OpenGl"'"</label>
      </text>
      <text use-markup="True" width-chars="30">
        <label>"<b>'$(gettext 'Distro Version:')'</b> '"$DISTRO_VERSION"'"</label>
      </text>
       <text use-markup="True" width-chars="50">
        <label>'$(gettext '"'"<b>Windows Manager: </b>$wm"'"')'</label>
      </text>
            <text>
        <label>**************************************************</label>
      </text>
      	      	        <text use-markup="True" width-chars="20">
        <label>"<span color='"'yellow'"'><b>HARDWARE</b></span>"</label>
      </text>

           <text use-markup="True" width-chars="30">
        <label>"<b>'$(gettext 'Computer:')'</b> '"$computer"'"</label>
      </text>
      <text use-markup="True" width-chars="30">
        <label>"<b>'$(gettext 'CPU:')'</b> '"$cpu"'"</label>
      </text>
      <text use-markup="True" width-chars="40">
        <label>'$(gettext '"'"<b>Memory: </b>$mtype $mfreq $Memory"'"')'</label>
      </text>
       <text use-markup="True" width-chars="50">
        <label>'$(gettext '"'"<b>Disk: </b>$Tpart $disk"'"')'</label>
              </text>
            	        <text use-markup="True" width-chars="40" >
        <label> '$diskstatus' '$verificar_disco' '$hdcapacity' GB</label>
         </text>
         <text use-markup="True" width-chars="40" >
        <label> Disk '$diskstatus2'</label>
         </text>
                 <text>
        <label>--------------------------------------------------</label>
      </text>
      <text use-markup="True">
        <label>'$(gettext '"'"<b>OS developers: </b>SIMBIOSIS SURL"'"')'</label>
      </text>

             <button>
        <label>OK</label>
         <variable>ABOUT</variable>
          <action type="closewindow">ABOUT</action>
      </button>
    </frame>
  </vbox>
</window>

'

gtkdialog4 --program=ABOUT --center
