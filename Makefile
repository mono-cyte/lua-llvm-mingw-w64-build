buildDir = build
installDir = install

binDir = $(installDir)/bin
libDir = $(installDir)/lib
includeDir = $(installDir)/include

.PHONY: all install uninstall build clean

all: build-windows install

install:
	mkdir "$(binDir)"
	mkdir "$(libDir)"
	mkdir "$(includeDir)"
	cp $(buildDir)/*.exe $(binDir)
	cp $(buildDir)/*.a $(libDir)
	cp $(buildDir)/*.h $(includeDir)
	cp $(buildDir)/*.hpp $(includeDir)

uninstall:
	rm -rf "$(binDir)"
	rm -rf "$(libDir)"
	rm -rf "$(includeDir)"

build:
	cd $(buildDir) && make -f windows.mk all

clean:
	cd $(buildDir) && make -f windows.mk clean

test:
	cp $(buildDir)/lua.exe $(binDir)