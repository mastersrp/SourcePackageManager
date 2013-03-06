#include <stdio.h>

#include "script.h"

const char *hello_from_lua = "io.output():write('Hello world, lua calling!\\n')";
const char *tcc_run = "os.execute('tcc -run .spm/paklib/hello_world.c')";

int main( int argc, char **argv ) {
	printf( "Hello world\n" );
	spm_script_init();
	spm_script_openlibs();
	spm_script_dostring( hello_from_lua );
	printf( "Attempting to test tcc calls from lua...\n");
	spm_script_dostring( tcc_run );
	spm_script_deinit();
	return 0;
}
