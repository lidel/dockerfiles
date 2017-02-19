all: init
# Build image and/or container if not present
init:
	test -n "$(shell docker images -f 'label=base_wine' -q)" \
	|| docker build -t base_wine .

rebuild: remove-image init
remove-image:
	docker images -f 'label=base_wine' -q | xargs -r docker rmi -f

shell: init
	docker run --rm -it \
	--cpuset-cpus=0 \
	-v /etc/localtime:/etc/localtime:ro \
	-e DISPLAY=$(DISPLAY) \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	--name shell-wine \
	base_wine bash
