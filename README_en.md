# Call C functions in lua script

> For comparing the difference of the C API `luaL_tolstring` of two lua versions

## Quick Start

```shell
# Install two lua versions
make install_lua

# Compile custom C libraries
make compile_cmp1_so
# Test the difference of version 1 of lua 5.4.7, lua C API `luaL_tolstring`
make test_cmp1

# Test the difference of version 2 of lua 5.4.6, lua C API `luaL_tolstring`
make compile_cmp2_so # compile so
make test_cmp2
```

Compile using xmake

```shell
# Specify the lua version for compilation mylib.c
xmake f --lua_version=5.4.6 -v
xmake -v

# Test the difference of version 1 of lua 5.4.7, lua C API `luaL_tolstring`
make test_cmp1
# Test the difference of version 2 of lua 5.4.6, lua C API `luaL_tolstring`
make test_cmp2
```

## References

https://www.nosuchfield.com/2019/05/17/Call-C-function-in-Lua/
http://www.troubleshooters.com/codecorn/lua/lua_lua_calls_c.htm 