all: compile

LUA_VERSION=lua-5.4.7

install_lua:
	curl -L -R -O https://www.lua.org/ftp/$(LUA_VERSION).tar.gz
	tar zxvf $(LUA_VERSION).tar.gz
	cd $(CURDIR)/$(LUA_VERSION)
	sed -i 's#CFLAGS= -O2#CFLAGS= -O2 -fPIC#' $(CURDIR)/$(LUA_VERSION)/src/Makefile
	cd $(CURDIR)/$(LUA_VERSION) && make all
	cd $(CURDIR)/$(LUA_VERSION) && make local

# -fPIC 生成位置无关代码(Position-Independent Code)，这对于共享库是必需的，因为它允许代码在内存中被任意位置加载.
# -I 指定头文件搜索路径
# -L 指定动态库 .so 或 .a 静态库搜索路径
# -llua 链接到名为 lua 的库. gcc 会在 -L 指定的目录中查找这个库. 通常是 .so 或 .a 文件
compile:
	gcc mylib.c -Wall -fPIC -shared -o mylib.so -I$(CURDIR)/$(LUA_VERSION)/install/lib -L$(CURDIR)/$(LUA_VERSION)/src -llua

test:
	lua script.lua

clean:
	rm -f mylib.so
	rm -f $(CURDIR)/*.tar.gz
	rm -rf lua-*