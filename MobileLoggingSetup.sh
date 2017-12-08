#!/bin/bash

# Script de instalación de herramientas para logging móvil basado en el script para instalación de Snort de Manel Rodero
# https://github.com/manelrodero/Master-UPC-School/blob/master/Module-3/Setup-Snort.sh

RED='\033[0;31m'
ORANGE='\033[0;205m'
YELLOW='\033[0;93m'
GREEN='\033[0;32m'
CYAN='\033[0;96m'
BLUE='\033[0;34m'
VIOLET='\033[0;35m'
NOCOLOR='\033[0m'
BOLD='\033[1m'

installPackage() {
	echo -ne "- ${BOLD}Instalando ${BLUE}$1${NOCOLOR}... "
	res=$(sudo apt-get install -qy $1)
	[ $? != 0 ] && { echo -ne "${RED}Error!${NOCOLOR}\n"; exit 1; } || { echo -ne "${GREEN}Correcto${NOCOLOR}\n"; }
}

downloadFile() {
	echo -ne "- ${BOLD}Descargando ${BLUE}$1${NOCOLOR}... "
	res=$(wget -O $1 $2 >/dev/null 2>&1)
	[ $? != 0 ] && { echo -ne "${RED}Error!${NOCOLOR}\n"; exit 1; } || { echo -ne "${GREEN}Correcto${NOCOLOR}\n"; }
}

checkCommand() {
	echo -ne "- ${BOLD}Comprobando '${BLUE}$1${NOCOLOR}${BOLD}'${NOCOLOR}... "
	gitCheck=$(which $1)
	[ $? != 0 ] && { echo -ne "${RED}No existe!${NOCOLOR}\n"; exit 1; } || { echo -ne "${GREEN}Disponible${NOCOLOR}\n"; }
}

createDir() {
	if [ ! -d $1 ]; then
		mkdir $1
	fi
}

createDirNew() {
	if [ -d $1 ]; then
		rm -rf $1
	fi
	mkdir $1
}

createDirSudo() {
	if [ ! -d $1 ]; then
		sudo mkdir $1
	fi
}

createFileSudo() {
	if [ ! -f $1 ]; then
		sudo touch $1
	fi
}

# Instalación de los prerequisitos de apktool
installPackage default-jre
installPackage gcj-4.8-jre-headless
installPackage openjdk-7-jre-headless
installPackage gcj-4.6-jre-headless
installPackage openjdk-6-jre-headless
# Instalación de apktool para reversear el binario
downloadFile apktool https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
downloadFile apktool_2.3.0.jar https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.3.0.jar
mv apktool_2.3.0.jar apktool.jar
sudo chmod +x apktool
sudo chmod +x apktool.jar
sudo mv apktool.jar /usr/local/bin
sudo mv apktool /usr/local/bin

# Instalación de dex2jar para convertir el codigo maquina en java
downloadFile dex-tools-2.0.zip https://github.com/pxb1988/dex2jar/releases/download/2.0/dex-tools-2.0.zip
unzip dex-tools-2.0.zip
mv dex2jar-2.0/d2j-dex2jar.sh dex2jar-2.0/dex2jar
sudo chmod +x dex2jar-2.0/dex2jar
sudo mv dex2jar-2.0/dex2jar /usr/local/bin

# Instalación de las herramientas de android debug bridge
installPackage android-tools-adb

# Instalación de pidcat
downloadFile pidcat.py https://github.com/JakeWharton/pidcat/blob/master/pidcat.py
sudo mv pidcat.py /usr/local/bin
echo "alias pidcat='python /usr/local/bin/pidcat.py'" > ~/.bash-aliases
source ~/.bashrc

exit 0
