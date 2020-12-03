#!/bin/bash
#setup.sh

echo 'Mise à jour'
sudo apt update
echo ""
if dpkg -l nodejs
then
	echo "le paquet 'nodejs' a déjà été installé"
else
	echo 'Installation'
	sudo apt install software-properties-common
	curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
	sudo apt install -y nodejs
fi
echo ""
echo 'Vérification de la version'
node -v

echo ""
echo""
if find staging pre-prodution production
then
	echo "Les fichiers 'staging', 'pre-prodution' et 'production' sont déjà créés"
else
	echo "Création des fichiers 'staging',  'pre-prodution' et 'production'"
	mkdir staging pre-prodution production
fi

echo ""
echo ""
if test -d myapp
then
	echo "Le serveur web a été mis en place"
else
	echo "Mise en place du serveur web"
	mkdir myapp
	cd myapp
	sudo npm init
	sudo npm install express --save
	touch app.js
fi
cd myapp/
node app.js
