#ifndef SCRIPT_H
#define SCRIPT_H
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#define SCRIPT_FUNCTION(name) int name(lua_State *vm)

int spm_script_init();
int spm_script_openlibs();
int spm_script_dostring( const char *str );
int spm_script_deinit();

#endif /* SCRIPT_H */