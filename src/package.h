#ifndef SPM_PACKAGE_H
#define SPM_PACKAGE_H

struct spm_package_t {
	char *category;
	char *name;
	char *version;
};

int spm_package_retrieve( struct spm_package_t *package );
int spm_package_configure( struct spm_package_t *package );

#endif /* SPM_PACKAGE_H */
