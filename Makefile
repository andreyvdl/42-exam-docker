LOGIN=$(shell grep YOUR_LOGIN .env | cut -d '=' -f2)

up: build
	@docker run -it -v exam-backup:/home/${LOGIN}/42_EXAM exam
.PHONY: up

build:
	@if [ ! -d "./backup" ]; then \
		mkdir -p backup; \
	fi
	@if ! docker volume ls | grep 'exam-backup'; then \
		docker volume create \
		--driver local \
		-o o=bind \
		-o type=none \
		-o device=$(shell pwd)/backup \
		exam-backup; \
	fi
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
	@if docker volume ls | grep 'exam-backup'; then \
		docker volume rm exam-backup; \
	fi
	@rm -fr ./backup
.PHONY: prune

re: prune up
.PHONY: re
