#include <stdio.h>
#include <uv.h>
#include <zlib.h>
#include "uv_testbed.h"

static void _async_callback( uv_async_t * async, int status ) {
  printf( "Async received!\n" );
}

static void _timer_callback( uv_timer_t * timer, int status ) {
  static int counter = 0;
  static int max     = 5;
  printf( "I'm a scheduled timer (%i / %i)!\n", counter++, max );
  if( counter > max ) {
    uv_timer_stop( timer );
    uv_unref( timer->loop );
  }
}

static void _thread_entry( void * arg ) {
  uv_loop_t * loop = uv_loop_new();
  uv_timer_t timer;
  uv_async_t * async = arg;
  uv_timer_init( loop, &timer );
  uv_timer_start( &timer, &_timer_callback, 1000, 1000 );
  
  printf( "I'm in a thread!\n" );
  
  uv_run( loop );
  
  uv_async_send( async );
}


int main( int argc, const char *argv[] ) {
  uv_loop_t * loop = uv_default_loop();
  uv_thread_t tid;
  uv_async_t  async;
  uv_async_init( loop, &async, &_async_callback );

  if( uv_thread_create( &tid, &_thread_entry, &async ) ) {
    perror( "Could not create thread." );
    return 1;
  } else {
    uv_run_once( loop );
    printf( "Joining thread!\n" );
    return uv_thread_join( &tid );
  }
}