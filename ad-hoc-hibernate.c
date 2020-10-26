/* vim:set noet sts=0 sw=0 ts=2 tw=80:
 * 
 * adhoc-hibernate.c
 * Copyleft (C) 2020 hyphenrf
 *
 * distributed under the terms of MIT license
 */

#include "ad-hoc-hibernate.h"

int main()
{
	FILE *state;
	char buf[32]; /* There are at most "mem freeze disk standby" entries
	              ** in /sys/power/state .. Which are in total 24 bytes */
	errno = 0;


	state = fopen(STATEFILE, "r+");

	if (state) {
		fgets(buf, 32, state);

		/* File doesn't STATETYPE in it? bail */
		if (Substr(buf, STATETYPE)) {
			Err("kernel reported that this system doesn't support the '"STATETYPE"' state");
			goto error;
		}

		puts("Suspending with '"STATETYPE"' mode...");
		fputs(STATETYPE, state); /* psuedo files don't need to rewind or truncate */
	} else {
		Errno("can't operate on '"STATEFILE"'");
		goto error;
	}


	fclose(state);
	return EXIT_SUCCESS;

error:
	if (state) fclose(state); /* Unlike free, fclose can't handle NULL. It's UB */
	return EXIT_FAILURE;
}
