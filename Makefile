THIS_FILE := $(lastword $(MAKEFILE_LIST))
PROJECT_NAME = $(notdir $(PWD))
CMD_ARGUMENTS ?= $(cmd)
.PHONY: build

build:
	docker build -t fontforge:latest -f ./src/main/docker/fontforge.dockerfile ./src/main/docker/
