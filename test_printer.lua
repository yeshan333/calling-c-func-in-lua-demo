package.cpath = './?.so;' .. package.cpath -- 把库文件添加到搜索路径中

local mylib = require('mylib')

mylib.my_printer("Oh my god")