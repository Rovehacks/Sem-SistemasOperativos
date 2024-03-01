#!/bin/bash

OPTSTRING="n:o:c:r:v:d:s:i:h"

while getopts ${OPTSTRING} option;
do 
  case "${option}" in
    n) name=${OPTARG};;
    o) os=${OPTARG};;
    c) cpu=${OPTARG};;
    r) ram=${OPTARG};;
    v) vram=${OPTARG};;
    d) disk=${OPTARG};;
    s) sataName=${OPTARG};;
    i) ideName=${OPTARG};;
    h) echo -e "SYNTAX:\n\tvmconfig.sh [OPTIONS] [STRING]\n\nOPTIONS:\n\t-n: Nombre de la máquina virtual.\n\t-o: Tipo de sistema operativo.\n\t-c: Número de CPUs.\n\t-r: Cantidad de RAM en MB.\n\t-v: Cantidad de vRAM en MB.\n\t-d: Tamaño del disco virtual en MB.\n\t-s: Nombre del controlador SATA.\n\t-i: Nombre del controlador IDE.\n" 
      exit ;;
  esac
done

if [[ -z "$name" || -z "$os" || -z "$cpu" || -z "$ram" || -z "$vram" || -z "$disk" || -z "$sataName" || -z "$ideName" ]]; then
  echo "Faltaron argumentos por definir. Use el argumento -h para ayuda"
  exit 
fi

VBoxManage createvm --name $name --ostype $os --register --basefolder 'pwd'/$name
VBoxManage modifyvm $name --ioapic on 
VBoxManage modifyvm $name --cpus $cpu
VBoxManage modifyvm $name --memory $ram --vram $vram
VBoxManage createmedium --filename 'pwd'/$name/$name.vhd --size $disk --format VHD
VBoxManage storagectl $name --name $sataName --add sata --controller IntelAhci
VBoxManage storageattach $name --storagectl $sataName --port 0 --device 0 --type hdd --medium 'pwd'/$name/$name.vhd
VBoxManage storagectl $name --name $ideName --add ide 
VBoxManage storageattach $name --storagectl $ideName --port 1 --device 0 --type dvddrive --medium emptydrive

VBoxManage showvminfo $name | grep "Name:"
VBoxManage showvminfo $name | grep "Guest OS:"
VBoxManage showvminfo $name | grep "Number of CPUs:"
VBoxManage showvminfo $name | grep "Memory size:"
VBoxManage showvminfo $name | grep "VRAM size:"
VBoxManage showvminfo $name --machinereadable | grep "storagecontrollername0=" 
VBoxManage showvminfo $name --machinereadable | grep "storagecontrollername1=" 
VBoxManage showvminfo $name --machinereadable | grep "SATAController-0-0" 
VBoxManage showvminfo $name --machinereadable | grep "IDEController-1-0" 
