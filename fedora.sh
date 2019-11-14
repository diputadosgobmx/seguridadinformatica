#!/bin/bash

###############################################################################
# Instalación de equipos con Fedora Workstation para el
# Departamento de Seguridad Informática de la 
# H. Cámara de Diputados Federal
# 
# Contacto: seguridadinformatica@diputados.gob.mx
#
# Requerimientos:
# - Descarga de imagen ISO de Fedora Workstation
# - Verificación de integridad de archivo ISO
# - Creación de medio de instalación (USB/DVD)
# - Arranque de dispositivo en medio de instalación
# - Instalación sistema operativo Fedora en dispositivo (PC/laptop)
#
# Uso desde equipo local: 
# - Descarga de archivo:
#   - Opción 1 con wget: $ wget
#   - Opción 2 con curl: $ curl
# - Cambio de permisos para permitir ejecución del archivo
#   - $ chmod +x <archivo>
#   
# Uso desde Internet:
# - $ sudo curl -sSL https://XXXXXXXXX.codigoabierto.diputados.gob.mx 
# 
# Por hacer:
# - Registro (log) de cada instalación en archivo externo
#
###############################################################################

###############################################################################
# Limpieza de metadatos
dnf clean metadata

###############################################################################
# Instalación de repositorios RPMFusion 
dnf -y install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

###############################################################################
# Actualización de paquetes
dnf -y update

###############################################################################
# Instalación de herramientas de desarrollo
dnf -y groupinstall "Development Tools"

###############################################################################
# Instalación de librerias de desarrollo
dnf -y groupinstall "Development Libraries"

###############################################################################
# Instalación de scripts de desarrollo
dnf -y install devscripts

###############################################################################
# Instalación de sistema de creacion de paquetes de Debian
dnf -y install cdbs

###############################################################################
# Instalación de herramienta de conversión de archivos de código fuente a 
# paquetes de código Debian
dnf -y install dh-make

###############################################################################
# Instalación de herramientas de ingeniería y científicas
dnf -y groupinstall "Engineering and Scientific"

###############################################################################
# Instalación de herramientas de virtualización
dnf -y groupinstall --with-optional Virtualization

###############################################################################
# Instalación de interfaz de virtualización QUEMU para KVM
dnf -y install qemu

###############################################################################
# Instalación de controladores para montar sistemas de archivos FAT
dnf -y install fuse-exfat

###############################################################################
# Instalación de sistema de archivos a través de SSH
dnf -y install sshfs

###############################################################################
# Instalación de herramientas de monitoreo de hardware
dnf -y install lm_sensors

###############################################################################
# Instalación de soporte dinámico para módulos del kernel
dnf -y install dkms

###############################################################################
# Instalación de ambiente root de prueba
dnf -y install fakeroot

###############################################################################
# Instalación de compresores de archivos

# Instalación de herramienta para extraer archivos "ace"
dnf -y install unace

# Instalación de herramienta para extraer, probar y visualizar
# archivos "rar"
dnf -y install unrar

# Instalación de compresor/descompresor de archivos 7zip
dnf -y install p7zip

# Utilidades para empaquetar y desempaquetar archivos de shell
dnf -y install sharutils

# Instalación de aplicaciones para uuencoding/uudecoding
dnf -y install uudeview

# Instalación de herramienta para comprimir archivos "arj"
dnf -y install arj

# Instalación de herramienta para extraer archivos "cab"
dnf -y install cabextract

###############################################################################
# Instalación de capa de compatibilidad para aplicaciones MS Windows
dnf -y install wine

# Instalación de herramienta gráfica para configuración de idioma
dnf -y install system-config-language

# Instalación de páginas del adicionales del manual en español
dnf -y install man-pages-es-extra

# Instalación de herramienta de particionamiento GParted
dnf -y install gparted

# Instalación de antivirus e interfaz gráfica - CLAM
dnf -y install clamtk

# Instalación de software de modelado, animación y renderizado 3D - Blender
dnf -y install blender

# Instalación de editor de imágenes Gimp
dnf -y install gimp
dnf -y install gimp-data-extras

# Instalación de imágenes vectoriales
dnf -y install inkscape
dnf -y install inkscape-{psd,docs} python3-sphinxcontrib-inkscapeconverter inkscape-view

# Instalación de manipulación de imágenes ImageMagick
dnf -y install ImageMagick

# Instalación de editor de diagramas Dia
dnf -y install dia
dnf -y install dia-*
dnf -y install scribus
dnf -y install xchm
dnf -y install calibre
dnf -y install transmission
dnf -y install filezilla
dnf -y install pidgin
dnf -y --skip-broken install gstreamer-*
dnf -y install gstreamer1-*
dnf -y install vlc
dnf -y install vlc-extras
dnf -y install mplayer
dnf -y install vokoscreen
dnf -y install audacity
dnf -y install kdenlive
dnf -y install flowblade
dnf -y install brasero
dnf -y install youtube-dl
dnf -y install android-tools
dnf -y install arduino
dnf -y install fritzing
dnf -y install rtl-sdr
dnf -y install gqrx
dnf -y install aircrack-ng
dnf -y install macchanger
dnf -y install wireshark
dnf -y install ansible
dnf -y install gnome-tweak-tool
dnf -y install planner
dnf -y install gtypist
dnf -y install keepassxc
dnf -y install umit

# Dependencias para Metasploit
dnf -y install ruby-irb rubygems rubygem-bigdecimal rubygem-rake rubygem-i18n

dnf -y install dnf-utils
dnf -y install yum-builddep ruby


dnf -y install ruby-devel libpcap-devel

dnf -y install postgresql-server postgresql-devel
gem install pg 
###############################################################################
# Instalación de sistema de control de versiones Git
dnf -y install git

###############################################################################
# Instalación de editor de textos Vim
dnf -y install vim

# Instalación de extension Pathogen del editor de textos Vim
mkdir -p ~/.vim/{autoload,bundle}
curl -o ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

cat << FIN > ~/.vimrc
execute pathogen#infect()

filetype plugin indent on
syntax on
FIN

# Instalación de extension Pathogen del editor de textos Vim
cd ~/.vim/bundle
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git

# Instalación de extension de sintaxis del editor de textos Vim para lenguaje de programación Rust
git clone --depth=1 https://github.com/rust-lang/rust.vim.git ~/.vim/bundle/rust.vim

###############################################################################
# Iniciar servicio de SSH
systemctl start sshd.service
systemctl enable sshd.service

curl https://jdiazmx.github.io/scripts/ffdev-nightly.sh | sh

reboot
