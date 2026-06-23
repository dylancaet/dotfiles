return {
    { "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },

        config = function()
            vim.opt.signcolumn = "yes"

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local INSTALL_THESE_LSPS = {
                        "lua_ls",
                        "vtsls",
                    }
                    local INSTALL_THESE_TOOLS = { -- not actually used
                        "eslint_d",
                    }

                    local opts = { buffer = event.buf, silent = true }

                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)

                    -- vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)

                    vim.keymap.set("n", "<leader>lf", function()
                        vim.lsp.buf.format({ async = true })
                    end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))

                    vim.keymap.set("v", "<leader>lf", function()
                        vim.lsp.buf.format({ async = true })
                    end, vim.tbl_extend("force", opts, { desc = "Format selection" }))

                    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename,
                        vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

                    vim.keymap.set("n", "<leader>lh", function()
                        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                        vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf, })
                    end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints", }))

                    vim.keymap.set("n", "<leader>ld", function()
                        local current_config = vim.diagnostic.config()
                        local virtual_text_enabled = current_config.virtual_text ~= false

                        vim.diagnostic.config({
                            virtual_text = not virtual_text_enabled,
                        })
                    end, {
                        desc = "Toggle diagnostic virtual text",
                    })
                end,
            })

            require("mason").setup()

            vim.lsp.config("vtsls", {
                settings = {
                    typescript = {
                        inlayHints = {
                            parameterNames = { enabled = "all" },
                            parameterTypes = { enabled = true },
                            variableTypes = { enabled = true },
                            propertyDeclarationTypes = { enabled = true },
                            functionLikeReturnTypes = { enabled = true },
                            enumMemberValues = { enabled = true },
                        },
                    },
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = INSTALL_THESE_LSPS,
                automatic_enable = true,
            })

            local cmp = require("cmp")

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
        end,
    },
}
