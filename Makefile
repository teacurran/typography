THIS_FILE := $(lastword $(MAKEFILE_LIST))
PROJECT_NAME = $(notdir $(PWD))
CMD_ARGUMENTS ?= $(cmd)
.PHONY: build

build:
	docker build -t fontforge:latest -f ./src/main/docker/fontforge.dockerfile ./src/main/docker/
	docker run -v `pwd`:/app -w `pwd` fontforge fontforge -script /app/src/main/fontforge/generate_otf.pe /app/src/main/sfd/ransom-threat.sfd