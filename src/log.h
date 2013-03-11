#ifndef SPM_LOG_H
#define SPM_LOG_H
#ifdef __RUN__
	#include <tcclib.h>
#else
	#include <stdio.h>
#endif

int spm_log( const char *msg, int split_output );
int spm_log_setoutput( const char *filename );

#endif /* SPM_LOG_H */
