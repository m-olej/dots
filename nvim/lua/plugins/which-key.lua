return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = function()
    local harpoon = require("harpoon")

    -- Helper function to extract the filename from a Harpoon index
    local function get_harpoon_name(index)
      local item = harpoon:list():get(index)
      -- If the slot exists and has a value, return just the tail (filename)
      if item and item.value and item.value ~= "" then
        return vim.fn.fnamemodify(item.value, ":t")
      end
      return "Empty Slot"
    end

    return {
      spec = (function()
        local specs = {}
        -- Dynamically create Which-Key hints for slots 1 through 9
        for i = 1, 9 do
          table.insert(specs, { 
            "<leader>" .. i, 
            desc = function() return get_harpoon_name(i) end 
          })
        end
        return specs
      end)()
    }
  end,
}
