
PROJECT_NAME = uvtestbed

BUILD_DIR = build
SOURCE_DIR = src
INCLUDE_DIR = include

LIB_DIR = $(BUILD_DIR)/lib
BIN_DIR = $(BUILD_DIR)/bin

DEPS = jemalloc zlib libuv fnmatch
LIBS = $(LIB_DIR)/lib$(PROJECT_NAME).a
BINS = $(BIN_DIR)/$(PROJECT_NAME)

JEMALLOC_LIB = libjemalloc.a
ZLIB_LIB = libz.a
LIBUV_LIB = uv.a
FNMATCH_LIB = fnmatch.a

CFLAGS = -pthread -Iinclude -Ideps/jemalloc/ -Ideps/libuv/include/ -Ideps/zlib/ -Ideps/fnmatch/include/
LDFLAGS = -ldl -lrt -lm

.PHONY: default deps $(DEPS) compile test all clean install

all: compile test
default: compile

deps: $(DEPS)
compile: $(DEPS) $(LIBS) $(BINS)

jemalloc: $(LIB_DIR)/$(JEMALLOC_LIB)
zlib: $(LIB_DIR)/$(ZLIB_LIB)
libuv: $(LIB_DIR)/$(LIBUV_LIB)
fnmatch: $(LIB_DIR)/$(FNMATCH_LIB)

$(LIB_DIR)/$(JEMALLOC_LIB):
	mkdir -p $(LIB_DIR)
	cd deps/jemalloc && $(MAKE)
	cp deps/jemalloc/$(JEMALLOC_LIB) $@

$(LIB_DIR)/$(LIBUV_LIB):
	mkdir -p $(LIB_DIR)
	cd deps/libuv && $(MAKE)
	cp deps/libuv/$(LIBUV_LIB) $@

$(LIB_DIR)/$(ZLIB_LIB):
	mkdir -p $(LIB_DIR)
	cd deps/zlib && ./configure --static && $(MAKE)
	cp deps/zlib/$(ZLIB_LIB) $@

$(LIB_DIR)/$(FNMATCH_LIB):
	mkdir -p $(LIB_DIR)
	cd deps/fnmatch && $(MAKE)
	cp deps/fnmatch/$(FNMATCH_LIB) $@

$(BIN_DIR)/$(PROJECT_NAME): src/main.c $(DEPS)
	mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) \
	  -Iinclude -Ideps/jemalloc/ -Ideps/libuv/include/ -Ideps/zlib/ -o $@ $< \
	  $(LIB_DIR)/$(JEMALLOC_LIB) $(LIB_DIR)/$(LIBUV_LIB) $(LIB_DIR)/$(ZLIB_LIB)
	 

$(LIB_DIR)/lib$(PROJECT_NAME).a:
	mkdir -p $(LIB_DIR)
	echo
