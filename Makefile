THIS_FILE := $(lastword $(MAKEFILE_LIST))
PROJECT_NAME = $(notdir $(PWD))
CMD_ARGUMENTS ?= $(cmd)
.PHONY: build

build_docker:
	docker build -t fontforge:latest -f ./src/main/docker/fontforge.dockerfile ./src/main/docker/

build: build_docker
	docker run -v `pwd`:/app -w `pwd` fontforge python3 /app/src/main/fontforge/generate_otf.py /app/src/main/sfd/ransom-threat.sfd /app/rendered/otf/ransom-threat.otf

set_version: build_docker
	if [ -z "$(FILE)" ]; then \
		echo 'syntax: FILE=font_name.otf make set_version'; \
	else \
		docker run -v `pwd`:/app -w `pwd` fontforge python3 /app/src/main/fontforge/set_version.py /app/src/main/sfd/$(FILE); \
	fi
