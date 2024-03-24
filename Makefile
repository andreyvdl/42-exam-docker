LOGIN=$(shell grep YOUR_LOGIN .env | cut -d '=' -f2)

up: build
	@docker run -it exam
.PHONY: up

build:
	@if ! docker images -a | grep -q exam; then \
		docker build --build-arg YOUR_LOGIN=$(LOGIN) -t exam . --no-cache; \
	fi
.PHONY: build

down:
	@if docker ps | grep exam; then \
		docker stop $(shell docker ps | grep exam | awk '{print $1}'); \
	fi
.PHONY: down

prune: down
	@docker system prune -fa
.PHONY: prune

re: prune up
.PHONY: re
