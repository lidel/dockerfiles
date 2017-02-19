# Build image and/or container if not present
init:
	test -n "$(shell docker images -f 'label=evernote_wine' -q)" \
	|| docker build -t evernote_wine .
	test -n "$(shell docker ps -f 'name=evernote_wine*' -qa)" \
	|| docker create -it  \
	--cpuset-cpus=0 \
	-v /etc/localtime:/etc/localtime:ro \
	-e DISPLAY=$(DISPLAY) \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	--name evernote_wine evernote_wine

enableX11:
	xhost +local:`docker inspect --format='{{ .Config.Hostname }}' evernote_wine`

start: init enableX11
	docker start evernote_wine
stop:
	docker ps -f 'name=evernote_wine*' -q | xargs -r docker stop

remove-container: stop
	docker ps -f 'name=evernote_wine*' -q -a | xargs -r docker rm

remove-image: remove-container
	docker images -f 'label=evernote_wine' -q | xargs -r docker rmi -f

purge:   remove-container remove-image
rebuild: purge init

# attach interactive shell to a running container
shell:
	docker exec -it evernote_wine /bin/bash

# create a new ephemeral container with interactive shell
debug: enableX11
	docker run -it  \
		--cpuset-cpus=0 \
		-v /etc/localtime:/etc/localtime:ro \
		-e DISPLAY=$(DISPLAY) \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		--entrypoint=sh \
		--rm --name evernote_wine_debug evernote_wine -c bash -l
