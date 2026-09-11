*This project has been created as part of the 42 curriculum by cjeannin.*

# Inception

## Description

This project consists of setting up and managing 3 Docker images (NGINX, WordPress and MariaDB) with Docker Compose.
The goal is to learn how Docker works and how to orchestrate multiple containers easily using Docker Compose.

## Instructions

1. Run the VM.
2. Clone the project: `git clone <repo_url>`.
3. Create the secret files (see [USER_DOC.md](USER_DOC.md)).
4. Make sure `cjeannin.42.fr` points to `127.0.0.1` in `/etc/hosts`.
5. Run `make` to build and start all the containers.

Other available commands:

| Command      | Description                                              |
|--------------|-----------------------------------------------------------|
| `make`       | Build the images and start all containers                 |
| `make down`  | Stop and remove the containers                             |
| `make clean` | Stop the containers and prune the Docker system            |
| `make fclean`| `clean` + remove persistent data and volumes                |
| `make re`    | `fclean` + `all`, i.e. a full rebuild from scratch          |

## Resources

- [Docker Compose tutorial](https://blog.stephane-robert.info/docs/conteneurs/orchestrateurs/docker-compose/)
- [La conteneurisation](https://blog.stephane-robert.info/docs/conteneurisation/)
- [Les images Docker](https://blog.stephane-robert.info/docs/conteneurs/images-conteneurs/)
- [Dockerfile tutorial](https://blog.stephane-robert.info/docs/conteneurs/images-conteneurs/ecrire-dockerfile/)
- [MariaDB documentation](https://mariadb.org/documentation/)
- [Docker tutorial](https://inception.cluzet.fr/)

### How AI was used

AI was used to reformulate this README.md, USER_DOC.md and DEV_DOC.md and also to help break down some complex concepts (how the docker network works ...).

## Project description

Docker is used to facilitate the reusability of a software on multiple platforms without trouble by using containerisation.
In this project we have 3 main folders (one for each service), and each service has its own Dockerfile to create its container, as well as a shell script to set up the container. To manage and run these 3 services simultaneously, we have a docker-compose.yml file in srcs/.

I choose to use Debian because it was easier for me to set up (more tutorial based on the Debian distribution).

### Virtual Machines vs Docker

A virtual machine starts from a hypervisor which simulates physical hardware and runs a full, separate OS on top of the host OS.
Docker is a containerization method: containers share the host OS kernel but run in an isolated environment, so an application can run independently from the host machine without the overhead of a full OS.

### Secrets vs Environment Variables

Environment variables live in a `.env` file and hold non-critical configuration (usernames, etc.).
Secrets are sensitive information that must be stored in a protected location. Here, we use Docker secrets to manage these critical values.

### Docker Network vs Host Network

When a Docker container is created, Docker sets up a network by default, similar to a local network: every container inside the same Compose project shares this network and can talk to each other. It is completely separate from the host network. To let the two networks communicate, ports have to be published explicitly in the relevant service of the `docker-compose.yml` file.

### Docker Volumes vs Bind Mounts

A Docker volume is managed entirely by Docker and stored inside Docker's own storage area.
A bind mount is a folder on the host that the user explicitly chooses for Docker to use.
Bind mounts are useful for development since the user knows exactly where the data lives and can interact with it directly. However, they are also fragile: the container depends on that folder's location, so moving it will break the container.
A "named volume" is simply a Docker volume to which the user gives an explicit name to make it easier to reference.























## TODO

- [ ] Untrack committed secret files with `git rm --cached` (they are currently tracked despite being listed in `.gitignore` — see [USER_DOC.md](USER_DOC.md)).
- [ ] Add the required secrets (see [USER_DOC.md](USER_DOC.md)).
- [ ] Update `.gitignore`: it still references `srcs/.env.local`, but the project now uses `srcs/.env`.
- [ ] Add a manual entry in the VM's `/etc/hosts`: `127.0.0.1 cjeannin.42.fr`.
