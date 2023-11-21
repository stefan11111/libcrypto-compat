.POSIX:

XCFLAGS = ${CPPFLAGS} ${CFLAGS} -nostdlib -std=c99 -fPIC -pthread -D_XOPEN_SOURCE=700 \
		  -Wall -Wextra -Wpedantic -Wmissing-prototypes -Wstrict-prototypes \
		  -Wno-unused-parameter
XLDFLAGS = ${LDFLAGS} -shared -Wl,-soname,libcrypto.so.3

OBJ = libcrypto.o

all: libcrypto.so.3

.c.o:
	${CC} ${XCFLAGS} -c -o $@ $<

libcrypto.so.3: ${OBJ}
	${CC} ${XCFLAGS} -o $@ ${OBJ} ${XLDFLAGS}

install: libcrypto.so.3
	mkdir -p ${DESTDIR}/lib64
	cp -f libcrypto.so.3 ${DESTDIR}/lib64/libcrypto.so.3
	ln -rsf ${DESTDIR}/lib64/libcrypto.so.3 ${DESTDIR}/lib64/libcrypto.so
uninstall:
	rm -f ${DESTDIR}/lib64/libcrypto.so.3 ${DESTDIR}/lib64/libcrypto.so

clean:
	rm -f libcrypto.so.3 ${OBJ}

.PHONY: all clean install uninstall
