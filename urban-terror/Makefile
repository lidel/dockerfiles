# make run    - Run UT in ephemeral container with limited fs permissions
# make update - Run UT Updater

# Where game data is located on host (unpacked UrbanTerror42_full023.zip)
URT_DATA = $(HOME)/local/opt/UrbanTerror4.2

# Where user data (config, downloaded maps) is located on host
USR_DATA = $(HOME)/.q3a

D	?= docker

# Build image if not present
image:
	test -n "$(shell docker images -f 'label=urban_terror' -q)" \
	|| (eval "echo \"$$(<Dockerfile)\"" 2> /dev/null | $(D) build -t urban_terror -)

# Execute binary command in ephemeral container with limited write permissions
exec-%: image
	xhost si:localuser:$(USER)
	$(D) run -it \
	-e DISPLAY=$(DISPLAY) \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e PULSE_SERVER=tcp:localhost:4713 \
	-e PULSE_COOKIE_DATA=$(shell pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*') \
	--device /dev/dri \
	--net=host \
	-v $(URT_DATA):/home/urt/UrbanTerror42:$(shell test "$*" = "Quake3-UrT.x86_64" && echo "ro" || echo "rw") \
	-v $(USR_DATA):/home/urt/.q3a:$(shell test "$*" = "UrTUpdater.x86_64" && echo "ro" || echo "rw") \
	--entrypoint="/home/urt/UrbanTerror42/$*" \
	--rm --name utr_$* urban_terror

run:    exec-Quake3-UrT.x86_64
update: exec-UrTUpdater.x86_64

remove-image:
	$(D) images -f 'label=urban_terror' -q | xargs -r $(D) rmi -f

rebuild-image: remove-image image
