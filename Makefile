
NAME=inception

all: $(NAME)

$(NAME):
	docker-compose -f srcs/docker-compose.yml up -d --build

stop:
	docker-compose -f srcs/docker-compose.yml stop

clean: stop
	docker-compose -f srcs/docker-compose.yml down

fclean: clean
	docker-compose -f srcs/docker-compose.yml down --volumes --rmi all

debug:
	docker-compose -f srcs/docker-compose.yml up -d --build --verbose

re: fclean all
