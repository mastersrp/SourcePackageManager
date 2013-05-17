#include "script.h"

int spm_script_error( lua_State *vm, int err) {
	if( err ) {
		fprintf(stderr,"lua: %s\n", lua_tostring(vm,-1) );
		return err;
	}
	return 0;
}
lua_State *spm_script_init() {
	lua_State *vm = luaL_newstate();
	lua_pushboolean(vm,SPM_SCRIPT_DEBUG);
	lua_setglobal(vm,"DEBUG");
	return vm;
}
/*
 * Following function is pretty much taken directly from lua 'static int getargs (lua_State *L, char **argv, int n).
 * The below function is a slightly modified version of that.
 */
int spm_script_sendargs( lua_State *vm, char **argv ) {
	int i;
	int argc = 0;
	while( argv[argc]) argc++;
	lua_createtable(vm,argc,0);
	for( i=0; i<argc; i++ ) {
		lua_pushstring(vm,argv[i]);
		lua_rawseti(vm,-2, i);
	}
	lua_setglobal( vm, "arg" );
	return 0;
}
int spm_script_openlibs( lua_State *vm ) {
	luaL_openlibs(vm);
	return 0;
}
int spm_script_dostring( lua_State *vm, const char *str ) {
	int err = luaL_dostring(vm,str);
	return spm_script_error(vm,err);
}
int spm_script_dofile( lua_State *vm, const char *file ) {
	int err = luaL_loadfile(vm,file);
	if( err ) { return spm_script_error(vm,err); }
	err = lua_pcall(vm,0,LUA_MULTRET,0);
	return spm_script_error(vm,err);
}
int spm_script_deinit( lua_State *vm ) {
	lua_close(vm);
	return 0;
}

int SPM_SCRIPT_LIBRARY_ADD_FUNCTION( lua_State *vm, const char *lib, int function, const char *function_name ) {
	lua_getglobal(vm,lib);
	lua_gettable(vm,-1);
	lua_pushstring(vm,function_name);
	lua_pushcfunction(vm,function);
	lua_rawset(vm,-3);
	return 0;
}
