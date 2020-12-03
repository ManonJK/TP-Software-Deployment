#!/bin/bash
#deploy.sh

function select_env(){
	PS3="Veuillez choisir votre environnement s'il vous plaît : "
	options=("Staging" "Pre-production" "Production" "Quitter")
	select opt in "${options[@]}"; do
		case $opt in
			"Staging")
				#call deploy with right arg ?
				echo "Vous avez choisi Staging"
				break
				;;
                        "Pre-production")
                                #call deploy with right arg ?
                                echo "Vous avez choisi Pre-production"
				break
                                ;;
                        "Production")
                                #call deploy with right arg ?
                                echo "Vous avez choisi Production"
				break
                                ;;
                        "Quitter")
                                echo "Au revoir"
				break
                                ;;
                        *)
                                echo "Choix invalide $REPLY";;
		esac
	done
}

function deploy(){
	curl -X POST http://localhost:3000/$1?sentence=$2;
}

function main(){
	echo "veuillez rentrer la phrase que vous voulez"
	read sentence
	select_env
	if [ $opt = "Quitter" ]
	then
		return 0
	fi
	sentence="${sentence// /%20}"
	deploy "$opt" "$sentence"
}

main
