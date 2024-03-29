LOGIN=$(shell grep YOUR_LOGIN .env | cut -d '=' -f2)
X11=/tmp/.X11-unix

up: build
	@docker run -it \
	-e DISPLAY=${DISPLAY} \
	-v ${X11}:${X11} \
	--name EXAM_CONTAINER \
	exam
.PHONY: up

enter:
	@docker exec -it EXAM_CONTAINER bash
.PHONY: enter

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
