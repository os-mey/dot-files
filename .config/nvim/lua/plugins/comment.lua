--[[

# Comment
Toggle comments
- gcc -> to toggle line comment
- gc  -> to toggle comment of visual regions/lines

https://github.com/numToStr/Comment.nvim


# Todo Comments
Highlight todo, notes, etc in comments

https://github.com/folke/todo-comments.nvim

--]]

return {
    {
        'numToStr/Comment.nvim',
        enabled = true,
        lazy = true,
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            -- mappings = {
            --     basic = true,
            --     extra = false, -- Disable extra features like commenting new lines
            -- },
        },
        config = function()
            require('Comment').setup {
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            }
        end,
    },

    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        enabled = true,
        lazy = false,
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            enable_autocmd = false,
        },
    },

    {
        'folke/todo-comments.nvim',
        lazy = true,
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = true },
    },
}
