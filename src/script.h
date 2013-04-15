#ifndef SPM_SCRIPT_H
#define SPM_SCRIPT_H
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#define SPM_SCRIPT_FUNCTION(name) int name(lua_State *vm)
#ifdef _DEBUG_
	const int SPM_SCRIPT_DEBUG = 1;
#else
	const int SPM_SCRIPT_DEBUG = 0;
#endif

lua_State *spm_script_init();
int spm_script_openlibs( lua_State *vm );
int spm_script_sendargs( lua_State *vm, int argc, char *argv[] );
int spm_script_dostring( lua_State *vm, const char *str );
int spm_script_dofile( lua_State *vm, const char *file );
int spm_script_deinit( lua_State *vm );

#endif /* SPM_SCRIPT_H */
