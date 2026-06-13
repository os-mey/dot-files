return {
    'mfussenegger/nvim-jdtls',
    dependencies = { 'folke/which-key.nvim' },
    ft = 'java',
    opts = function()
        return {
            root_dir = function(path)
                return vim.fs.root(path, vim.lsp.config.jdtls.root_markers)
            end,

            project_name = function(root_dir)
                return root_dir and vim.fs.basename(root_dir)
            end,

            jdtls_config_dir = function(project_name)
                return vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name .. '/config'
            end,
            jdtls_workspace_dir = function(project_name)
                return vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name .. '/workspace'
            end,

            cmd = { vim.fn.exepath 'jdtls' },
            full_cmd = function(opts)
                local fname = vim.api.nvim_buf_get_name(0)
                local root_dir = opts.root_dir(fname)
                local project_name = opts.project_name(root_dir)
                local full_cmd = vim.deepcopy(opts.cmd)
                if project_name then
                    vim.list_extend(full_cmd, {
                        '-configuration',
                        opts.jdtls_config_dir(project_name),
                        '-data',
                        opts.jdtls_workspace_dir(project_name),
                    })
                end
                return full_cmd
            end,

            -- These depend on nvim-dap, but can additionally be disabled by setting false here.
            dap = { hotcodereplace = 'auto', config_overrides = {} },
            -- Can set this to false to disable main class scan, which is a performance killer for large project
            dap_main = {},

            test = true,
            settings = {
                java = {
                    inlayHints = {
                        parameterNames = {
                            enabled = 'all',
                        },
                    },
                    -- home = os.getenv 'JAVA_HOME',
                },
            },
        }
    end,
    config = function(_, opts)
        local function attach_jdtls()
            local fname = vim.api.nvim_buf_get_name(0)

            local function extend_or_override(defaults, overrides)
                if overrides == nil then
                    return defaults
                end

                return vim.tbl_deep_extend('force', defaults, overrides)
            end

            -- Configuration can be augmented and overridden by opts.jdtls
            local config = extend_or_override({
                cmd = opts.full_cmd(opts),
                root_dir = opts.root_dir(fname),
                settings = opts.settings,
                capabilities = require('blink.cmp').get_lsp_capabilities() or nil,
            }, opts.jdtls)

            -- Existing server will be reused if the root_dir matches.
            require('jdtls').start_or_attach(config)
        end

        -- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
        -- depending on filetype, so this autocmd doesn't run for the first file.
        -- For that, we call directly below.
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'java',
            callback = attach_jdtls,
        })

        --         -- Setup keymap and dap after the lsp is fully attached.
        --         -- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
        --         -- https://neovim.io/doc/user/lsp.html#LspAttach
        --         vim.api.nvim_create_autocmd('LspAttach', {
        --             callback = function(args)
        --                 local client = vim.lsp.get_client_by_id(args.data.client_id)
        --                 if client and client.name == 'jdtls' then
        --                     local wk = require 'which-key'
        --                     wk.add {
        --                         {
        --                             mode = 'n',
        --                             buffer = args.buf,
        --                             { '<leader>cx', group = 'extract' },
        --                             { '<leader>cxv', require('jdtls').extract_variable_all, desc = 'Extract Variable' },
        --                             { '<leader>cxc', require('jdtls').extract_constant, desc = 'Extract Constant' },
        --                             { '<leader>cgs', require('jdtls').super_implementation, desc = 'Goto Super' },
        --                             { '<leader>cgS', require('jdtls.tests').goto_subjects, desc = 'Goto Subjects' },
        --                             { '<leader>co', require('jdtls').organize_imports, desc = 'Organize Imports' },
        --                         },
        --                     }
        --                     wk.add {
        --                         {
        --                             mode = 'x',
        --                             buffer = args.buf,
        --                             { '<leader>cx', group = 'extract' },
        --                             {
        --                                 '<leader>cxm',
        --                                 [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
        --                                 desc = 'Extract Method',
        --                             },
        --                             {
        --                                 '<leader>cxv',
        --                                 [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
        --                                 desc = 'Extract Variable',
        --                             },
        --                             {
        --                                 '<leader>cxc',
        --                                 [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
        --                                 desc = 'Extract Constant',
        --                             },
        --                         },
        --                     }

        --                     -- User can set additional keymaps in opts.on_attach
        --                     if opts.on_attach then
        --                         opts.on_attach(args)
        --                     end
        --                 end
        --             end,
        --         })

        --         -- Avoid race condition by calling attach the first time, since the autocmd won't fire.
        attach_jdtls()
    end,
}
