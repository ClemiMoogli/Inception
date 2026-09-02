
# a lancer sur la vm: echo "net.ipv4.ip_unprivileged_port_start=443" | sudo tee -a /etc/sysctl.conf
# sudo mkdir -p /home/cjeannin/data
# sudo chown -R clement:clement /home/cjeannin
NAME = inception
DATA_PATH = /home/cjeannin/data

all: $(NAME)

$(NAME):
	mkdir -p $(DATA_PATH)/mariadb
	mkdir -p $(DATA_PATH)/wordpress
	docker compose -f srcs/docker-compose.yml up --build -d

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -af

fclean: clean
	sudo rm -rf $(DATA_PATH)/mariadb
	sudo rm -rf $(DATA_PATH)/wordpress
	docker volume rm srcs_mariadb srcs_wordpress 2>/dev/null || true

re: fclean all

.PHONY: all down clean fclean re
