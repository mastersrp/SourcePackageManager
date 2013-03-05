#ifndef SCRIPT_H
#define SCRIPT_H
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#define SCRIPT_FUNCTION(name) int name(lua_State *vm)

int script_init();
int script_openlibs();
int script_dostring( const char *str );
int script_deinit();

#endif /* SCRIPT_H */
