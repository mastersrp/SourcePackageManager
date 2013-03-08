#ifndef SPM_PACKAGE_H
#define SPM_PACKAGE_H
#include "script.h"

struct package_t {
	char *category;
	char *name;
	char *version;
};

int spm_package_retrieve( struct package_t *package );
int spm_package_configure( struct package_t *package );

#endif /* SPM_PACKAGE_H */
