local Logger = require 'soil.logger':new("Soil")
local settings = require 'soil'.DEFAULTS
local M = {}

local function validate()
    local function validate_image_function()
        return string.find(settings.image.execute_to_open(""), "nsxiv")
    end

    if vim.bo.filetype ~= "plantuml" then
        Logger:warn("This is not a Plant UML file.")
        return false
    end
    if vim.fn.executable("java") == 0 then
        Logger:warn("java is required. Install it to use this plugin.")
        return false
    end
    if vim.fn.executable("nsxiv") == 0 and validate_image_function() then
        Logger:warn("nsxiv is required. Install it to use this plugin.")
        return false
    end
    return true
end

local function get_image_command(file)
    vim.cmd("redraw")
    local image_file = string.format("%s.%s", file, settings.image.format)
    if image_file == nil then
        do return end
    end
    Logger:info(string.format("Image %s.%s generated!", file, settings.image.format))
    return string.format("sh -c '%s & disown; echo $?'", settings.image.execute_to_open(image_file))
end

local function execute_command(command, error_msg)
    error_msg = error_msg or "Execution error!"
    local result = vim.fn.system(command)
    if tonumber(result) ~= 0 then
        vim.cmd("redraw")
        Logger:error(error_msg)
        do return end
    end
end

local function redraw()
    local img = string.format("%s.%s", vim.fn.expand("%:r"), settings.image.format)
    os.execute(string.format("ps aux | grep -m 1 %s | awk '{print $2}' | xargs kill -9", img))
end

local function check_for_startuml_filename()
    -- Get the full path of the current file without extension
    local current_file = vim.fn.expand("%:p:r")

    -- Open the current file for reading
    local file = io.open(vim.fn.expand("%:p"), "r")
    if not file then
        error("Failed to open file")
    end

    -- Read the first line of the file
    local first_line = file:read("*l")
    file:close()

    -- Check if the first line contains @startuml "filename"
    local startuml_filename = first_line:match('@startuml%s+"(.-)"')
    local new_filename = current_file
    if startuml_filename then
        new_filename = current_file:gsub("(.-)([a-z-_]+)$", '"%1' .. startuml_filename .. '"')
    end
    return new_filename
end

function M.run()
    if not validate() then return end

    local cli_puml = vim.fn.executable('plantuml')
    local puml_jar = settings.puml_jar

    if cli_puml ~= 0 or puml_jar then
        local file_with_extension = vim.fn.expand("%:p")
        local file = check_for_startuml_filename()
        local format = settings.image.format
        local darkmode = settings.image.darkmode and "-darkmode" or ""

        Logger:info("Building...")
        if cli_puml ~= 0 then
            local puml_command = string.format("plantuml %s -t%s %s", file_with_extension, format, darkmode)
            if settings.actions.redraw then
                redraw()
            end
            execute_command(puml_command)
        else
            local puml_command = string.format("java -jar %s %s -t%s %s; echo $?", puml_jar, file_with_extension, format,
                darkmode)
            if settings.actions.redraw then
                redraw()
            end
            execute_command(puml_command)
        end
        execute_command(get_image_command(file), "Image not generated it.")
    else
        Logger:warn("Install plantuml or download it from the official page and set it up with 'puml_jar' option.")
    end
end

function M.open_image()
    local file = check_for_startuml_filename()
    execute_command(get_image_command(file), "Image not found. Run :Soil command to generate it.")
end

return M
