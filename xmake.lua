cur_dir = "./"
output_dir = "./build"

-- 远程下载 lua 版本
add_requires("lua", {version = "$(lua_version)"})
option("lua_version")
    set_default("5.4.7")
    set_showmenu(true)
option_end()

function build_target(basename)
    add_packages("lua")
    set_targetdir(output_dir)
    set_optimize("faster")
    set_warnings("allextra")
    set_basename(basename)
    set_kind("shared")
    add_cxflags("-fPIC")
    set_filename(basename..".so")
end

target "mylib"
    build_target("mylib")
    add_files(cur_dir .. "*.c")
