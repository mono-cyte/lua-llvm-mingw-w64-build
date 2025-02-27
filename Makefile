SHELL = cmd

buildDir = build
installDir = install

binDir = $(installDir)\bin
libDir = $(installDir)\lib
includeDir = $(installDir)\include

.PHONY: all install uninstall build clean

all: build-windows install

install:
	if not exist "$(binDir)" mkdir "$(binDir)"
	if not exist "$(libDir)" mkdir "$(libDir)"
	if not exist "$(includeDir)" mkdir "$(includeDir)"
	copy $(buildDir)\*.exe $(binDir)
	copy $(buildDir)\*.a $(libDir)
	copy $(buildDir)\*.h $(includeDir)
	copy $(buildDir)\*.hpp $(includeDir)

uninstall:
	if exist "$(binDir)" rmdir /s /q "$(binDir)"
	if exist "$(libDir)" rmdir /s /q "$(libDir)"
	if exist "$(includeDir)" rmdir /s /q "$(includeDir)"

build:
	cd $(buildDir) && make -f windows.mk all

clean:
	cd $(buildDir) && make -f windows.mk clean