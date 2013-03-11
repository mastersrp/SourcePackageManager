#include "script.h"

lua_State *vm;

int spm_script_init() {
	vm = luaL_newstate();
	return 0;
}
int spm_script_openlibs() {
	luaL_openlibs(vm);
	return 0;
}
int spm_script_dostring( const char *str ) {
	luaL_dostring(vm,str);
	return 0;
}
int spm_script_dofile( const char *file ) {
	luaL_dostring(vm,file);
	return 0;
}
int spm_script_deinit() {
	lua_close(vm);
	return 0;
}
