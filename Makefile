
PROJECT_NAME = uvtestbed

BUILD_DIR = build
SOURCE_DIR = src
INCLUDE_DIR = include

DEPS = jemalloc zlib libuv
LIBS = lib/lib$(PROJECT_NAME).a
BINS = bin/$(PROJECT_NAME)

JEMALLOC_LIB = libjemalloc.a
ZLIB_LIB = libz.a
LIBUV_LIB = uv.a

.PHONY: default deps $(DEPS) compile test all install

all: compile test
default: compile

deps: $(DEPS)
compile: $(DEPS) $(LIBS) $(BINS)

jemalloc: $(BUILD_DIR)/$(JEMALLOC_LIB)
zlib: $(BUILD_DIR)/$(ZLIB_LIB)
libuv: $(BUILD_DIR)/$(LIBUV_LIB)

$(BUILD_DIR)/$(JEMALLOC_LIB):
	cd deps/jemalloc && autoconf && ./configure && $(MAKE)
	cp deps/jemalloc/lib/libjemalloc.a $@

$(BUILD_DIR)/$(ZLIB_LIB):
	cd deps/zlib && ./configure --static && $(MAKE)
	cp deps/zlib/libz.a $@

$(BUILD_DIR)/$(LIBUV_LIB):
	cd deps/libuv && make
	cp deps/libuv/uv.a $@

