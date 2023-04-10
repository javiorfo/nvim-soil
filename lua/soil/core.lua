-- ######################################################
-- # Maintainer: Mr. Charkuils                          #
-- # URL:        https://github.com/charkuils/nvim-soil #
-- ######################################################

local Logger = require'soil.logger':new("Soil")
local settings = require'soil'.DEFAULTS
local M = {}

local function validate()
    if vim.bo.filetype ~= "plantuml" then
        Logger:warn("This is not a Plant UML file.")
        return false
    end
    if vim.fn.executable("java") == 0 then
        Logger:warn("java is required. Install it to use this plugin.")
        return false
    end
    if vim.fn.executable("sxiv") == 0 then
        Logger:warn("sxiv is required. Install it to use this plugin.")
        return false
    end
    return true
end

local function get_image_command(file)
    vim.cmd("redraw")
    Logger:info(string.format("Image %s.%s generated!", file, settings.image.format))
    local image_file = string.format("%s.%s", file, settings.image.format)
    return string.format("sxiv -b %s; echo $?", image_file)
end

local function execute_command(command)
    local result = vim.fn.system(command)
    if tonumber(result) ~= 0 then
        vim.cmd("redraw")
        Logger:error("Execution error")
        do return end
    end
end

function M.run()
    if not validate() then return end

    local cli_puml = vim.fn.executable('plantuml')
    local puml_jar = settings.puml_jar

    if cli_puml ~= 0 or puml_jar then
       local file_with_extension = vim.fn.expand("%:p")
       local file = vim.fn.expand("%:p:r")
       local format = settings.image.format
       local darkmode = settings.image.darkmode and "-darkmode" or ""

       Logger:info("Building...")
       if cli_puml ~= 0 then
           local puml_command = string.format("plantuml %s -t%s %s", file_with_extension, format, darkmode)
           execute_command(puml_command)
       else
           local puml_command = string.format("java -jar %s %s -t%s %s; echo $?", puml_jar, file_with_extension, format, darkmode)
           execute_command(puml_command)
       end
       execute_command(get_image_command(file))
    else
        Logger:warn("Install plantuml or download it from the official page and set it up with 'puml_jar' option.")
    end
end

return M
