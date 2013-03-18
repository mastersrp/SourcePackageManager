#include "spm.h"
#include "script.h"

const char *hello_from_lua = "io.output():write('Hello world, lua calling!\\n')";
const char *lua_tcc_run = "os.execute('tcc -I.spm/paklib/include -L.spm/paklib/lib -lspm -nostdinc -B.spm/paklib/include -D__RUN__ -bench -run .spm/paklib/hello_world.c')";

int main( int argc, char **argv ) {
	spm_log_setoutput( ".spm/log" );
	spm_log( "Hello world!\n", 1 );
	spm_script_init();
	spm_script_openlibs();
	spm_script_dostring( hello_from_lua );
	spm_log( "Attempting to test tcc calls from lua...\n", 1 );
	spm_script_dostring( lua_tcc_run );
	spm_script_deinit();
	return 0;
}
