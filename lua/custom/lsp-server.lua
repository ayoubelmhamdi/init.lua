local lspconfig = require('lspconfig')

local on_attach = require('ayoub.lsp-options').on_attach
local handlers = require('ayoub.lsp-options').handlers
local capabilities = require('ayoub.lsp-options').capabilities

-- vim.lsp.config('grammarly, {
--   handlers = handlers,
--   on_attach = on_attach,
--   capabilities = capabilities,
--   init_options = { clientId = 'client_BaDkMgx4X19X9UxxYRCXZo' },
-- })

vim.lsp.config('pyright', {
    handlers = handlers,
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable('pyright')

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

vim.lsp.config('ruff', {
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
            lint = {
                ignore = { 
                    "E702", -- multiple-statements-on-one-line-semicolon
                    "E501", -- line-too-long
                    "E703", -- useless-semicolon
                },
            },
        },
    },

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

})

vim.lsp.enable('ruff')

vim.lsp.config('tinymist', {
    handlers = handlers,
    capabilities = capabilities,
    on_attach = on_attach,
    filetype = { 'typ' },
    -- cmd = { 'typst-lsp5' },
    -- settings = {
    --     exportPdf = 'onSave', -- Choose onType, onSave or never.
    --     -- serverPath = '', -- Normally, there is no need to uncomment it.
    -- },
})
vim.lsp.enable('tinymist')


-- clangd server setup to use it with external c library like raylib put in another root directory.
local clangd_capabilities = vim.deepcopy(capabilities or {})
clangd_capabilities.offsetEncoding = { 'utf-8' }

-- if we dont want to use hardcoed why, the root directories should be given using callback,
-- the root is very usefull to set the "--compile-commands-dir=" .. root
-- this usefull lo index external c files from the file compile_commands.json
-- NOTE: nil at at startup vim.lsp.get_clients({ bufnr = 0 })[1].config.root_dir

vim.api.nvim_create_autocmd("FileType", {
    -- pattern = { "ckkk" },
    pattern = { "c", "cpp", "cc" },
    callback = function(args)
        local root = vim.fs.root(args.buf, {
            "compile_commands.json",
            "compile_flags.txt",
            ".clangd",
            ".git",
        })

        if not root then
            root = vim.fn.getcwd()
        end

        local clients = vim.lsp.get_clients({
            name = "clangd",
            bufnr = args.buf,
        })

        if #clients > 0 then
            return
        end

        vim.lsp.start({
            name = "clangd",
            cmd = {
                "clangd",
                "--background-index",
                "--compile-commands-dir=" .. root,
            },

            root_dir = root,
            handlers = handlers,
            capabilities = clangd_capabilities,
            on_attach = on_attach,
        })
    end,
})






-- if we want to hard codded the compile-commands-dir manually we can us this:
-- vim.lsp.config('clangd', {
--     cmd = {
--         "clangd",
--         "--background-index",
--         "--compile-commands-dir=/data/projects/c/raylib-projects/foo"
--     },
--     handlers = handlers,
--     capabilities = clangd_capabilities,
--     on_attach = on_attach,
--     single_file_support = true,
--     filetype = { 'c', 'cpp', 'cc' },
-- })
-- vim.lsp.enable('clangd')






if false then
    -- lspconfig.ltex.setup { cmd = { '/home/mhamdi/.cache/ltex-ls-15.2.0/bin/ltex-ls' } }
    -- ltex: open source Grammar
    -- s.getenv("HOME")
    local lang = os.getenv('PROJECT_LANG') or 'en'
    vim.lsp.config('ltex', {
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

-- vim.lsp.config('lua_ls', {
--     handlers = handlers,
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = { debounce_text_changes = 150 },
--     settings = {
--         Lua = {
--             completion = {
--                 callSnippet = 'Replace',
--             },
--             diagnostics = {
--                 globals = { 'vim' },
--             },
--             workspace = {
--                 checkThirdParty = false, -- FIX the sumneko need config
--                 -- Make the server await for loading Neovim runtime files
--                 maxPreload = 1000,
--                 preloadFileSize = 500,
--             },
--         },
--     },
-- })
-- vim.lsp.enable('lua_ls')

vim.lsp.config('ts_ls', {
    handlers = handlers,
    capabilities = capabilities,
    on_attach = on_attach,
})

vim.lsp.enable('ts_ls')

vim.lsp.config('bashls', {
    handlers = handlers,
    capabilities = capabilities,
    on_attach = on_attach,
})

vim.lsp.enable('bashls')

--------------------------------------------------------------------------------------------

require('ayoub.lsp-options').toggleLsp()
require('ayoub.lsp-options').mylspconfig()

require('flutter-tools').setup({
    decorations = {
        statusline = {
            app_version = true,
            device = true,
        },
    },
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
