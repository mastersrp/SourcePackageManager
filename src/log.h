#ifndef SPM_LOG_H
#define SPM_LOG_H
#include <stdio.h>

int spm_log( const char *msg, int split_output );
int spm_log_setoutput( const char *filename );

#endif /* SPM_LOG_H */
