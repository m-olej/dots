return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    require("telescope").load_extension('harpoon')
    harpoon:setup({})

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        }):find()
    end

    harpoon.ui.toggle_telescope = function()
      toggle_telescope(harpoon:list())
    end

    -- Keymaps
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon Add File" })
    vim.keymap.set("n", "<leader>d", function() harpoon:list():remove() end, { desc = "Harpoon Delete File" })
    vim.keymap.set("n", "<leader>e", function() harpoon.ui.toggle_telescope() end, { desc = "Harpoon (Telescope)" })
    
    -- Open Native UI (For EDITING indexes with dd, p, etc.)
    vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Edit Indexes" })

    -- ==========================================
    -- 3. Breaking the Hardcoded Limits
    -- ==========================================
    
    -- Option A: Infinite Cycling (No numbers needed!)
    vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon Prev Buffer" })
    vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon Next Buffer" })

    -- Option B: Dynamically generate keys 1 through 9
    for i = 1, 9 do
      vim.keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end, { desc = "Harpoon " .. i })
    end
  end,
}
