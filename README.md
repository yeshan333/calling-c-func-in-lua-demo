# 在 lua 脚本中调用 C 函数

[English](README_en.md)

> 用于对比两个 lua 版本 C API luaL_tolstring 的表现

## 快速开始

```shell
# 安装两个 lua 版本
make install_lua

# 编译自定义 C 库
make compile_cmp1_so
# 测试版本 1，lua C API luaL_tolstring 的表现
make test_cmp1
# 测试版本 2，lua C API luaL_tolstring 的表现
make compile_cmp2_so
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

---

```c
static int my_printer(lua_State *L)
{
    size_t len;
    const int arg1 = luaL_checkinteger(L, 1);
    printf("arg1: %d\n", arg1);
    const uint8_t* s = (const uint8_t*)luaL_tolstring(L, 2, &len);
    printf("my printer's output: %s, length: %zu\n", s, len);
    // lua_pushstring(L, s);
    return 0;
}
```

Compare Result (test my_printer func):

```shell
# lua 5.4.7
echo "Testing lua version: lua-5.4.7"
Testing lua version: lua-5.4.7
/github/calling-c-func-in-lua-demo/lua-5.4.7/install/bin/lua test_printer.lua
arg1: 1
my printer's output: Oh my god, length: 9
arg1: 2
my printer's output: Oh my god, length: 9
arg1: 3
my printer's output: Oh my god, length: 9
```

```shell
echo "Testing lua version: lua-5.4.6"
Testing lua version: lua-5.4.6
/github/calling-c-func-in-lua-demo/lua-5.4.6/install/bin/lua test_printer.lua
arg1: 1
my printer's output: Oh my god, length: 9
arg1: 2
my printer's output: Oh my god, length: 9
arg1: 3
my printer's output: Oh my god, length: 9
```

##  参考

https://www.nosuchfield.com/2019/05/17/Call-C-function-in-Lua/
http://www.troubleshooters.com/codecorn/lua/lua_lua_calls_c.htm

