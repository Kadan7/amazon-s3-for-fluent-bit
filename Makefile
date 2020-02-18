# Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
# 	http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

ROOT := $(shell pwd)

all: build

SCRIPT_PATH := $(ROOT)/scripts/:${PATH}
SOURCES := $(shell find . -name '*.go')
PLUGIN_BINARY := ./bin/s3.so

.PHONY: build
build: $(PLUGIN_BINARY)

$(PLUGIN_BINARY): $(SOURCES)
	PATH=${PATH} golint ./s3
	mkdir -p ./bin
	go build -buildmode c-shared -o $(PLUGIN_BINARY) ./
	@echo "Built Amazon S3 Fluent Bit Plugin"

.PHONY: release
release:
	mkdir -p ./bin
	go build -buildmode c-shared -o $(PLUGIN_BINARY) ./
	@echo "Built Amazon s3 Fluent Bit Plugin"


.PHONY: clean
clean:
	rm -rf ./bin/*
