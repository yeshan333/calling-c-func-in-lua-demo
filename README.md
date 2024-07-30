# 在 lua 脚本中调用 C 函数

> 用于对比两个 lua 版本 C API luaL_tolstring 的表现

## 快速开始

```shell
# 安装两个 lua 版本
make install_lua

# 编译自定义 C 库
make compile_cmp1_so
make compile_cmp2_so
# 测试版本 1，lua C API luaL_tolstring 的表现
make test_cmp1
# 测试版本 2，lua C API luaL_tolstring 的表现
make test_cmp2
```

使用 xmake 编译

```shell
# 指定 lua 版本进行编译 mylib.c
xmake f --lua_version=5.4.6 -v
xmake -v

# 测试版本 1 lua 5.4.7，lua C API luaL_tolstring 的表现
make test_cmp1
# 测试版本 2 lua 5.4.6，lua C API luaL_tolstring 的表现
make test_cmp2
```

##  参考文献

https://www.nosuchfield.com/2019/05/17/Call-C-function-in-Lua/
http://www.troubleshooters.com/codecorn/lua/lua_lua_calls_c.htm

