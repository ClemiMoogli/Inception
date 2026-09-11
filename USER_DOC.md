# User Documentation

## Setup checklist (before first `make`)

- [ ] Add the secrets in:
  - `/secrets/db_password.txt`
  - `/secrets/db_root_password.txt`
  - `/secrets/wp_admin_password.txt`
  - `/secrets/wp_second_password.txt`
- [ ] If not already done, add a manual entry in the VM's `/etc/hosts`: `127.0.0.1 cjeannin.42.fr`

## What services are provided by the stack?

The stack is made of 3 containers, each running a single service:

| Service     | Role                                                                         |
|-------------|-------------------------------------------------------------------------------|
| `nginx`     | Sole entrypoint of the infrastructure, serves the site over HTTPS (port 443, TLSv1.2/1.3) |
| `wordpress` | WordPress + php-fpm, generates the site content                               |
| `mariadb`   | Database storing WordPress data (posts, users, settings, ...)                 |

The `wordpress` and `mariadb` data are kept on two persistent Docker volumes, so your content survives container restarts and rebuilds.

## Start and stop the project

All commands are run from the project root, on the VM.

| Command       | Effect                                                                       |
|---------------|--------------------------------------------------------------------------------|
| `make`        | Builds the images (if needed) and starts all containers                       |
| `make down`   | Stops and removes the containers (data is kept)                               |
| `make clean`  | `down` + prunes unused Docker resources (images, networks, cache)             |
| `make fclean` | `clean` + removes the persistent data and volumes (destroys site content and database) |
| `make re`     | `fclean` + `make` — full rebuild from scratch                                 |

Containers are configured with `restart: unless-stopped`, so if one crashes it restarts automatically without any manual action.

## Access the website and the administration panel

- Website: `https://cjeannin.42.fr`
- WordPress administration panel: `https://cjeannin.42.fr/wp-admin`

Before the first access, make sure `cjeannin.42.fr` resolves to the VM's IP (see the setup checklist above).
Since the certificate is self-signed, your browser will show a security warning on the first visit — this is expected, accept/continue to reach the site.

Two WordPress users are created automatically on first launch:
- An administrator account (`WP_ADMIN_USER` in `srcs/.env`), whose username does not contain `admin`/`administrator`, as required by the subject.
- A second, non-admin account (`WP_SECOND_USER` in `srcs/.env`), with the `author` role.

## Locate and manage credentials

Credentials are never written in the Dockerfiles or in the `docker-compose.yml`. They live in two places:

- `srcs/.env` — non-sensitive configuration: database name, WordPress usernames/emails, domain name.
- `secrets/*.txt` — sensitive values, mounted into the containers as Docker secrets (`/run/secrets/...`), never exposed as plain environment variables:
  - `secrets/db_password.txt` — password of the WordPress database user
  - `secrets/db_root_password.txt` — MariaDB root password
  - `secrets/wp_admin_password.txt` — WordPress administrator password
  - `secrets/wp_second_password.txt` — WordPress second user password

These `secrets/*.txt` files are listed in `.gitignore` and must never be committed. To reset a password, edit the corresponding file and recreate the affected container (`make down` then `make`).

## Check that the services are running correctly

- `docker compose -f srcs/docker-compose.yml ps` — shows the state of the 3 containers (should be `running`).
- `docker compose -f srcs/docker-compose.yml logs -f <service>` — follow the logs of `nginx`, `wordpress` or `mariadb` to check for errors.
- Visiting `https://cjeannin.42.fr` in a browser should display the WordPress site.
- `docker ps` should show `mariadb`, `wordpress`, and `nginx` all `Up`, with `nginx` publishing `443/tcp`.
