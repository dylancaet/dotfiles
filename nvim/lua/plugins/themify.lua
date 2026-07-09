return {
    'lmantw/themify.nvim',

    lazy = false,
    priority = 999,

    config = function()
        local themify = require('themify')

        themify.setup({
            'nyoom-engineering/oxocarbon.nvim',
            --[[ 'projekt0n/github-nvim-theme', ]]
            'default',
            'darkblue',
        })
    end,
}
