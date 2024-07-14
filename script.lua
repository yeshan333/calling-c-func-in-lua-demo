package.cpath = './?.so;' .. package.cpath -- 把库文件添加到环境变量中

local mylib = require('mylib')
-- require('mylib')
-- print(mylib.add(1, 2))
print(mylib.swap(2333, 666))

-- 计算斐波那契数列
fib_lua = function(n)
    sum = 0
    a = 0 -- n - 2
    b = 0 -- n - 1

    i = 0
    repeat
        i = i + 1
        if i == 1 then
            a = 0
            b = 1
        end
        sum = a + b
        a = b
        b = sum
    until i > n
    return sum
end

n = 10000000 -- 计算的斐波那契数列位数

-- 使用lua计算
start = mylib.current_time()
fib_lua(n)
luaCost =  mylib.current_time() - start
print(luaCost)

-- 使用C语言计算
start =  mylib.current_time()
mylib.fib_c(n)
cCost =  mylib.current_time() - start
print(cCost)

-- 计算lua与C语言的耗时比
print(luaCost / cCost)