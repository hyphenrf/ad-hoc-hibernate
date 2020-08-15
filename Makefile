#
# Makefile for ad-hoc-hibernate

CC     ?= tcc
CFLAGS ?= -Wall -std=c11

DESTDIR ?= /
PREFIX  ?= usr/local/
BINDIR  ?= $(DESTDIR)$(PREFIX)bin/
EXE   := hb
MODE  := 4710
GROUP := wheel
CFILES := ad-hoc-hibernate.c
HFILES := ad-hoc-hibernate.h


$(EXE): $(CFILES) $(HFILES)
	$(CC) $(CFLAGS) $(CFILES) -o $(EXE)

install: $(EXE)
	-strip $(EXE)
	@mkdir -p $(BINDIR)
	install -m $(MODE) -o root -g $(GROUP) -s $(EXE) $(BINDIR)

clean:
	rm -f $(EXE)

uninstall:
	rm -f $(BINDIR)$(EXE)


.PHONY: clean install uninstall
# vim:ft=make
#
