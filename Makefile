#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org/>
#

HANDLER ?= handler
PACKAGE ?= $(HANDLER)

RM := rm -f

MAKEFILE = $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))

docker:
	docker run -e HANDLER=$(HANDLER) \
		-e PACKAGE=$(PACKAGE) \
		-e LDFLAGS='$(LDFLAGS)' \
		-v $(CURDIR):/root/go/src/go-lambda.com \
		$(foreach GP,$(subst :, ,$(GOPATH)),-v $(GP):$(GP))\
		-w /root/go/src/go-lambda.com \
		go-lambda-helper:latest make -f $(MAKEFILE) all

.PHONY: docker

all: test build pack perm

.PHONY: all

test:
	go test ./...

.PHONY: test

build: dist
	go install -buildmode=plugin -ldflags='-w -s $(LDFLAGS)' ./src
	mv $(GOPATH)/pkg/linux_amd64_dynlink/go-lambda.com/src.a ./dist/$(HANDLER).so

.PHONY: build

pack:
	pack $(HANDLER) dist/$(HANDLER).so $(PACKAGE).zip
	mv $(PACKAGE).zip dist/

.PHONY: pack

perm:
	chown $(shell stat -c '%u:%g' .) dist/$(HANDLER).so dist/$(PACKAGE).zip

.PHONY: perm

clean:
	$(RM) dist/$(HANDLER).so dist/$(PACKAGE).zip

.PHONY: clean
