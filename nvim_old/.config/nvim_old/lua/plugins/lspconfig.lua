return {
      {
            'neovim/nvim-lspconfig',
            tag = nil,
            version = nil,
            branch = 'master',
            event = "BufReadPre",
            dependencies = {
                  { "williamboman/mason-lspconfig.nvim" },
                  { "williamboman/mason.nvim" },
                  { "hrsh7th/cmp-nvim-lsp" },
                  { "folke/neodev.nvim",                opt = {} },
            },
            config = function()
                  require('mason').setup()
                  require('mason-lspconfig').setup {
                        automatic_installation = true,
                  }

                  local lspconfig = require('lspconfig')
                  local cmp_nvim_lsp = require('cmp_nvim_lsp')
                  local util = require("lspconfig.util")

                  local on_attach = function(client, bufnr)
                        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

                        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
                        local opts = { noremap = true, silent = true }

                        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                        client.server_capabilities.document_formatting = true
                  end

                  local on_attach_qmd = function(client, bufnr)
                        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

                        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
                        local opts = { noremap = true, silent = true }

                        -- add qmd-specific keymap here if wanted
                        -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

                        client.server_capabilities.document_formatting = true
                  end


                  local lsp_flags = {
                        allow_incremental_sync = true,
                        debounce_text_changes = 150,
                  }

                  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
                        vim.lsp.diagnostic.on_publish_diagnostics, {
                              virtual_text = false,
                              signs = true,
                              underline = true,
                              update_in_insert = false,
                        })
                  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover,
                        { border = require 'misc.style'.border })
                  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
                        { border = require 'misc.style'.border })

                  local capabilities = vim.lsp.protocol.make_client_capabilities()
                  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
                  capabilities.textDocument.completion.completionItem.snippetSupport = true

                  -- also needs:
                  -- $home/.config/marksman/config.toml :
                  -- [core]
                  -- markdown.file_extensions = ["md", "markdown", "qmd"]
                  lspconfig.marksman.setup {
                        on_attach = on_attach_qmd,
                        capabilities = capabilities,
                        filetypes = { 'markdown', 'quarto' },
                        root_dir = util.root_pattern(".git", ".marksman.toml", "_quarto.yml"),
                  }

                  -- -- another optional language server for grammar and spelling
                  -- -- <https://github.com/valentjn/ltex-ls>
                  -- lspconfig.ltex.setup {
                  --   on_attach = on_attach_qmd,
                  --   capabilities = capabilities,
                  --   filetypes = { "markdown", "tex", "quarto" },
                  -- }

                  lspconfig.r_language_server.setup {
                        capabilities = capabilities,
                        flags = lsp_flags,
                        settings = {
                              r = {
                                    lsp = {
                                          rich_documentation = false,
                                    },
                              },
                        },
                  }

                  lspconfig.emmet_ls.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        flags = lsp_flags
                  }

                  lspconfig.cssls.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        flags = lsp_flags
                  }

                  lspconfig.html.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        flags = lsp_flags
                  }

                  lspconfig.emmet_ls.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        flags = lsp_flags
                  }

                  lspconfig.yamlls.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        flags = lsp_flags
                  }

                  local function strsplit(s, delimiter)
                        local result = {}
                        for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
                              table.insert(result, match)
                        end
                        return result
                  end

                  local function get_quarto_resource_path()
                        local f = assert(io.popen('quarto --paths', 'r'))
                        local s = assert(f:read('*a'))
                        f:close()
                        return strsplit(s, '\n')[2]
                  end

                  local lua_library_files = vim.api.nvim_get_runtime_file("", true)
                  local lua_plugin_paths = {}
                  local resource_path = get_quarto_resource_path()
                  if resource_path == nil then
                        vim.notify_once("quarto not found, lua library files not loaded")
                  else
                        table.insert(lua_library_files, resource_path .. '/lua-types')
                        table.insert(lua_plugin_paths, resource_path .. '/lua-plugin/plugin.lua')
                  end

                  -- not upadated yet in automatic mason-lspconfig install,
                  -- open mason manually with `<space>vm` and `/` search for lua.
                  lspconfig.lua_ls.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        flags = lsp_flags,
                        settings = {
                              Lua = {
                                    completion = {
                                          callSnippet = "Replace"
                                    },
                                    runtime = {
                                          version = 'LuaJIT',
                                          plugin = lua_plugin_paths,
                                    },
                                    diagnostics = {
                                          globals = { 'vim', 'quarto', 'pandoc', 'io', 'string', 'print', 'require',
                                                'table', },
                                          disable = { 'trailing-space' },
                                    },
                                    workspace = {
                                          library = lua_library_files,
                                          checkThirdParty = false,
                                    },
                                    telemetry = {
                                          enable = false,
                                    },
                              },
                        },
                  }

                  lspconfig.pyright.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        flags = lsp_flags,
                        settings = {
                              python = {
                                    analysis = {
                                          autoSearchPaths = true,
                                          useLibraryCodeForTypes = false,
                                          diagnosticMode = 'openFilesOnly',
                                    },
                              },
                        },
                        root_dir = function(fname)
                              return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml",
                                        "requirements.txt")(fname) or
                                  util.path.dirname(fname)
                        end
                  }

                  lspconfig.julials.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        flags = lsp_flags,
                  }

                  lspconfig.bashls.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        flags = lsp_flags,
                        filetypes = { 'sh', 'bash' }
                  }

                  -- Add additional languages here.
                  -- See `:h lspconfig-all` for the configuration.
                  -- Like e.g. Haskell:
                  -- lspconfig.hls.setup {
                  --       on_attach = on_attach,
                  --       capabilities = capabilities,
                  --       flags = lsp_flags
                  -- }

                  lspconfig.rust_analyzer.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        settings = {
                              ['rust-analyzer'] = {
                                    diagnostics = {
                                          enable = false,
                                    }
                              }
                        }
                  }
            end
      },
}
