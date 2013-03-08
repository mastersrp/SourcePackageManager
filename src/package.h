#ifndef SPM_PACKAGE_H
#define SPM_PACKAGE_H
#include "build.h"

struct spm_package_t {
	char *category;
	char *name;
	char *version;
	enum SPM_BUILDSYSTEM_TYPE buildsystem;
};

int spm_package_retrieve( struct spm_package_t *package );
int spm_package_configure( struct spm_package_t *package );

#endif /* SPM_PACKAGE_H */
