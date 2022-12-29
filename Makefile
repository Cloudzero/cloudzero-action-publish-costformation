# Copyright (c) 2022 CloudZero - ALL RIGHTS RESERVED - PROPRIETARY AND CONFIDENTIAL
# Unauthorized copying of this file and/or project, via any medium is strictly prohibited.
# Direct all questions to legal@cloudzero.com

SHELL:=/bin/bash

# Util constants
ERROR_COLOR = \033[1;31m
INFO_COLOR = \033[1;32m
WARN_COLOR = \033[1;33m
NO_COLOR = \033[0m

ifeq ('${uname}', 'Linux')
	platform=linux
else
	platform=darwin
endif

.PHONY: init                                     ## init dev environment
init:
	echo ${uname}
	mkdir -p bin
	curl -L https://github.com/mpalmer/action-validator/releases/download/v0.1.2/action-validator_${platform}_amd64 > ./bin/action-validator
	chmod +x ./bin/action-validator

.PHONY: lint
lint:
	./bin/action-validator action.yaml

.PHONY: clean
clean:
	rm -rf bin/