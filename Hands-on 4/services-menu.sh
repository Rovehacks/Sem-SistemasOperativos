#!/bin/bash
PS3="Elige una opción: "
opts=("Listar contenido" "Crear archivo con texto" "Comparar 2 archivos" "Uso de awk" "Uso de grep" "Salir")
select opt in "${opts[@]}"
do 
  case "$opt" in
    "Listar contenido") 
      echo "Ingresa la ruta absoluta"
      read ruta
      ls $ruta
      break
    ;;
    "Crear archivo con texto") 
      echo "Ingresa el texto para el archivo"
      read texto
      echo $texto > archivo.txt 
      break
    ;;
    "Comparar 2 archivos") 
      echo "Ingresa el primer archivo para comparar"
      read f1
      echo "Ingresa el segundo archivo par comparar"
      read f2
      grep -f $f1 $f2
      break
    ;;
    "Uso de awk") 
      awk -W help
      break 
    ;;
    "Uso de grep") 
      grep --help
      break
    ;;
    "Salir") break 2
    ;;
    *) echo "Opción no válida"
  esac
done
