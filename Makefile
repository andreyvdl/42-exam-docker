all: up
	@if ! ls | grep backup; then \
		mkdir backup; \
	fi
.PHONY: all

up:
	@if ! docker images -a | grep -q exam; then \
		docker build --build-arg YOUR_LOGIN=$(grep YOUR_LOGIN .env | cut -d '=' -f2) -t exam .; \
	fi
	@docker run -it exam 
.PHONY: up

down:
	@docker images | grep exam | awk '{print $$3}' | xargs docker rmi -f
	@docker system prune -f --filter label=exam
.PHONY: down