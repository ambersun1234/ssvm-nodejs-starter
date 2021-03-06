CONTAINER_NAME=ssvm
MOUNT_FOLDER=/app
THIS_FILE := $(lastword $(MAKEFILE_LIST))

create:
	sudo docker run -it -d -p 3000:3000 -p 8080:8080 --name $(CONTAINER_NAME) -v $(shell pwd):$(MOUNT_FOLDER) secondstate/ssvm-nodejs-starter:v1

start:
	sudo service docker start
	sudo docker start $(CONTAINER_NAME)

stop:
	sudo docker stop $(CONTAINER_NAME)

compile:
	@$(MAKE) -f $(THIS_FILE) start
	sudo docker exec -t $(CONTAINER_NAME) bash -c "cd $(MOUNT_FOLDER) && ssvmup build"

ps:
	sudo docker ps -a

in:
	@$(MAKE) -f $(THIS_FILE) start
	sudo docker exec -it $(CONTAINER_NAME) bash

kill:
	@$(MAKE) -f $(THIS_FILE) start
	sudo docker exec -t $(CONTAINER_NAME) bash -c "bash $(MOUNT_FOLDER)/terminate.sh"

.PHONY: clean

clean:
	sudo docker rm -f $(CONTAINER_NAME)
