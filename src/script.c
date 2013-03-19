#include "script.h"

lua_State *vm;

int spm_script_error(vm,err) {
	if( err ) {
		fprintf(stderr,"lua: %s\n", lua_tostring(vm,-1) );
		return err;
	}
	return 0;
}
int spm_script_init() {
	vm = luaL_newstate();
	lua_pushboolean(vm,SPM_SCRIPT_DEBUG);
	lua_setglobal(vm,"DEBUG");
	return 0;
}
int spm_script_openlibs() {
	luaL_openlibs(vm);
	return 0;
}
int spm_script_dostring( const char *str ) {
	int err = luaL_dostring(vm,str);
	return spm_script_error(vm,err);
}
int spm_script_dofile( const char *file ) {
	int err = luaL_dofile(vm,file);
	return spm_script_error(vm,err);
}
int spm_script_deinit() {
	lua_close(vm);
	return 0;
}
