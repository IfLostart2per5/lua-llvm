BUILD_DIR ?= $(abspath build/)

BUSTED_FLAGS := --shuffle --cpath=./build/?.so

all: build

build:
	rm -rf $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)
	(cd $(BUILD_DIR) && cmake ..)
	(cd $(BUILD_DIR) && make)

test: build
	busted $(BUSTED_FLAGS)

ci-test:
	busted -c -Xhelper travis,env=full --verbose $(BUSTED_FLAGS)


doc:
	(cd $(BUILD_DIR) && cmake -D USE_PRE_GENERATED_BINDINGS=FALSE -D GENERATE_LUADOCS=TRUE ..)

clean:
	rm -rf $(BUILD_DIR)

.PHONY: test clean build
