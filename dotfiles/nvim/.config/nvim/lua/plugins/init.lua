return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({ flavour = "mocha" })
      vim.cmd("colorscheme catppuccin")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "dart", "lua", "c" })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "dart", "lua" },
        callback = function() vim.treesitter.start() end,
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
          },
        },
      })
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    config = function()
      require("dashboard").setup({
        theme = "doom",
        config = {
          header = vim.split(string.rep("\n", 8) .. [[
   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]] .. "\n\n", "\n"),
          center = {
            { action = "Telescope find_files",              desc = " Find File",    icon = " ", key = "f" },
            { action = "ene | startinsert",                 desc = " New File",     icon = " ", key = "n" },
            { action = "Telescope oldfiles",                desc = " Recent Files", icon = " ", key = "r" },
            { action = "Telescope live_grep",               desc = " Find Text",    icon = " ", key = "g" },
            { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit", icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
            return { "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "mikavilpas/yazi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("yazi").setup({})
      vim.keymap.set("n", "<leader>e", "<cmd>Yazi<cr>", { desc = "Open yazi" })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end,            { desc = "Harpoon add" })
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
      vim.keymap.set("n", "<leader>1",  function() harpoon:list():select(1) end,        { desc = "Harpoon 1" })
      vim.keymap.set("n", "<leader>2",  function() harpoon:list():select(2) end,        { desc = "Harpoon 2" })
      vim.keymap.set("n", "<leader>3",  function() harpoon:list():select(3) end,        { desc = "Harpoon 3" })
      vim.keymap.set("n", "<leader>4",  function() harpoon:list():select(4) end,        { desc = "Harpoon 4" })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({})
      require("telescope").load_extension("fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>f.", function() builtin.find_files({ hidden = true }) end, { desc = "Telescope find files (hidden)" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    end,
  },
}
