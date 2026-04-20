#!/usr/bin/env lua

---@param path string
---@return boolean
local function file_exists(path)
    local file = io.open(path, "r") ---@type file* | nil
    if file == nil then return false end
    file:close()
    return true
end

---Exists with a reason provided.
---@param reason string|nil
---@return boolean
local function exit(reason)
    print(reason or "Exiting.")
    os.exit(1)
end


-- JSON dependency:

if not file_exists("./scripts/lib/json.lua") then
    exit("Dependency 'json.lua' missing, please run the 'fetch-dependencies.sh' script to fetch the missing dependency.")
end
local json = require("scripts/lib/json")


-- Files:

if arg[1] == nil then exit("Argument $1 has to be a file, none provided.") end

local input_file = arg[1] or "" ---@type string
if not file_exists(input_file) then exit("Input file '" .. input_file .. "' does not exist, aborting.") end

local output_file = input_file .. ".new.json" ---@type string
-- if file_exists(output_file) then exit("Output file '" .. output_file .. "' already exists, aborting.") end


-- Reading:

---@param path string
---@return table (json)
local function read_json_file(path)
    if not file_exists(path) then exit("File '" .. path .. "' does not exist.") end

    local file = io.open(path, "r")
    local content = "[]"
    if file ~= nil then
        content = file:read("a")
        file:close()
    else
        exit("File '" .. path .. "' could not be read.")
    end

    return json.decode(content)
end

local input_json = read_json_file(input_file)


-- Parsing and modifying:

---Converts table from legacy to current
---@param input table
---@return table
local function convert_json_object(input)
    if input.COMMENT ~= nil then return input end -- comment
    if input.times ~= nil then return input end   -- already converted

    local result = {
        name = input.name,
        locations = input.locations,
        times = {},
        level = input.level,
        info = input.info,
        image = input.image,
        details = input.details
    }
    if input.on ~= nil then
        table.insert(result.times, { on = input.on })
    else
        table.insert(result.times, {
            from = input.from,
            till = input.till
        })
    end
    return result
end


local output = {
    { COMMENT = "Converted by script from legacy time system" }
}
for _, object in ipairs(input_json) do
    local modified = convert_json_object(object)
    table.insert(output, modified)
end


-- Writing:

---@param path string
---@param content table
local function write_json_file(path, content)
    local file = io.open(path, "w")
    local json_string = json.encode(content) ---@type string
    if file == nil then exit("Could not write to file '" .. path .. "', aborting.") end
    file:write(json_string)
    file:close()
end

write_json_file(output_file, output)
