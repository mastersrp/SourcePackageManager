#ifndef SPM_REPO_REMOTE_H
#define SPM_REPO_REMOTE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <unistd.h>

#include <git2.h>

struct dl_data {
	git_remote *remote;
	int ret;
	int finished;
};

static void progress_cb( const char *str, int len, void *data );
static int update_cb( const char *refname, const git_oid *a, const git_oid *b, void *data );
static void *spm_repo_download( void *ptr );

#endif /* SPM_REPO_REMOTE_H */
