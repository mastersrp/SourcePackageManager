#include "script.h"

lua_State *vm;

int spm_script_init() {
	vm = luaL_newstate();
}
int spm_script_openlibs() {
	luaL_openlibs(vm);
}
int spm_script_dostring( const char *str ) {
	luaL_dostring(vm,str);
}
int spm_script_deinit() {
	lua_close(vm);
}
