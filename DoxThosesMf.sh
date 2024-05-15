#!/bin/bash

# Demande de l'utilisateur TikTok
read -p "Entrez le nom d'utilisateur TikTok: " username

# Liste de prénoms féminins pour générer un nom d'utilisateur TikTok
female_names=("emma" "lea" "manon" "chloe" "camille" "jade" "sarah" "anna" "lucie" "romane")

# Fonction pour générer des informations aléatoires en utilisant l'API randomuser.me
generate_fake_info() {
  # Récupération des informations d'un homme
  response_male=$(curl -s https://randomuser.me/api/?nat=fr&gender=male)
  first_name=$(echo $response_male | jq -r '.results[0].name.first')
  last_name=$(echo $response_male | jq -r '.results[0].name.last')
  address=$(echo $response_male | jq -r '.results[0].location.street.number') $(echo $response_male | jq -r '.results[0].location.street.name'), $(echo $response_male | jq -r '.results[0].location.city'), $(echo $response_male | jq -r '.results[0].location.state'), France
  age=$(echo $response_male | jq -r '.results[0].dob.age')
  phone=$(printf "06 %02d %02d %02d %02d\n" $(shuf -i 0-99 -n 4))

  # Récupération des informations d'une femme pour la petite amie
  response_female=$(curl -s https://randomuser.me/api/?nat=fr&gender=female)
  girlfriend_first_name=$(echo $response_female | jq -r '.results[0].name.first')
  girlfriend_last_name=$(echo $response_female | jq -r '.results[0].name.last')
  random_index=$(shuf -i 0-$((${#female_names[@]} - 1)) -n 1)
  girlfriend_username="${female_names[$random_index]}_tiktok_$(shuf -i 100-999 -n 1)"

  echo "Informations pour l'utilisateur TikTok '$username':"
  echo "Nom: $last_name"
  echo "Prénom: $first_name"
  echo "Petite amie: $girlfriend_first_name $girlfriend_last_name (username: $girlfriend_username)"
  echo "Adresse: $address"
  echo "Âge: $age"
  echo "Téléphone: $phone"
}

# Vérification de la présence de curl et jq
if ! command -v curl &> /dev/null
then
  echo "La commande curl est nécessaire, mais elle n'est pas installée. Veuillez l'installer et réessayer."
  exit
fi

if ! command -v jq &> /dev/null
then
  echo "La commande jq est nécessaire, mais elle n'est pas installée. Veuillez l'installer et réessayer."
  exit
fi

# Génération et affichage des informations aléatoires
generate_fake_info
