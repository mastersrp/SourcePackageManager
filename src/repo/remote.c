#include "remote.h"

static void progress_cb( const char *str, int len, void *data )
{
	(void)data;
	printf("remote: %.*s",len,str);
	fflush(stdout);
}

static void *spm_repo_download( void *ptr )
{
	struct dl_data *data = (struct dl_data *)ptr;

	if( git_remote_connect(data->remote, GIT_DIRECTION_FETCH) < 0 ) {
		data->ret = -1;
		goto exit;
	}

	if( git_remote_download(data->remote,NULL,NULL) < 0 ) {
		data->ret = -1;
		goto exit;
	}

	data->ret = 0;

exit:
	data->finished = 1;
	return &data->ret;
}

static int update_cb( const char *refname, const git_oid *a, const git_oid *b, void *data ) {
	char a_str[GIT_OID_HEXSZ+1], b_str[GIT_OID_HEXSZ+1];
	(void)data;

	git_oid_fmt(b_str,b);
	b_str[GIT_OID_HEXSZ] = '\0';

	if( git_oid_iszero(a)) {
		printf("[new]    %.20s %s\n", b_str, refname);
	} else {
		git_oid_fmt(a_str,a);
		a_str[GIT_OID_HEXSZ] = '\0';
		printf( "[updated] %.10s..%.10s %s\n", a_str, b_str, refname);
	}

	return 0;
}


