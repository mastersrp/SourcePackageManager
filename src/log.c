#include "log.h"
const char *spm_log_filename;
FILE *spm_log_file;

int spm_log( const char *msg, int split_output ) {
	printf( msg );
	if( split_output == 0 ) {
		return 0;
	}
	spm_log_file = fopen( spm_log_filename, "a" );
	if( spm_log_file == NULL ) { return 1; }
	fprintf(spm_log_file, msg);
	fclose(spm_log_file);
	return 0;
}

int spm_log_setoutput( const char *filename ) {
	spm_log_file = fopen( filename, "w" );
	if ( spm_log_file == NULL ) {
		return 1;
	} else {
		spm_log_filename = filename;
		fclose(spm_log_file);
		return 0;
	}
}
