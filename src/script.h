#ifndef SPM_SCRIPT_H
#define SPM_SCRIPT_H
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#define SPM_SCRIPT_FUNCTION(name) static int name(lua_State *vm)
#ifdef _DEBUG_
	#define SPM_SCRIPT_DEBUG 1
#else
	#define SPM_SCRIPT_DEBUG 0
#endif

lua_State *spm_script_init();
int spm_script_openlibs( lua_State *vm );
int spm_script_sendargs( lua_State *vm, char **argv );
int spm_script_dostring( lua_State *vm, const char *str );
int spm_script_dofile( lua_State *vm, const char *file );
int spm_script_deinit( lua_State *vm );

int SPM_SCRIPT_LIBRARY_ADD_FUNCTION( lua_State *vm, const char *lib, int function, const char *function_name );

#endif /* SPM_SCRIPT_H */
