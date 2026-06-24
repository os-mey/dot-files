--[[

# Treesiter Context
Shows the context of the currently visible buffer contents
https://github.com/nvim-treesitter/nvim-treesitter-context

--]]

-- Native Parser Registration
vim.treesitter.language.add('riscv', {
    path = '/home/oskar/git/tree-sitter-riscv/riscv.so',
})

-- Folding (Native)
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldmethod = 'expr'
vim.opt.foldlevel = 100

-- Keymaps (Kept as you had them)
local fold_keys = {
    z0 = 100,
    z1 = 0,
    z2 = 1,
    z3 = 2,
    z4 = 3,
    z5 = 4,
    z6 = 5,
    z7 = 6,
    z8 = 7,
    z9 = 8,
}
for key, level in pairs(fold_keys) do
    vim.keymap.set('n', key, ':set foldlevel=' .. level .. '<cr>')
end

return {
    {
        'romus204/tree-sitter-manager.nvim',
        lazy = true,
        event = 'VeryLazy',
        opts = {},
    },

    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
            enable = true,
            separator = nil,
            line_numbers = true,
            mode = 'cursor',
            max_lines = 1,
            min_window_height = 40,
            multiline_threshold = 1,
        },
        config = function(_, opts)
            require('treesitter-context').setup(opts)
            vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { link = 'Visual' })
            vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { link = 'Normal' })
        end,
    },
}
