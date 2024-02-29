return {
    {
        'neovim/nvim-lspconfig',
        event = 'LspAttach',
        dependencies = {
            { 'williamboman/mason.nvim',           event = 'LspAttach' },
            { 'williamboman/mason-lspconfig.nvim', event = 'LspAttach' },
            { 'barreiroleo/ltex-extra.nvim',       event = 'LspAttach' },
            { 'hrsh7th/nvim-cmp',                  event = 'LspAttach' },
        },
        config = function()
            local on_attach = require('ayoub.lsp-options').on_attach
            local handlers = require('ayoub.lsp-options').handlers
            local capabilities = require('ayoub.lsp-options').capabilities
            -- local toggleLsp = require('ayoub.lsp-options').toggleLsp
            -- local mylspconfig = require('ayoub.lsp-options').mylspconfig

            local lspconfig = require('lspconfig')
            -- lspconfig.grammarly.setup {
            --   handlers = handlers,
            --   on_attach = on_attach,
            --   capabilities = capabilities,
            --   init_options = { clientId = 'client_BaDkMgx4X19X9UxxYRCXZo' },
            -- }

            lspconfig.pyright.setup({
                handlers = handlers,
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- lspconfig.pylyzer.setup {
            --   handlers = handlers,
            --   capabilities = capabilities,
            --   on_attach = on_attach,
            -- }

            -- lspconfig.sourcery.setup {
            --   init_options = {
            --     token = 'user_zapqdUoO_oNXWlV0JSVBENoiQu4hGRIBETEmnEfU5tmFOpMjOSr60LrJKig',
            --     extension_version = 'vim.lsp',
            --     editor_version = 'vim',
            --   },
            -- }
            lspconfig.ruff_lsp.setup({
                handlers = handlers,
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    client.server_capabilities.hoverProvider = false
                end,
                init_options = {
                    settings = {
                        organizeImports = false,
                        fixAll = false,
                        -- Any extra CLI arguments for `ruff` go here.
                        args = { '--ignore=E501' },
                    },
                },
                --
                commands = {
                    RuffAutofix = {
                        function()
                            vim.lsp.buf.execute_command({
                                command = 'ruff.applyAutofix',
                                arguments = {
                                    { uri = vim.uri_from_bufnr(0) },
                                },
                            })
                        end,
                        description = 'Ruff: Fix all auto-fixable problems',
                    },
                    RuffOrganizeImports = {
                        function()
                            vim.lsp.buf.execute_command({
                                command = 'ruff.applyOrganizeImports',
                                arguments = {
                                    { uri = vim.uri_from_bufnr(0) },
                                },
                            })
                        end,
                        description = 'Ruff: Format imports',
                    },
                },
                --
            })

            lspconfig.typst_lsp.setup({
                handlers = handlers,
                capabilities = capabilities,
                on_attach = on_attach,
                filetype = { 'typ' },
                cmd = { 'typst-lsp5' },
                settings = {
                    exportPdf = 'onSave', -- Choose onType, onSave or never.
                    -- serverPath = '', -- Normally, there is no need to uncomment it.
                },
            })

            -- -- clangd server setup
            -- local clangd_capabilities = capabilities
            -- clangd_capabilities.offsetEncoding = 'utf-8'
            --
            -- lspconfig.clangd.setup {
            --   handlers = handlers,
            --   capabilities = clangd_capabilities,
            --   on_attach = on_attach,
            --   single_file_support = true,
            --   filetype = { 'c', 'cpp' },
            -- }

            if false then
                -- lspconfig.ltex.setup { cmd = { '/home/mhamdi/.cache/ltex-ls-15.2.0/bin/ltex-ls' } }
                -- ltex: open source Grammar
                -- s.getenv("HOME")
                local lang = os.getenv('PROJECT_LANG') or 'en'
                lspconfig.ltex.setup({
                    handlers = handlers,
                    capabilities = capabilities,
                    filetypes = { 'text', 'plaintex', 'tex', 'bib', 'markdown', 'typst' },
                    on_attach = function(client, bufnr)
                        -- your other on_attach functions.
                        on_attach(client, bufnr)
                        require('ltex_extra').setup({
                            -- load_langs = { 'fr' }, -- table <string> : languages for witch dictionaries will be loaded
                            -- init_check = false, -- boolean : whether to load dictionaries on startup
                            -- path = nil, -- string : path to store dictionaries. Relative path uses current working directory
                            -- path = vim.fn.stdpath 'data' .. '/ltex_extra',
                            -- path = 'ltex_extra',
                            -- log_level = 'none', -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
                        })
                    end,
                    settings = {
                        ltex = {
                            language = lang,
                            diagnosticSeverity = 'information',
                            setenceCacheSize = 2000,
                            additionalRules = {
                                enablePickyRules = true,
                                motherTongue = 'en',
                            },
                            trace = { server = 'verbose' },
                            dictionary = {
                                ['en'] = { ':~/.config/nvim/spell/en.utf-8.add' },
                            },
                            disabledRules = {
                                -- ["en-US"] = { vim.fn.stdpath 'data' .. "/lldisable.txt"},
                                -- ["en"] = { vim.fn.stdpath 'data' .. "/ll-en-disable.txt"},
                                ['en'] = {
                                    'COMMA_PARENTHESIS_WHITESPACE',
                                    'ELLIPSIS',
                                    'EN_QUOTES',
                                    'DASH_RULE',
                                    'PASSIVE_VOICE',
                                    'THREE_NN',
                                    'MULTIPLICATION_SIGN',
                                    -- 'WHITESPACE_RULE',
                                    -- 'DASH_RULE',
                                    -- 'EN_QUOTES',
                                    -- 'NON_STANDARD_COMMA',
                                    -- 'PUNCTUATION_PARAGRAPH_END',
                                    -- 'EN_UNPAIRED_BRACKETS',
                                    -- 'WORD_CONTAINS_UNDERSCORE',
                                    -- 'COMMA_PARENTHESIS_WHITESPACE',
                                },
                                ['fr'] = {
                                    'WHITESPACE_RULE____',
                                },
                            },
                            hiddenFalsePositives = {
                                ['en'] = {
                                    'COMMA_PARENTHESIS_WHITESPACE',
                                },
                            },
                            -- languageToolHttpServerUri = 'http://localhost:8081/v2',
                        },
                    },
                })
            end

            lspconfig.lua_ls.setup({
                handlers = handlers,
                capabilities = capabilities,
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = 'Replace',
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            checkThirdParty = false, -- FIX the sumneko need config
                            -- Make the server await for loading Neovim runtime files
                            maxPreload = 1000,
                            preloadFileSize = 500,
                        },
                    },
                },
            })
        end,
    },
    {
        'akinsho/flutter-tools.nvim',
        lazy = true,
        ft = 'dart',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
        config = function()
            local on_attach = require('ayoub.lsp-options').on_attach
            local handlers = require('ayoub.lsp-options').handlers
            local capabilities = require('ayoub.lsp-options').capabilities

            require('ayoub.lsp-options').toggleLsp()
            require('ayoub.lsp-options').mylspconfig()

            require('flutter-tools').setup({
                decorations = {
                    statusline = {
                        app_version = true,
                        device = true,
                    },
                },
                -- flutter_lookup_cmd = "dirname $(which flutter)",
                widget_guides = {
                    enabled = true,
                },
                lsp = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    handlers = handlers,
                    settings = {
                        lineLength = 200,
                        showTodos = true,
                        completeFunctionCalls = true,
                    },
                },
            })
            require('telescope').load_extension('flutter')
        end,
    },
}
