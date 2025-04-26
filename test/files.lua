
-- files chunk test

local paths = require "paths"
local files = require(paths.files)
require(paths.utils)

id_string = generate_id_string()
local f1 = files.new()
local directory = "tmp_dir"
local file = "tmp_file"
local make_name = "tmp_make"

-- create environment
os.execute("test/files_environment_setup.sh")
  
-- path
local handler = io.popen("echo $PWD")
local starting_pwd = handler:read() .. "/"
assert(files.get_path(f1) == starting_pwd)
-- cd
files.change_directory(f1, directory .. "/")
assert(files.get_path(f1) == starting_pwd .. directory .. "/")
-- list
local file_list = files.list(f1, "")
assert(file_list[1] == file)
-- copy
files.copy(f1, file)  
local copied_file = files.get_temporary_file(f1)
assert(copied_file == id_string .. file)
files.clear_temporary_file(f1)
-- remove
files.remove(f1, file)  
local copied_file = files.get_temporary_file(f1)
assert(copied_file == id_string .. file)
-- paste
files.paste(f1)  
local file_list = files.list(f1, "")
assert(file_list[1] == file)
files.remove(f1, file)  
-- make
files.make(f1, make_name)
local file_list = files.list(f1, "")
assert(file_list[1] == make_name)
  
-- teardown environment
files.change_directory(f1, "../")
files.remove(f1, directory)

id_string = nil
print("== PASSED: files test ==")
os.exit()

