*This project has been created as part of the 42 curriculum by cjeannin.*

# Description

This project consists of having 3 docker images (nginx, wordpress and mariadb) set up and managed by docker compose.
The goal of this project is to learn how docker works and how we can interact with multiple docker container easily by using docker compose.


# Instruction

1) run the VM
2) git clone the project
3) create the secrets file (read the user_doc.md)
4) check that cjeannin is present in the etc/host
5) you can run the make command to start all the docker container.

# Ressources
[Docker compose tutorial](https://blog.stephane-robert.info/docs/conteneurs/orchestrateurs/docker-compose/)
[La conteneurisation](https://blog.stephane-robert.info/docs/conteneurisation/)
[Les images docker](https://blog.stephane-robert.info/docs/conteneurs/images-conteneurs/)
[Dockerfile tutorial](https://blog.stephane-robert.info/docs/conteneurs/images-conteneurs/ecrire-dockerfile/)
[Mariadb](https://mariadb.org/documentation/)
[Docker tutorial](https://inception.cluzet.fr/)

## How AI was used: 
AI was used to reformulate the readme file and also to breakdown some complex concept.

# Project description

## Virtual Machines vs Docker

## Secrets vs Environnement Variables

## Docker Network vs Host Network

## Docker Volumes vs Bind Mounts



# TODO LIST:
- faire un: git rm --cached pour arreter de commit les fichiers secrets.
- ajouter les secrets (voir USER_DOC.md)
- Dans le git ignore, renommer le srcs/.env.local => srcs/.env
- ajouter dans la VM une entree manuelle dans le fichier etc/host: 127.0.0.1 cjeannin.42.fr

