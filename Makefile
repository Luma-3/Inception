
NAME=inception

COMPOSE = docker compose

all: $(NAME)

$(NAME):
	$(COMPOSE) -f srcs/docker-compose.yml up -d --build

stop:
	$(COMPOSE) -f srcs/docker-compose.yml stop

clean: stop
	$(COMPOSE) -f srcs/docker-compose.yml down

fclean:
	$(COMPOSE) -f srcs/docker-compose.yml down --volumes --rmi all
	sudo rm -rf /home/jbrousse/mariadb/* /home/jbrousse/wordpress/*


re: fclean all

