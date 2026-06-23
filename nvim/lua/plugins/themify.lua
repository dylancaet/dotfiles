return {
    'lmantw/themify.nvim',

    lazy = false,
    priority = 999,

    config = function()
        local themify = require('themify')

        themify.setup({ {
            'nyoom-engineering/oxocarbon.nvim',

            after = function(theme)
                --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                --vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

                -- Highlight on yank
                local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
                vim.api.nvim_create_autocmd('TextYankPost', {
                    callback = function()
                        vim.hl.on_yank()
                    end,
                    group = highlight_group,
                    pattern = '*',
                })
            end,
        } })
    end,
}

