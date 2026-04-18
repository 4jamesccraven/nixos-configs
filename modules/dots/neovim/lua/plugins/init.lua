local M = {}

--- Validates a plugin.
-- @param plug A plugin configuration.
local function validate_plugin(plug)
    vim.validate('plug', plug, 'table')

    vim.validate('owner', plug.owner, 'string')
    vim.validate('repo', plug.repo, 'string')
    vim.validate('site', plug.site, 'string', true)
    vim.validate('config', plug.config, 'function', true)
    vim.validate('deps', plug.deps, 'table', true)
end

--- Installs and configures (if applicable) a plugin.
-- @param plug A plugin definition.
local function setup_plugin(plug)
    validate_plugin(plug)
    local owner = plug.owner
    local repo = plug.repo
    local plugId = owner .. '/' .. repo
    local site = plug.site or 'https://github.com/'

    vim.pack.add { site .. plugId }

    if plug.deps ~= nil then
        for _, dep in ipairs(plug.deps) do
            setup_plugin(dep)
        end
    end

    if plug.config ~= nil then
        local ok, conf = pcall(plug.config)
        if not ok then
            vim.notify(
                'failed to load plugin: ' .. plugId .. '\n' .. conf,
                vim.log.levels.ERROR
            )
        end
    end
end

local function collect_plugins(dir)
    local scan = vim.uv.fs_scandir(dir)
    if not scan then return end

    local plugs = {}

    while true do
        local name, fs_type = vim.uv.fs_scandir_next(scan)
        if not name then break end

        if fs_type == 'file' and name:match("%.lua$") and name ~= "init.lua" then
            local module = 'plugins.' .. name:gsub("%.lua$", '')
            local ok, conf = pcall(require, module)
            if not ok then
                vim.notify(
                    'failed to load plugin config: ' .. module .. '\n' .. conf,
                    vim.log.levels.ERROR
                )
            end
            table.insert(plugs, conf)
        end
    end

    return plugs
end

local plugs = collect_plugins(vim.fn.stdpath('config') .. '/lua/plugins')
if plugs ~= nil then
    for _, plug in ipairs(plugs) do
        setup_plugin(plug)
    end
end

local unused = vim.iter(vim.pack.get())
    :filter(function(x) return not x.active end)
    :map(function(x) return x.spec.name end)
    :totable()

if not vim.tbl_isempty(unused) then
    vim.pack.del(unused)
end

return M
