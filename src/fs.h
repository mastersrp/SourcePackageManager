#ifndef SPM_FILESYSTEM_H
#define SPM_FILESYSTEM_H

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <dirent.h>

DIR *spm_fs_get_xdg_data_home();
DIR *spm_fs_get_xdg_config_home();

#endif /* SPM_FILESYSTEM_H */
