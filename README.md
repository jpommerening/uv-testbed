uv-testbed
==========

Testbed and starting-point for libuv based applications.

What's inside?
--------------

* libuv (obviously, source: [joyent/libuv](https://github.com/joyent/libuv "github: joyent/libuv"))
* jemalloc (because most libc implementations don't perform as well, source: [khuey/mozilla-jemalloc](https://github.com/khuey/mozilla-jemalloc))
* zlib (because small things are nice, source: [madler/zlib](https://github.com/madler/zlib "github: madler/zlib"))
* A Makefile and an XCode-project to tie it all together
