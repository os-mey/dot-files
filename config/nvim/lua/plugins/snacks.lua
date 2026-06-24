--[[

# Snacks
Greeting interface, intent line, etc.
https://github.com/folke/snacks.nvim

]]

return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = {
        {
            '-',
            ":lua Snacks.dashboard.pick('oldfiles')<CR>",
            desc = 'Open recent files',
            mode = 'n',
        },
    },
    opts = {
        bigfile = { enabled = true }, -- Disable lsp etc. in large files
        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
                    { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = ' ', key = 'e', desc = 'File Explorer', action = ':Ex' },
                    { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
                    { icon = '󰒲 ', key = 'p', desc = 'Plugins', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
                    { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
                },
            },
        },
        indent = { -- Draws indent lines
            enabled = true,
            scope = { -- highlights current scope
                enabled = false,
            },
        },
        quickfile = { enabled = true }, -- Quickly load files
    },
}
