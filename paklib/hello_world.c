#include <tcclib.h>
#include <spm/spm.h>

int main( int argc, char *argv[] ) {
	printf( "Hello from TCC-compiled file!\n" );
	spm_log_setoutput( ".spm/log" );
	spm_log( "Hello from TCC-compiled file!\n", 1);
	return 0;
}
