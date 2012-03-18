#include <stdio.h>
#include <uv.h>
#include "uv_testbed.h"

int main( int argc, const char *argv[] ) {
  uv_loop_t * loop = uv_loop_new();
  return uv_run( loop );
}