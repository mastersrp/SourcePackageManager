#include "spm.h"
#include "script.h"
#include "script/fs.h"
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
	// TODO: Below functions all cause segmentation faults. FIX!
	spm_script_sendargs( vm, argv );
	//SPM_SCRIPT_LIBRARY_ADD_FUNCTION(vm,"io",io_dclose,"dclose");
	//SPM_SCRIPT_LIBRARY_ADD_FUNCTION(vm,"io",io_dopen,"dopen");
	spm_script_dofile( vm, ".spm/paklib/main.lua" );
	spm_script_deinit( vm );
	return 0;
}
