#!/bin/bash

# Leer el nombre de usuario de GitHub
echo "---------- Actividad 2 - 202004745 ----------"
read -p "Introduce el nombre de usuario de GitHub: " GITHUB_USER
echo " "

# Hacer la consulta a la API de GitHub
DATA=$(curl -sL https://api.github.com/users/$GITHUB_USER)

#Verificar si el usuario existe
if [ "$(echo $DATA | jq -r '.message')" != "Not Found" ]; then 

    # Extraer los datos de la consulta y guardarlos en variables
    github_user=$(echo $DATA | jq -r .login)
    id=$(echo $DATA | jq -r .id)
    created_at=$(echo $DATA | jq -r .created_at)

    # Imprimir los datos
    echo "---------- Datos del usuario de GitHub ----------"
    echo "Hola $github_user. User ID: $id. Cuenta fue creada el: $created_at."
    echo " "

    # Crear el log file en /tmp/<fecha>/saludos.log
    fecha=$(date +%Y%m%d)
    log_dir="/tmp/${fecha}"
    log_file="${log_dir}/saludos.log"

    mkdir -p "$log_dir"
    echo "Hola $github_user. User ID: $id. Cuenta fue creada el: $created_at." >> "$log_file"

else
    # Imprimir mensaje de error si el usuario no existe
    echo -e "\e[0;31m---------- El usuario $GITHUB_USER no existe ----------\e[0m"
fi
exec > /tmp/${fecha}/saludos.log 2>&1
echo "---------- Fin de la actividad 2 ----------"
