#ifndef AD_HOC_HIBERNATE_H
#define AD_HOC_HIBERNATE_H

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>

#define STATEFILE "/sys/power/state"
#define STATETYPE "disk"

#define Err(str) fprintf(stderr, "Error: %s. \n", (str))
#define Errno(str) fprintf(stderr, "Error: %s: %s.\n", (str), strerror(errno))
#define Substr(ss, s) (strstr((ss), (s)) == 0)

#endif
