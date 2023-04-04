#!/bin/bash

valid_microservice_name() {
    if ls "$root_path" | grep -q "$1"; then
        echo "$1"
    else
        echo "Invalid microservice name: $1"
        read -p "Press enter to continue..."
        exit 1
    fi
}

encrypt() {
    read -p "Enter your encryption password: " password
    resources_path="$1/src/main/resources"
    maven_path="$1"
    for file in "$resources_path"/*.yml; do
        echo "${file##*/}"
    done
    read -p "Enter the name of your configuration file: " config_file

    cd "$maven_path" || return 1
    mvn jasypt:encrypt "-Djasypt.encryptor.password=$password" "-Djasypt.plugin.path=file:src/main/resources/$config_file" || {
        echo "Encryption failed."
        return 1
    }

    echo "Encryption successful."
}

decrypt() {
    read -p "Enter your decryption password: " password
    resources_path="$1/src/main/resources"
    maven_path="$1"
    for file in "$resources_path"/*.yml; do
        echo "${file##*/}"
    done
    read -p "Enter the name of your encrypted configuration file: " config_file
    
    cd "$maven_path" || return 1
    mvn jasypt:decrypt "-Djasypt.encryptor.password=$password" "-Djasypt.plugin.path=file:src/main/resources/$config_file" || {
        echo "Decryption failed."
        return 1
    }

    echo "Decryption successful."
}


while true; do
    echo "Encrypting and Decrypting Sensitive Information in a Spring Boot Application"

    root_path="$HOME/IdeaProjects/path/path"
    cd "$root_path" || exit
    ls
    read -e -p "Enter Microservice Name: " microservice_name
    valid_microservice_name "$microservice_name"

    while true; do
        read -p "Do you want to encrypt or decrypt? " choice
        case $choice in
        encrypt)
            encrypt "$root_path/$microservice_name"
            break
            ;;
        decrypt)
            decrypt "$root_path/$microservice_name"
            break
            ;;
        *)
            echo "Invalid option. Please enter either 'encrypt' or 'decrypt'."
            ;;
        esac
    done

    read -p "Do you want to run the script again (y/n)? " choice
    case $choice in
    [yY] )
        ;;
    * )
        exit
        ;;
    esac
done



