#ifndef SPM_BUILD_H
#define SPM_BUILD_H
#include "package.h"

enum SPM_BUILDSYSTEM_TYPE {
	AUTO = 0,
	AUTOGEN = 1,
	CONFIGURE = 2,
	CMAKE = 3,
	MAKE = 4
};

#endif /* SPM_BUILD_H */
