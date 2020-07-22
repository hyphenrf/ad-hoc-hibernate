#
# Makefile for ad-hoc-hibernate

CC= gcc
CFLAGS= -Wall -Wextra -std=c11 -Os
CFILE= ad-hoc-hibernate.c

PREFIX= /usr/local
MODE= 4710
SETGROUP= wheel

hb: $(CFILE)
	$(CC) $(CFLAGS) $(CFILE) -o hb

install: hb
	mkdir -p $(PREFIX)/bin
	install -m $(MODE) -o root -g $(SETGROUP) -s hb $(PREFIX)/bin

clean:
	rm -f hb

uninstall:
	rm -f $(PREFIX)/bin/hb

.PHONY: clean install uninstall
# vim:ft=make
#
