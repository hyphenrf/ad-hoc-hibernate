/* vim:set noet sts=0 sw=0 ts=2 tw=80:
 * 
 * adhoc-hibernate.c
 * Copyleft (C) 2020 hyphenrf
 *
 * distributed under the terms of MIT license
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define STATEFILE "/sys/power/state"
#define STATETYPE "disk"


void err(char *str)
{
	fprintf(stderr, "\e[31mError: %s \e[0m\n", str);
}

int main()
{
	FILE *state;
	char buf[32]; /* There are at most "mem freeze disk standby" entries
								** in /sys/power/state .. Which are in total 24 bytes */
	
	state = fopen(STATEFILE, "r");

	if (state) {
		fgets(buf, 32, state);
		rewind(state);
		
		if (strstr(buf, STATETYPE) != NULL) {
			if (freopen(NULL, "w", state) != NULL) {
				puts("Suspending to disk...");
				fputs(STATETYPE, state);
				fclose(state);

			} else {
				err("can't write to "STATEFILE". Are you privileged?");
				goto error;
			}	
		} else {
			err("kernel reported that this system doesn't support suspend to disk.");
			fclose(state);
			goto error;
		}
	} else {
		err(""STATEFILE" does not exist.");
		goto error;
	}


	return EXIT_SUCCESS;

error:
	return EXIT_FAILURE;
}
