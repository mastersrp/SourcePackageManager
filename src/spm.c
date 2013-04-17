#include "spm.h"
#include "script.h"
#include "options.h"

int main( int argc, char **argv ) {
	spm_log_setoutput( ".spm/log" );
	lua_State *vm = NULL;
	vm = spm_script_init();
	if( vm == NULL ) {
		fprintf( stderr, "spm: Could not initialize Lua VM!\n" );
		return 1;
	}
	spm_script_openlibs( vm );
	//spm_script_sendargs( vm, argc, argv );
	spm_script_dofile( vm, ".spm/paklib/main.lua" );
	spm_script_deinit( vm );
	return 0;
}
