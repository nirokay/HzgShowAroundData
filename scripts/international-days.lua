#!/usr/bin/env lua

local rawHtmlFile = "./scripts/international_days/raw.html" -- `string`
local rawHtmlLines = {} -- `{ [number] = string, ... }`
local htmlElements = {} -- `{ [number] = string, ... }`
local formattedJsonLines = {} -- `{ [number] = string, ... }`


-- Helper functions:

local function fileExists(filepath) -- `boolean`
    local file = io.open(rawHtmlFile, "r")
    if file == nil then
        return false
    end
    file:close()
    return true
end

local function strip(raw) -- `string`
    local result = tostring(raw)
    if result == nil then
        print("String '" .. tostring(raw) .. "' is nil")
        os.exit(1)
    end
    while result:sub(1, 1) == " " do
        result = result:sub(2, #result)
    end
    while result:sub(#result, #result) == " " do
        result = result:sub(1, #result - 1)
    end
    return result
end

local function split(raw, separator)
    local result = {}
    local sep = separator or "%s" -- any whitespace when separator is nil
    for substring in string.gmatch(raw, "([^".. sep .."]+)") do -- stolen from stackoverflow (idk what this is lol)
        table.insert(result, substring)
    end
    return result
end

local days = {}
local function newDay(name, date, link)
    return {
        name = name or "",
        date = date or "",
        link = link or ""
    }
end

-- Main logic:

if not fileExists(rawHtmlFile) then
    print("File '" .. rawHtmlFile .. "' does not exits. Exiting.")
    os.exit(1)
end

for line in io.lines(rawHtmlFile) do
    local strippedLine = strip(line)
    if strippedLine ~= "" then
        table.insert(rawHtmlLines, strippedLine)
    end
end

-- <span class="views-field views-field-title">
-- <span class="field-content"><a href="https://www.un.org/en/observances/braille-day">World Braille Day</a></span>  </span>  

-- <div class="views-field views-field-field-event-date-1">
-- <div class="field-content">
-- <span property="dc:date" datatype="xsd:dateTime" content="2021-01-04T00:00:00+00:00" class="date-display-single">04 Jan</span></div>  </div>  </div>

local idDayName = "title"
local idDayDate = "single"

local function getDayName(raw)
    local cleanedEnd = split(raw, "</")
    local cleaned = split(cleanedEnd[#cleanedEnd], ">")
    return cleaned[#cleaned]
end
local function getDayLink(raw)
    local cleanedFront = split(raw, 'href="')
    local cleaned = split(cleanedFront[1], '"')
    return cleaned[1]
end
local function getDayDate(raw)
    local cleanedEnd = split(raw, "</")
    local cleaned = split(cleanedEnd[#cleanedEnd], ">")
    local rawDate = cleaned[1]

    local dayMonth = split(rawDate, " ")
    -- This is horrible, please close your eyes:
    local month = "01"
    if month == "Jan" then month = "01"
    elseif dayMonth[2] == "Feb" then month = "02"
    elseif dayMonth[2] == "Mar" then month = "03"
    elseif dayMonth[2] == "Apr" then month = "04"
    elseif dayMonth[2] == "May" then month = "05"
    elseif dayMonth[2] == "Jun" then month = "06"
    elseif dayMonth[2] == "Jul" then month = "07"
    elseif dayMonth[2] == "Aug" then month = "08"
    elseif dayMonth[2] == "Sep" then month = "09"
    elseif dayMonth[2] == "Oct" then month = "10"
    elseif dayMonth[2] == "Nov" then month = "11"
    elseif dayMonth[2] == "Dec" then month = "12"
    else month = "*"
    end
    return "*-" .. month .. "-" .. dayMonth[1]
end

for _, line in ipairs(rawHtmlLines) do
    print(line)
    print("?", idDayName)
    print("!", string.find(line, idDayName))
    local isLineNameAndLink, _ = string.find(line, idDayName)
    local isLineDate, _ = string.find(line, idDayDate)
    if isLineNameAndLink ~= nil then -- New day
        local name = getDayName(line)
        local link = getDayLink(line)
        table.insert(days, newDay(name, nil, link))
    elseif isLineDate ~= nil then -- Day date
        local date = getDayDate(line)
        days[#days].date = date
    end
end

for i, day in ipairs(days) do
    print(i, day.name, day.date, day.link)
end
