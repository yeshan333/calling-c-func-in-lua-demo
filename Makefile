all: compile

LUA_CMP_VERSION_1=lua-5.4.7
LUA_CMP_VERSION_2=lua-5.4.6

install_lua: install_cmp2_lua
	curl -L -R -O https://www.lua.org/ftp/$(LUA_CMP_VERSION_1).tar.gz
	tar zxvf $(LUA_CMP_VERSION_1).tar.gz
	cd $(CURDIR)/$(LUA_CMP_VERSION_1)
	sed -i 's#CFLAGS= -O2#CFLAGS= -O2 -fPIC#' $(CURDIR)/$(LUA_CMP_VERSION_1)/src/Makefile
	cd $(CURDIR)/$(LUA_CMP_VERSION_1) && make all
	cd $(CURDIR)/$(LUA_CMP_VERSION_1) && make local

install_cmp2_lua:
	curl -L -R -O https://www.lua.org/ftp/$(LUA_CMP_VERSION_2).tar.gz
	tar zxvf $(LUA_CMP_VERSION_2).tar.gz
	cd $(CURDIR)/$(LUA_CMP_VERSION_2)
	sed -i 's#CFLAGS= -O2#CFLAGS= -O2 -fPIC#' $(CURDIR)/$(LUA_CMP_VERSION_2)/src/Makefile
	cd $(CURDIR)/$(LUA_CMP_VERSION_2) && make all
	cd $(CURDIR)/$(LUA_CMP_VERSION_2) && make local

test_cmp1:
	echo "Testing lua version: $(LUA_CMP_VERSION_1)"
	$(CURDIR)/$(LUA_CMP_VERSION_1)/install/bin/lua test_printer.lua

test_cmp2:
	echo "Testing lua version: $(LUA_CMP_VERSION_2)"
	$(CURDIR)/$(LUA_CMP_VERSION_2)/install/bin/lua test_printer.lua

# -fPIC 生成位置无关代码(Position-Independent Code)，这对于共享库是必需的，因为它允许代码在内存中被任意位置加载.
# -I 指定头文件搜索路径
# -L 指定动态库 .so 或 .a 静态库搜索路径
# -llua 链接到名为 lua 的库. gcc 会在 -L 指定的目录中查找这个库. 通常是 .so 或 .a 文件
compile_cmp1_so:
	make -p $(CURDIR)/build
	gcc mylib.c -Wall -fPIC -shared -o build/mylib.so -I$(CURDIR)/$(LUA_CMP_VERSION_1)/install/lib -L$(CURDIR)/$(LUA_CMP_VERSION_1)/src -llua

compile_cmp2_so:
	make -p $(CURDIR)/build
	gcc mylib.c -Wall -fPIC -shared -o build/mylib.so -I$(CURDIR)/$(LUA_CMP_VERSION_2)/install/lib -L$(CURDIR)/$(LUA_CMP_VERSION_2)/src -llua

clean:
	rm -f mylib.so
	rm -f *.so
	rm -f $(CURDIR)/*.tar.gz
	rm -rf lua-*