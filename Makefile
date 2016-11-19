CFLAGS = -Os
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -Wno-unknown-pragmas
CFLAGS += -Werror-implicit-function-declaration
CFLAGS += -Werror
CFLAGS += -Wno-unused-parameter
CFLAGS += -Wdeclaration-after-statement
CFLAGS += -Wwrite-strings
CFLAGS += -Wstrict-prototypes
CFLAGS += -Wmissing-prototypes
CFLAGS += -Iinclude

all: cntest

test: cntest
	(cd test; env MallocStackLogging=true ../cntest) >new.out
	-diff new.out test/expected.out

cntest: src/cbor.h include/cn-cbor/cn-cbor.h src/cn-cbor.c src/cn-error.c src/cn-get.c test/test.c
	clang $(CFLAGS) src/cn-cbor.c src/cn-error.c src/cn-get.c test/test.c -o cntest

size: cn-cbor.o
	size cn-cbor.o
	size -m cn-cbor.o

cn-cbor.o: src/cn-cbor.c include/cn-cbor/cn-cbor.h src/cbor.h
	clang $(CFLAGS) -c src/cn-cbor.c

clean:
	$(RM) cntest *.o new.out 
