.PHONY: build install uninstall reinstall clean

FINDLIB_NAME=openssl
BUILD=_build/lib
SRC=lib
FLAGS=-package ctypes.foreign -package fd-send-recv -package tls-types
EXTRA_META=requires = \"ctypes.foreign fd-send-recv tls-types\"

CFLAGS=-fPIC -Wall -Wextra -Werror -std=c99

build:
	ocamlbuild -use-ocamlfind -I $(SRC) $(FLAGS) \
		-lflags -dllib,-lopenssl openssl.cma
	ocamlbuild -use-ocamlfind -I $(SRC) $(FLAGS) \
		-lflags -cclib,-lssl openssl.cmxa
	$(CC) $(SRC)/openssl_stubs.c -fPIC -shared -o $(BUILD)/dllopenssl.so -lssl

META: META.in
	cp META.in META
	echo $(EXTRA_META) >> META

install: META
	ocamlfind install $(FINDLIB_NAME) META \
		$(SRC)/openssl.mli \
		$(BUILD)/openssl.cmi \
		$(BUILD)/openssl.cma \
		$(BUILD)/openssl.cmxa \
		$(BUILD)/dllopenssl.so

uninstall:
	ocamlfind remove $(FINDLIB_NAME)

reinstall: uninstall install

clean:
	ocamlbuild -clean
	rm -f META
