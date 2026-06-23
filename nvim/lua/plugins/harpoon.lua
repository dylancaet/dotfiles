return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      local opts = { noremap = true, silent = true }

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(
          mode,
          lhs,
          rhs,
          vim.tbl_extend("force", opts, { desc = desc })
        )
      end

      -- Open Harpoon menu
      map("n", "<leader>hh", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, "Harpoon menu")

      -- Add current file to next Harpoon slot
      map("n", "<leader>ha", function()
        harpoon:list():add()
      end, "Harpoon add file")

      -- Go to Harpoon files 1-4
      map("n", "<C-1>", function()
        harpoon:list():select(1)
      end, "Harpoon file 1")

      map("n", "<C-2>", function()
        harpoon:list():select(2)
      end, "Harpoon file 2")

      map("n", "<C-3>", function()
        harpoon:list():select(3)
      end, "Harpoon file 3")

      map("n", "<C-4>", function()
        harpoon:list():select(4)
      end, "Harpoon file 4")

      -- Set/replace Harpoon files 1-4
      map("n", "<leader><C-1>", function()
        harpoon:list():replace_at(1)
      end, "Set Harpoon file 1")

      map("n", "<leader><C-2>", function()
        harpoon:list():replace_at(2)
      end, "Set Harpoon file 2")

      map("n", "<leader><C-3>", function()
        harpoon:list():replace_at(3)
      end, "Set Harpoon file 3")

      map("n", "<leader><C-4>", function()
        harpoon:list():replace_at(4)
      end, "Set Harpoon file 4")
    end,
  },
}