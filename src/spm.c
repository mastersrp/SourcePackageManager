#include <stdio.h>

#include "script.h"

const char *hello_from_lua = "io.output():write('Hello world, lua calling!\\n')";

int main( int argc, char **argv ) {
	printf( "Hello world\n" );
	script_init();
	script_openlibs();
	script_dostring( hello_from_lua );
	script_deinit();
	return 0;
}
