// Copy from: https://www.nosuchfield.com/2019/05/17/Call-C-function-in-Lua/

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#include <stdio.h>
#include <sys/time.h>

static int i_add(lua_State *L)
{
    // 获取第一个函数参数
    double a = luaL_checknumber(L, 1);
    printf("第一个参数：%f\n", a);

    // 获取第二个函数参数
    double b = luaL_checknumber(L, 2);
    printf("第二个参数：%f\n", b);

    // 设置函数返回值
    lua_pushnumber(L, a + b);

    // 函数返回值的数量，在这里函数返回值为 1
    return 1;
}

static int i_swap(lua_State *L)
{
    int i = lua_tointeger(L, 1);
    int j = lua_tointeger(L, 2);
    printf("%d 和 %d 交换位置\n", i, j);

    lua_pushinteger(L, j);
    lua_pushinteger(L, i);

    return 2;
}

// 计算斐波拉契数列
static int i_fib(lua_State *L)
{
    // lua_Integer 长度为 64 位，防止溢出（事实上当 n 的值达到 100 左右即使 64 位也会发生溢出了）
    lua_Integer sum = 0;
    lua_Integer a = 0; // n - 2
    lua_Integer b = 0; // n - 1

    int n = lua_tointeger(L, 1);
    int i = 0;
    while (i <= n)
    {
        // printf("sum is %d\n", sum);
        i++;
        if (i == 1)
        {
            a = 0;
            b = 1;
        }
        sum = a + b;
        a = b;
        b = sum;
    }

    lua_pushinteger(L, sum);
    return 1;
}

// 获取当前的毫秒时间戳
static int i_time(lua_State *L)
{
    struct timeval tv;
    gettimeofday(&tv, NULL);
    double t = tv.tv_sec + (double)((int)(tv.tv_usec * 0.001) * 0.001);

    // 以整数返回
    lua_pushinteger(L, (lua_Integer)(t * 1000));
    return 1;
}

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

static luaL_Reg mylibs[] = {
    {"add", i_add},
    {"swap", i_swap},
    {"fib_c", i_fib},
    {"current_time", i_time},
    {"my_printer", my_printer},
    {NULL, NULL}};

// 打开名为mylib的库，在Lua中使用require('mylib')可以调用mylib中的函数
int luaopen_mylib(lua_State *L)
{
    luaL_checkversion(L);
    // 对函数进行注册，之后在 Lua 中可以直接调用
    // 在调用 C 函数时使用的全局函数名，第二个参数为实际 C 函数的指针。
    // 使用时直接 require('mylib')
    
    // lua_register(L, "add", i_add);
    // lua_register(L, "swap", i_swap);
    // lua_register(L, "fib_c", i_fib);
    // lua_register(L, "current_time", i_time);
    // return 0;

    // 注册为一个模块
    // 需要以 -- local mylib = require('mylib') mylib.xxx 的方式使用
    luaL_newlib(L, mylibs);
    return 1;
}