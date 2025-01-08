
NAME=inception

all: $(NAME)

$(NAME):
	docker-compose -f srcs/docker-compose.yml up -d --build

stop:
	docker-compose down

clean: stop
	docker-compose rm

fclean: clean
	docker rmi $(NAME)

re: fclean all
