# Developer Documentation

## Set up the environment from scratch

Prerequisites:
- A Virtual Machine running the penultimate stable Debian.
- Docker and the Docker Compose plugin installed.
- `cjeannin.42.fr` resolving to `127.0.0.1` in the VM's `/etc/hosts`.

Configuration files to provide before the first build:
- `srcs/.env` — already versioned, holds the non-sensitive configuration (database name, WordPress users/emails, `DOMAIN_NAME`). Edit it if you need to change these values.
- `secrets/*.txt` — **not** versioned (listed in `.gitignore`), must be created manually, one password per file:
  - `secrets/db_password.txt`
  - `secrets/db_root_password.txt`
  - `secrets/wp_admin_password.txt`
  - `secrets/wp_second_password.txt`

These secrets are consumed by the containers as Docker secrets (mounted read-only at `/run/secrets/<name>`), never as plain environment variables, and are referenced in `srcs/docker-compose.yml` under the top-level `secrets:` key.

## Build and launch the project using the Makefile and Docker Compose

The `Makefile` at the project root drives everything; it never needs to be called with Docker Compose directly.

| Target        | What it does                                                                 |
|---------------|--------------------------------------------------------------------------------|
| `make` / `make all` | Creates the host data directories (`$(DATA_PATH)/mariadb`, `$(DATA_PATH)/wordpress`) then runs `docker compose -f srcs/docker-compose.yml up --build -d` |
| `make down`   | `docker compose -f srcs/docker-compose.yml down`                              |
| `make clean`  | `down` + `docker system prune -af`                                            |
| `make fclean` | `clean` + removes the host data directories and the named volumes (`srcs_mariadb`, `srcs_wordpress`) |
| `make re`     | `fclean` then `all` — full rebuild from scratch                               |

`DATA_PATH` is set to `/home/cjeannin/data` in the `Makefile`; adjust the login if you fork this project under a different one.

Each service is built from its own Dockerfile under `srcs/requirements/<service>/`, and none of them use the `latest` tag or a pre-built image other than the base Debian one.

## Use relevant commands to manage the containers and volumes

- `docker compose -f srcs/docker-compose.yml ps` — list the 3 services and their state.
- `docker compose -f srcs/docker-compose.yml logs -f <service>` — tail the logs of `nginx`, `wordpress`, or `mariadb`.
- `docker compose -f srcs/docker-compose.yml exec <service> sh` — get a shell inside a running container.
- `docker compose -f srcs/docker-compose.yml restart <service>` — restart a single service without rebuilding.
- `docker volume ls` / `docker volume inspect srcs_mariadb` / `docker volume inspect srcs_wordpress` — inspect the named volumes and confirm their mount point.
- `docker network inspect srcs_inception` — inspect the dedicated bridge network shared by the 3 containers.

## Identify where the project data is stored and how it persists

Two Docker **named volumes** are declared in `srcs/docker-compose.yml`:
- `wordpress`, mounted at `/var/www/wordpress` in the `wordpress` and `nginx` containers.
- `mariadb`, mounted at `/var/lib/mysql` in the `mariadb` container.

Both use the `local` driver with a bind-style `driver_opts`, so their actual data lives on the host at `/home/cjeannin/data/wordpress` and `/home/cjeannin/data/mariadb` (the `DATA_PATH` from the `Makefile`), as required by the subject. Because these are named volumes managed by Docker (not plain bind mounts declared in the `volumes:` service section), the data survives `make down` and `make clean`, and is only destroyed by `make fclean`.
