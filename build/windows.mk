# windows全静态编译

CC := x86_64-w64-mingw32-clang

AR := x86_64-w64-mingw32-llvm-ar rcs

RANLIB := x86_64-w64-mingw32-llvm-ranlib

SRC := ../src

CFLAGS := -O2 -Wall -Wextra -DLUA_COMPAT_5_3

LDFLAGS := -static

LUA_A :=	liblua.a

INC := $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lualib.h $(SRC)/lauxlib.h $(SRC)/lua.hpp

CORE_O :=	lapi.o lcode.o lctype.o ldebug.o ldo.o ldump.o lfunc.o lgc.o llex.o lmem.o lobject.o lopcodes.o lparser.o lstate.o lstring.o ltable.o ltm.o lundump.o lvm.o lzio.o
LIB_O :=	lauxlib.o lbaselib.o lcorolib.o ldblib.o liolib.o lmathlib.o loadlib.o loslib.o lstrlib.o ltablib.o lutf8lib.o linit.o
BASE_O := 	$(CORE_O) $(LIB_O)

LUA_T :=	lua.exe
LUA_O :=	lua.o

LUAC_T :=	luac.exe
LUAC_O :=	luac.o

ALL_O := $(BASE_O) $(LUA_O) $(LUAC_O)
ALL_T := $(LUA_A) $(LUA_T) $(LUAC_T)
ALL_A := $(LUA_A)

.phony: all clean include

all: $(ALL_T) include

include: $(INC)
	cp $^ ./

$(LUA_A): $(BASE_O)
	$(AR) $@ $(BASE_O)
	$(RANLIB) $@

$(LUA_T): $(LUA_O) $(LUA_A)
	$(CC) -o $@ $(LDFLAGS) $(LUA_O) $(LUA_A) $(LIBS)

$(LUAC_T): $(LUAC_O) $(LUA_A)
	$(CC) -o $@ $(LDFLAGS) $(LUAC_O) $(LUA_A) $(LIBS)

llex.o:
	$(CC) $(CFLAGS) -c $(SRC)/llex.c

lparser.o:
	$(CC) $(CFLAGS) -c $(SRC)/lparser.c

lcode.o:
	$(CC) $(CFLAGS) -c $(SRC)/lcode.c

lapi.o: $(SRC)/lapi.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lapi.h $(SRC)/llimits.h $(SRC)/lstate.h \
 $(SRC)/lobject.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/ldebug.h $(SRC)/ldo.h $(SRC)/lfunc.h $(SRC)/lgc.h $(SRC)/lstring.h \
 $(SRC)/ltable.h $(SRC)/lundump.h $(SRC)/lvm.h
	$(CC) $(CFLAGS) -c $< -o $@

lauxlib.o: $(SRC)/lauxlib.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lauxlib.h
	$(CC) $(CFLAGS) -c $< -o $@

lbaselib.o: $(SRC)/lbaselib.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lauxlib.h $(SRC)/lualib.h
	$(CC) $(CFLAGS) -c $< -o $@

lcorolib.o: $(SRC)/lcorolib.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lauxlib.h $(SRC)/lualib.h
	$(CC) $(CFLAGS) -c $< -o $@

lctype.o: $(SRC)/lctype.c $(SRC)/lprefix.h $(SRC)/lctype.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/llimits.h
	$(CC) $(CFLAGS) -c $< -o $@

ldblib.o: $(SRC)/ldblib.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lauxlib.h $(SRC)/lualib.h
	$(CC) $(CFLAGS) -c $< -o $@

ldebug.o: $(SRC)/ldebug.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lapi.h $(SRC)/llimits.h $(SRC)/lstate.h \
 $(SRC)/lobject.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/lcode.h $(SRC)/llex.h $(SRC)/lopcodes.h $(SRC)/lparser.h \
 $(SRC)/ldebug.h $(SRC)/ldo.h $(SRC)/lfunc.h $(SRC)/lstring.h $(SRC)/lgc.h $(SRC)/ltable.h $(SRC)/lvm.h
	$(CC) $(CFLAGS) -c $< -o $@

ldo.o: $(SRC)/ldo.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lapi.h $(SRC)/llimits.h $(SRC)/lstate.h \
 $(SRC)/lobject.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/ldebug.h $(SRC)/ldo.h $(SRC)/lfunc.h $(SRC)/lgc.h $(SRC)/lopcodes.h \
 $(SRC)/lparser.h $(SRC)/lstring.h $(SRC)/ltable.h $(SRC)/lundump.h $(SRC)/lvm.h
	$(CC) $(CFLAGS) -c $< -o $@

ldump.o: $(SRC)/ldump.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lobject.h $(SRC)/llimits.h $(SRC)/lstate.h \
 $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/lundump.h
	$(CC) $(CFLAGS) -c $< -o $@

lfunc.o: $(SRC)/lfunc.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/ldebug.h $(SRC)/lstate.h $(SRC)/lobject.h \
 $(SRC)/llimits.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/ldo.h $(SRC)/lfunc.h $(SRC)/lgc.h
	$(CC) $(CFLAGS) -c $< -o $@

lgc.o: $(SRC)/lgc.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/ldebug.h $(SRC)/lstate.h $(SRC)/lobject.h \
 $(SRC)/llimits.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/ldo.h $(SRC)/lfunc.h $(SRC)/lgc.h $(SRC)/lstring.h $(SRC)/ltable.h
	$(CC) $(CFLAGS) -c $< -o $@

linit.o: $(SRC)/linit.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lualib.h $(SRC)/lauxlib.h
	$(CC) $(CFLAGS) -c $< -o $@

liolib.o: $(SRC)/liolib.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lauxlib.h $(SRC)/lualib.h
	$(CC) $(CFLAGS) -c $< -o $@

lmathlib.o: $(SRC)/lmathlib.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lauxlib.h $(SRC)/lualib.h
	$(CC) $(CFLAGS) -c $< -o $@

lmem.o: $(SRC)/lmem.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/ldebug.h $(SRC)/lstate.h $(SRC)/lobject.h \
 $(SRC)/llimits.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/ldo.h $(SRC)/lgc.h
	$(CC) $(CFLAGS) -c $< -o $@

loadlib.o: $(SRC)/loadlib.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lauxlib.h $(SRC)/lualib.h
	$(CC) $(CFLAGS) -c $< -o $@

lobject.o: $(SRC)/lobject.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lctype.h $(SRC)/llimits.h \
 $(SRC)/ldebug.h $(SRC)/lstate.h $(SRC)/lobject.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/ldo.h $(SRC)/lstring.h $(SRC)/lgc.h \
 $(SRC)/lvm.h
	$(CC) $(CFLAGS) -c $< -o $@

lopcodes.o: $(SRC)/lopcodes.c $(SRC)/lprefix.h $(SRC)/lopcodes.h $(SRC)/llimits.h $(SRC)/lua.h $(SRC)/luaconf.h
	$(CC) $(CFLAGS) -c $< -o $@

loslib.o: $(SRC)/loslib.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lauxlib.h $(SRC)/lualib.h
	$(CC) $(CFLAGS) -c $< -o $@

lstate.o: $(SRC)/lstate.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lapi.h $(SRC)/llimits.h $(SRC)/lstate.h \
 $(SRC)/lobject.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/ldebug.h $(SRC)/ldo.h $(SRC)/lfunc.h $(SRC)/lgc.h $(SRC)/llex.h \
 $(SRC)/lstring.h $(SRC)/ltable.h
	$(CC) $(CFLAGS) -c $< -o $@

lstring.o: $(SRC)/lstring.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/ldebug.h $(SRC)/lstate.h \
 $(SRC)/lobject.h $(SRC)/llimits.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/ldo.h $(SRC)/lstring.h $(SRC)/lgc.h
	$(CC) $(CFLAGS) -c $< -o $@

lstrlib.o: $(SRC)/lstrlib.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lauxlib.h $(SRC)/lualib.h
	$(CC) $(CFLAGS) -c $< -o $@

ltable.o: $(SRC)/ltable.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/ldebug.h $(SRC)/lstate.h $(SRC)/lobject.h \
 $(SRC)/llimits.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/ldo.h $(SRC)/lgc.h $(SRC)/lstring.h $(SRC)/ltable.h $(SRC)/lvm.h
	$(CC) $(CFLAGS) -c $< -o $@

ltablib.o: $(SRC)/ltablib.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lauxlib.h $(SRC)/lualib.h
	$(CC) $(CFLAGS) -c $< -o $@

ltm.o: $(SRC)/ltm.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/ldebug.h $(SRC)/lstate.h $(SRC)/lobject.h \
 $(SRC)/llimits.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/ldo.h $(SRC)/lgc.h $(SRC)/lstring.h $(SRC)/ltable.h $(SRC)/lvm.h
	$(CC) $(CFLAGS) -c $< -o $@

lua.o: $(SRC)/lua.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lauxlib.h $(SRC)/lualib.h
	$(CC) $(CFLAGS) -c $< -o $@

luac.o: $(SRC)/luac.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lauxlib.h $(SRC)/ldebug.h $(SRC)/lstate.h \
 $(SRC)/lobject.h $(SRC)/llimits.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/lopcodes.h $(SRC)/lopnames.h $(SRC)/lundump.h
	$(CC) $(CFLAGS) -c $< -o $@

lundump.o: $(SRC)/lundump.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/ldebug.h $(SRC)/lstate.h \
 $(SRC)/lobject.h $(SRC)/llimits.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/ldo.h $(SRC)/lfunc.h $(SRC)/lstring.h $(SRC)/lgc.h \
 $(SRC)/lundump.h
	$(CC) $(CFLAGS) -c $< -o $@

lutf8lib.o: $(SRC)/lutf8lib.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/lauxlib.h $(SRC)/lualib.h
	$(CC) $(CFLAGS) -c $< -o $@

lvm.o: $(SRC)/lvm.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/ldebug.h $(SRC)/lstate.h $(SRC)/lobject.h \
 $(SRC)/llimits.h $(SRC)/ltm.h $(SRC)/lzio.h $(SRC)/lmem.h $(SRC)/ldo.h $(SRC)/lfunc.h $(SRC)/lgc.h $(SRC)/lopcodes.h $(SRC)/lstring.h \
 $(SRC)/ltable.h $(SRC)/lvm.h $(SRC)/ljumptab.h
	$(CC) $(CFLAGS) -c $< -o $@

lzio.o: $(SRC)/lzio.c $(SRC)/lprefix.h $(SRC)/lua.h $(SRC)/luaconf.h $(SRC)/llimits.h $(SRC)/lmem.h $(SRC)/lstate.h \
 $(SRC)/lobject.h $(SRC)/ltm.h $(SRC)/lzio.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	@rm *.o *.a *.exe *.h *.hpp
