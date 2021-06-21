local data_dir = require('core.global').data_dir
local modules_dir = require('core.global').modules_dir
local modules = require('core.global').modules
local packer_compiled = data_dir .. 'packer_compiled.vim'
local compile_to_lua = data_dir .. 'lua/_compiled.lua'
local packer = nil

local Packer = {}
Packer.__index = Packer

function Packer:load_modules()
    for _, module in ipairs(modules) do
        local plugins = require('modules.' .. module .. '.plugins')

        local use = packer.use
        for repo, conf in pairs(plugins) do
            use(vim.tbl_extend('force', {repo}, conf))
        end
    end
end

function Packer:load_packer()
    if not packer then
        vim.api.nvim_command('packadd packer.nvim')
        packer = require('packer')
    end
    packer.init({
        compile_path = packer_compiled,
        git = {clone_timeout = 120},
        disable_commands = true
    })
    packer.reset()

    local use = packer.use
    use {"wbthomason/packer.nvim", opt = true}
    self:load_modules()
end

function Packer:init_ensure_plugins()
    local packer_dir = data_dir .. 'pack/packer/opt/packer.nvim'
    local state = vim.loop.fs_stat(packer_dir)
    if not state then
        local cmd = "!git clone https://github.com/wbthomason/packer.nvim " ..
                        packer_dir
        vim.api.nvim_command(cmd)
        vim.loop.fs_mkdir(data_dir .. 'lua', 511,
                    function() assert("make compile path dir failed") end)
        self:load_packer()
        packer.install()
    end
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        if not packer then Packer:load_packer() end
        return packer[key]
    end
})

function plugins.ensure_plugins() Packer:init_ensure_plugins() end

function plugins.convert_compile_file()
    local lines = {}
    local lnum = 1
    lines[#lines + 1] = 'vim.cmd [[packadd packer.nvim]]\n'

    for line in io.lines(packer_compiled) do
        lnum = lnum + 1
        if lnum > 15 then
            lines[#lines + 1] = line .. '\n'
            if line == 'END' then break end
        end
    end
    table.remove(lines, #lines)

    if vim.fn.isdirectory(data_dir .. 'lua') ~= 1 then
        os.execute('mkdir -p ' .. data_dir .. 'lua')
    end

    if vim.fn.filereadable(compile_to_lua) == 1 then
        os.remove(compile_to_lua)
    end

    local file = io.open(compile_to_lua, "w")
    for _, line in ipairs(lines) do file:write(line) end
    file:close()

    os.remove(packer_compiled)
end

function plugins.magic_compile()
    plugins.compile()
    plugins.convert_compile_file()
end

function plugins.auto_compile()
    local file = vim.fn.expand('%:p')
    if file:match(modules_dir) then
        plugins.clean()
        plugins.compile()
        plugins.convert_compile_file()
    end
end

function plugins.load_compile()
    if vim.fn.filereadable(compile_to_lua) == 1 then
        require('_compiled')
    else
        assert(
            'Missing packer compile file. Run PackerCompile or PackerInstall to fix')
    end
    vim.cmd [[command! PackerCompile lua require('core.pack').magic_compile()]]
    vim.cmd [[command! PackerInstall lua require('core.pack').install()]]
    vim.cmd [[command! PackerUpdate lua require('core.pack').update()]]
    vim.cmd [[command! PackerSync lua require('core.pack').sync()]]
    vim.cmd [[command! PackerClean lua require('core.pack').clean()]]
    vim.cmd [[autocmd User PackerComplete lua require('core.pack').magic_compile()]]
    vim.cmd [[command! PackerStatus lua require('core.pack').status()]]
end

return plugins
