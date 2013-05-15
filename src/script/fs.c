#include "fs.h"
#include "../fs.h"
#include <stdio.h>
#include <sys/types.h>
#include <dirent.h>

SPM_SCRIPT_FUNCTION( io_dopen ) {
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

SPM_SCRIPT_FUNCTION( io_dread ) {
	int top = lua_gettop(vm);
	DIR *dp;
	dp = lua_touserdata(vm,-1);
	if( dp != NULL ) {
		lua_newtable(vm);
		struct dirent *ep;
		while( ep = readdir(dp) ) {
			lua_pushnumber(vm,-1);
			lua_pushstring(vm, ep->d_name);
			lua_rawset(vm,-3);
		}
	} else {
		return 0;
	}
}

SPM_SCRIPT_FUNCTION( io_dclose ) {
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
