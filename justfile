#Rectte par défault (affiche Hello world) 
hello: 
	echo "Hello world"

# Recette pour initialisé un projet git
init:
	git init
	git branch -M main

# Recette pour avoir les status 
status:
	git status

# recette pour ajouter les docs
add: 
	git add .

#Recette pour modifier des fichiers
#Exemple: just commit "ajout de la fonctionnalité"
commit msg:
	git commit -m "{{msg}}"

#Rectte pour récup les log
log:
	git log --oneline --graph --all

#recette pour supprimer un fichier 
#Exemple: just clean "monFichier.txt" supprime le fichier monFichier.txt
clean fichier:
	rm -f "{{fichier}}"

#Recette pour créer un BDD SQL dans un serveur local
DB_NAME := "ma_base_sql"
DB_USER := "postgres"

#créer la BDD 
db-create: 
	psql -U {{DB_USER}} -c "CREATE DATABASE {{DB_NAME}}" 

#insertion de table 
db-seed:
    psql -U {{DB_USER}} -d {{DB_NAME}} -c "CREATE TABLE IF NOT EXISTS utilisateurs (id SERIAL PRIMARY KEY, nom VARCHAR(50));"
    psql -U {{DB_USER}} -d {{DB_NAME}} -c "INSERT INTO utilisateurs (nom) VALUES ('Alice'), ('Bob');"

# Exécute les fichiers de migration (simulé avec un dossier /migrations)
db-migrate:
    @echo "Application des migrations..."
    # Si vous utilisez un outil (ex: atlas, alembic, dbmate), remplacez par sa commande.
    # Exemple générique qui lit les fichiers SQL :
    for f in migrations/*.up.sql; do psql -U {{DB_USER}} -d {{DB_NAME}} -f "$$f"; done

# Réinitialise la base de données pour revenir à un état vide (Downgrade)
db-reset:
    psql -U {{DB_USER}} -c "DROP DATABASE IF EXISTS {{DB_NAME}};"
    psql -U {{DB_USER}} -c "CREATE DATABASE {{DB_NAME}};"




