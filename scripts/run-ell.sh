#!/bin/bash -e

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -i|—input-folder)
    INPUT_FOLDER="$2"
    shift # past argument
    shift # past value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# first check if docker installed

if hash docker 2>/dev/null; then
    echo "${green}You have docker installed. Proceed to next step.${reset}"
else
    echo "${red}You don't have docker installed. Install docker first.${reset}"
    curl -sSL https://get.docker.com | sh
fi

# now check if image already exists
if docker inspect "erict2017/rpi0-ell-base:v1.1">/dev/null; then
    echo "${green}ELL base image already exists. Proceed to next step...${reset}"
else
    echo "${red}ELL base image does not exist. Pull the image first...${reset}"
    docker pull erict2017/rpi0-ell-base:v1.1
fi

# now run tutorial from input source folder with built models
echo "${green}Geting into ${INPUT_FOLDER}. Making sure you have built in model ready in this folder!${reset}"
cd ${INPUT_FOLDER}

docker run --rm -v $(pwd):/home/sources/ell-python erict2017/rpi0-ell-base:v1.1
