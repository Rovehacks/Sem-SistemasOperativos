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
    h) echo -e "SYNTAX:\n\tvmconfig.sh [OPTIONS] [STRING]\n\nOPTIONS:\n\t-n: Nombre de la máquina virtual.\n\t-o: Tipo de sistema operativo.\n\t-c: Número de CPUs.\n\t-r: Cantidad de RAM en GB.\n\t-v: Cantidad de vRAM en MB.\n\t-d: Tamaño del disco virtual.\n\t-s: Nombre del controlador SATA.\n\t-i: Nombre del controlador IDE.\n" 
      exit ;;
  esac
done

if [[ -z "$name" || -z "$os" || -z "$cpu" || -z "$ram" || -z "$vram" || -z "$disk" || -z "$sataName" || -z "$ideName" ]]; then
  echo "Faltaron argumentos por definir. Use el argumento -h para ayuda"
  exit 
fi

mkdir $name
cd name
VBoxManage createvm --name $name --ostype $os --register --basefolder 'pwd'
VBoxManage modifyvm $name --ioapic on 
VBoxManage modifyvm $name --memory $ram --vram $vram
