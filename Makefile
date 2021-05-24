SHELL:=/bin/bash
.PHONY: all go json md html clean 

# Path Related
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

RELEASE?=v1alpha1

# Temporary generated golang model file and directory
TMP_GO_PACKAGE := ${MKFILE_DIR}${RELEASE}/easemesh
TMP_DIR := ${TMP_GO_PACKAGE}/api/${RELEASE}

# Target doc files 
MD_FILENAME := meshmodel.md
HTML_FILENAME := meshmodel.html
GO_FILENAME := meshmodel.pb.go
JSON_FILENAME := meshmodel.json

PROTO := $(shell find ${MKFILE_DIR}${RELEASE} -type f -name "*.proto") 

go: ${PROTO} 
	@echo "generate golang file from proto: ${PROTO} "
		@echo ""
	protoc -I ${MKFILE_DIR}${RELEASE} --go_out=${MKFILE_DIR}${RELEASE}/ ${PROTO}  && \
	cp ${TMP_DIR}/*.go ${MKFILE_DIR}${RELEASE}  && \
	rm -rf ${TMP_GO_PACKAGE}

md:  ${PROTO}
	@echo "generate markdown file from proto: ${PROTO} "
		@echo ""
	protoc -I ${MKFILE_DIR}${RELEASE} --doc_out=${MKFILE_DIR}${RELEASE}/ ${PROTO} --doc_opt=markdown,${MD_FILENAME}

html: ${PROTO}
	@echo "generate html from proto: ${PROTO} "
		@echo ""
	protoc -I ${MKFILE_DIR}${RELEASE} --doc_out=${MKFILE_DIR}${RELEASE}/ ${PROTO} --doc_opt=html,${HTML_FILENAME}

json: ${PROTO}
	@echo "generate json from proto: ${PROTO} "
	@echo ""
	protoc -I ${MKFILE_DIR}${RELEASE} --doc_out=${MKFILE_DIR}${RELEASE}/ ${PROTO} --doc_opt=json,${JSON_FILENAME}

all: go json md html

clean: 
	@echo "clean temporary directory, and generated golang and doc files"
	rm -rf ${TMP_GO_PACKAGE} &&\
	rm ${MKFILE_DIR}${RELEASE}/${MD_FILENAME} && \
	rm ${MKFILE_DIR}${RELEASE}/${HTML_FILENAME} && \
	rm ${MKFILE_DIR}${RELEASE}/${GO_FILENAME} && \
	rm ${MKFILE_DIR}${RELEASE}/${JSON_FILENAME} 

