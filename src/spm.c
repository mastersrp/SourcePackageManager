#include "spm.h"
#include "script.h"
#include "options.h"

int main( int argc, char **argv ) {
	spm_log_setoutput( ".spm/log" );
	spm_script_init();
	spm_script_openlibs();
	spm_script_dofile( ".spm/paklib/main.lua" );
	spm_script_deinit();
	return 0;
}
