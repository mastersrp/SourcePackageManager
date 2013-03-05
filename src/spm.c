#include <stdio.h>

#include "script.h"

const char *hello_from_lua = "io.output():write('Hello world, lua calling!\\n')";
const char *tcc_run = "os.execute('tcc -run .spm/paklib/hello_world.c')";

int main( int argc, char **argv ) {
	printf( "Hello world\n" );
	script_init();
	script_openlibs();
	script_dostring( hello_from_lua );
	printf( "Attempting to test tcc calls from lua...\n");
	script_dostring( tcc_run );
	script_deinit();
	return 0;
}
