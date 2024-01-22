#!/bin/bash
#
#
# |=====================================|
# | SCRIPT DE INSTALAÇÃO E CONFIGURAÇÃO |
# | AUTOMATIZADA DO GDRIVE              |
# |-------------------------------------|
# | CRIADO POR: JOYCE SILVA             |
# | GITHUB: github.com/coejoy           |
# | DATA DE CRIAÇÃO: 12/01/2024         |
# |=====================================|
#
# |===================================================================================|
# |-----------------------|      adicionar o repositório      |----------------------|
# |===================================================================================|

echo "ADICIONANDO O REPOSITÓRIO"
sudo add-apt-repository ppa:alessandro-strada/ppa -y

# === atualizar os pacotes e instalar o ocamlfuse
echo "ATUALIZANDO OS PACOTES E INSTALANDO O GDRIVE OCAMLFUSE"

sudo apt-get update && sudo apt-get install google-drive-ocamlfuse -y

# === Criar diretórios
echo "CRIANDO OS DIRETÓRIOS"

mkdir -p "Google Drive/MEU DRIVE"
mkdir -p "Google Drive/TI"

# === Montar drive e criar login
echo "MONTANDO O DRIVE E CRIANDO O LOGIN"
google-drive-ocamlfuse -label "MEU DRIVE" "/home/joy/Google Drive/MEU DRIVE"
google-drive-ocamlfuse -label "TI" "/home/joy/Google Drive/TI"

# |===================================================================================|
# |----------------------|criar script para montagem automática|----------------------|
# |===================================================================================|
#
cat <<\EOF | sudo tee -a /etc/init.d/montar_drive

#!/bin/bash
google-drive-ocamlfuse -label "MEU DRIVE" "/home/joy/Google Drive/MEU DRIVE"
google-drive-ocamlfuse -label "TI"  "/home/joy/Google Drive/TI"

EOF

clear

# === add na crontab para rodar na inicialização do sistema
(crontab -l; echo "@reboot /bin/bash /etc/init.d/montar_drive") | crontab -

# mudar o id quando necessário

sed -i 's,team_drive_id=,team_drive_id=0ACDmg_HUtRFlUk9PVA,g' ~/.gdfuse/TI/config

clear

echo "REINICIANDO A MAQUINA PARA APLICAR AS ALTERAÇÕES"

sleep 3

reboot






