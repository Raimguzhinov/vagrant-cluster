#!/bin/bash
 
CURRENTDATEONLY=`date +"%b %d, %Y"`
HOSTNAME=`hostname`

echo Current Date is: ${CURRENTDATEONLY}
echo User is: "$USER"
echo Hostname is: ${HOSTNAME}
sleep 1.5
echo
echo Prosessor:
echo -e '\t' Model: `sysctl -n machdep.cpu.brand_string`
echo -e '\t' Architecture: `uname -p`
echo -e '\t' Max Clock Frequency: `sysctl -n hw.cpufrequency_max`
echo -e '\t' Current Clock Frequency: `sysctl -n hw.cpufrequency`
echo -e '\t' Number of Cores: `sysctl -n hw.ncpu`
echo -e '\t' Number of Threads per Core: `sysctl -n machdep.cpu.thread_count`
echo -e '\t' `top -l 1 | rg "CPU usage"` &
sleep 1.5
echo
echo Memory:
echo -e '\t' Cache L1: `sysctl -n hw.l1icachesize`
echo -e '\t' Cache L2: `sysctl -n hw.l2cachesize`
echo -e '\t' Cache L3: `sysctl -n hw.l3cachesize`
echo -e '\t' Total Memory: `sysctl -n hw.memsize`
echo -e '\t' Free Memory: `vm_stat | awk '/Pages free/ {print $3 * 4096}'`
sleep 1.5
echo
echo Disk:
echo -e '\t' Total Disk Space: `df -h / | rg ".Gi" | awk '{print $2+$3}'`Gi
echo -e '\t' Free Disk Space: `df -h / | rg ".Gi" | awk '{print $4}'`
echo -e '\t' Count of Sections: `df -h | rg -c "/dev/"` 
echo -e '\t' Section Information:
echo -e '\t\t    ' `df -h | rg "Size" | awk '{print $1,$2,$3,$4}'`
IFS=$'\n'
sections_info=$(df -h | rg "/dev/" | awk '{print $1"\t"$2"\t"$3"\t"$4""}')
for section in $sections_info; do 
  echo -e '\t\t' $section
done
unset IFS
echo -e '\t    ' `df | awk '{ if ($9 == "/") print $1}'` – Mounted on: `df | awk '{ if ($9 == "/") print $9}'`
echo
echo -e '\t' Volume of Unshaded Space – EFI: `diskutil info disk0s1 | rg "Disk Size:" | awk '{print $3 $4}'`
echo -e '\t' SWAP Total: `sysctl -n vm.swapusage | awk '{print $3}'` 
echo -e '\t' SWAP Free: `sysctl -n vm.swapusage | awk '{print $9}'` 
sleep 1.5
echo
echo Network: 
echo -e '\t' Count of network interfaces: `ifconfig -u | rg -c ": f"`
echo
interfaces=$(ifconfig -lu)
standard_interfaces=$(networksetup -listallhardwareports | rg "Device" | awk '{print $2}')
$(sleep 1.5)
i=1
for interface in $interfaces; do
  echo -e '\t' "$i) Interface: $interface"
    mac=$(ifconfig $interface | awk '/ether/ {print $2}')
    if [[ $mac != "" ]]; then echo -e '\t' "MAC Address: $mac"; fi
    ip=$(ifconfig $interface | awk '/inet / {print $2}')
    if [[ $ip != "" ]]; then echo -e '\t' "IP Address: $ip"; fi
    standard=$(ifconfig $interface | awk '/media:/ {print $2, $3, $4}')
    # standard=""
    # for standard_interface in $standard_interfaces; do
    #   if [[ $standard_interface == $interface ]]
    #   then
    #     standard=`networksetup -listallhardwareports | tail -r | awk -v device="$interface" '/Device:/{dev=$2} /Hardware Port:/{if(dev==device) print $3, $4}'`
    #   fi
    # done
    if [[ $standard != "" && $standard != "autoselect  " ]]
    then 
      echo -e '\t' "Communication Standard: $standard" &
    fi
    max_speed=$(networksetup -getMTU $interface | awk '/MTU/ {print $3}')
    if [[ $max_speed != "" ]]; then echo -e '\t' "Maximum Connection Speed: $max_speed"; fi
    if [[ $interface == "en0" ]]; then actual_speed=$(networkquality -I $interface | awk '/link/ {print $1, $3, $4}'); fi
    IFS=$'\n'
    if [[ $interface == "en0" || $interface == "bridge0" ]]; then echo -e '\t' "Actual Connection Speed: "; fi
    for speed in $actual_speed; do
      if [[ $interface == "en0" || $interface == "bridge0" ]]; then echo -e '\t\t' "$speed"; fi
    done
    unset IFS
    echo
    ((i++))
done
