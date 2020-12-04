# !/bin/bash
# setup.sh

function install_node(){
	echo "Installation"
	sudo apt install software-properties-common
	curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
	sudo apt install -y nodejs
	echo "\n Vérification de la version"
	node -v
}


function update_pckgs(){
	echo "Mise à jour des packages"
	sudo apt update
}


function create_folders(){
	echo "Création des fichiers 'staging', 'pre-production' et 'production'"
	mkdir staging pre-production production
}


function write_into_server(){
cat <<EOT >> app.js
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.post('/:environment', (req, res)=>{
    let environment = req.params.environment;
    let sentence = req.query.sentence;
    if (sentence == undefined){
      res.send('Hello ' + environment + '! \n');
    } else {
      res.send('Hello ' + environment + '! \n' + sentence + '\n');
    }
    
})

app.listen(port, () => {
  console.log("Example app listening at http://localhost:" + port)
})

app.use(function (req, res, next) {
  res.status(404).send("Sorry can't find that!")
})

EOT
}


function create_server(){
	echo "Mise en place du serveur"
	sudo npm init
	sudo npm install express --save
	touch app.js
	write_into_server
	node app.js
}


function main(){
	# On commence par faire un update de tous les packages du système
	update_pckgs

	# On vérifie que nodejs est installé
	if dpkg -l nodejs
	then
	echo "Le paquet 'nodejs' a déjà été installé"
	else
	install_node
	fi

	#On vérifie que les dossiers soient présents
	if find staging pre-prodution production
	then
	echo "Les fichiers 'staging', 'pre-prodution' et 'production' sont déjà créés"
	else
	create_folders
	fi

	#On vérifie que le dossier myapp existe
	if test -d myapp
	then
	echo "Le dossier myapp a été mis en place"
	cd myapp
	else
	echo "Mise en place du dossier 'myapp'"
	mkdir myapp
	cd myapp
	fi

	#On vérifie l'existance du serveur
	if [[ -f "app.js" ]]
	then
	echo "Le serveur a déjà été mis en place"
	node app.js
	else
	create_server
	fi
}

main
