#include "script.h"

lua_State *vm;

int script_init() {
	vm = luaL_newstate();
}
int script_openlibs() {
	luaL_openlibs(vm);
}
int script_dostring( const char *str ) {
	luaL_dostring(vm,str);
}
int script_deinit() {
	lua_close(vm);
}
