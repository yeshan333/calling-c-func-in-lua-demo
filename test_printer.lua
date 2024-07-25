package.cpath = 'build/?.so;' .. package.cpath -- 把库文件添加到搜索路径中

local mylib = require('mylib')

mylib.my_printer(1, "Oh my god")
mylib.my_printer(2, "Oh my god")
mylib.my_printer(3, "Oh my god")
