# lua_squish
lua混淆 + 打包工具
[原始地址](https://github.com/LuaDist/squish)
lua扩展库[sllib](https://github.com/sywoon/sllib_lua.git)

## 功能扩展
-c "Output 'test_out.lua';Main 'test.lua';" 
用于读取配置信息,而非从squishy读取,
方便批处理多个lua文件.


## 使用方式
1. 压缩混淆每个lua文件：
   将文件夹拖入squish_files\make_lua.bat
   
2. 多个文件合并为一个(常用于lua库)：
   将文件夹拖入squish_to_one\make_lua.bat

## 更新sllib_lua
1. git submodule init sllib_lua
2. git submodule update sllib_lua





