#include "fs.h"

DIR *spm_fs_get_xdg_data_home() {
	DIR *dp;
	char *env_xdg_data_home = getenv("XDG_DATA_HOME");
	if( env_xdg_data_home == NULL ) {
		return NULL;
	} else {
		dp = opendir(env_xdg_data_home);
		if( dp != NULL ) {
			return dp;
		}
		return NULL;
	}
}

DIR *spm_fs_get_xdg_config_home() {
	DIR *dp;
	char *env_xdg_config_home = getenv("XDG_CONFIG_HOME");
	if( env_xdg_config_home == NULL ) {
		return NULL;
	} else {
		dp = opendir( env_xdg_config_home );
		if( dp != NULL ) {
			return dp;
		}
		return NULL;
	}
}

DIR *spm_fs_get_home() {
	DIR *dp;
	char *env_home = getenv("HOME");
	if( env_home == NULL ) {
		return NULL;
	} else {
		dp = opendir( env_home );
		if ( dp != NULL ) {
			return dp;
		}
		return NULL;
	}
}
