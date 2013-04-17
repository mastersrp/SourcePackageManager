#include "script.h"

int spm_script_error(vm,err) {
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
int spm_script_sendargs( lua_State *vm, int argc, char *argv[] ) {
	lua_createtable(vm,argc,0);
	int top = lua_gettop( vm );
	for( int i=0; i<argc; i++ ) {
		lua_pushstring( vm, argv[i] );
		lua_settable( vm, top );
	}
	lua_setglobal( vm, "ARGS" );
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
