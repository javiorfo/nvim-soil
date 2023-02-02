-- #########################################################
-- # Maintainer:  Javier Orfo                              #
-- # URL:         https://github.com/javi-7/nvim-modelizer #
-- #########################################################

local Logger = require'modelizer.utils'.logger
local M = {}

M.DEFAULTS = {
    image = {
        bg = "black",
        darkmode = false,
        format = "png",
        size = { width = 1000, height = 600 }
    }
}

function M.setup(opts)
    if opts.puml_jar then
        M.DEFAULTS.puml_jar = opts.puml_jar
    end
    if opts.image then
        local img = opts.image

        if img.bg then
            if type(img.bg) == "string" then
                M.DEFAULTS.image.bg = img.bg
            else
                Logger:error("Setup Error: image.bg must be a string value.")
            end
        end

        if img.format then
            if img.format == "png" or img.format == "svg" then
                M.DEFAULTS.image.format = img.format
            else
                Logger:error("Setup Error: The values allowed for image.format are 'png' or 'svg'.")
            end
        end

        if img.darkmode then
            if type(img.darkmode) == "boolean" then
                M.DEFAULTS.image.darkmode = img.darkmode
            else
                Logger:error("Setup Error: image.darkmode must be a boolean value.")
            end
        end

        if img.size then
            local size = img.size
            if size.width and size.height then
                if type(size.width) == "number" then
                    M.DEFAULTS.image.size.width = size.width
                else
                    Logger:error("Setup Error: image.size.width must be a number value.")
                end

                if type(size.height) == "number" then
                    M.DEFAULTS.image.size.height = size.height
                else
                    Logger:error("Setup Error: image.size.height must be a number value.")
                end
            else
                Logger:warn("Setup Error: image.size.width or image.size.height does not exist.")
            end
        end
    end
end

return M
