local M = {}

local function logger(plugin_name, msg)
    return function(level)
        if plugin_name then
            msg = string.format("  %s   %s", plugin_name, msg)
        end
        vim.notify(msg, level)
    end
end

function M:new(plugin_name)
    local table = {}
    self.__index = self
    table.plugin_name = plugin_name
    setmetatable(table, self)
    return table
end

function M:warn(msg)
    logger(self.plugin_name, msg)(vim.log.levels.WARN)
end

function M:error(msg)
    logger(self.plugin_name, msg)(vim.log.levels.ERROR)
end

function M:info(msg)
    logger(self.plugin_name, msg)(vim.log.levels.INFO)
end

return M
