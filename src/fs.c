#include "fs.h"
#include <stdio.h>
#include <sys/types.h>
#include <dirent.h>

SPM_SCRIPT_FUNCTION( io_dopen ) {
	SPM_SCRIPT_LIBRARY_ADD_FUNCTION(vm,"io",io_dopen,"dopen");
	int top = lua_gettop(vm);
	DIR *dp;
	const char *dir = lua_tostring(vm,-1);
	dp = opendir( dir );
	if ( dp != NULL ) {
		lua_pushlightuserdata(vm,dp);
		return 1;
	} else {
		return 0;
	}
}

SPM_SCRIPT_FUNCTION( io_dclose ) {
	SPM_SCRIPT_LIBRARY_ADD_FUNCTION(vm,"io",io_dclose,"dclose");
	int top = lua_gettop(vm);
	DIR *dp;
	dp = lua_touserdata(vm,-1);
	if( dp != NULL ) {
		(void)closedir(dp);
		return 1;
	} else {
		return 0;
	}
}
