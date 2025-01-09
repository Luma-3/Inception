
NAME=inception

all: $(NAME)

$(NAME):
	docker-compose -f srcs/docker-compose.yml up -d --build

stop:
	docker-compose -f srcs/docker-compose.yml down

clean: stop
	docker-compose -f srcs/docker-compose.yml rm

# fclean: clean
# 	docker rmi $(NAME)

debug:
	docker-compose -f srcs/docker-compose.yml up -d --build --verbose

re: clean all
