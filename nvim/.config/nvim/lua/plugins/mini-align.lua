-- Add this to your plugins.lua file
return {
  -- other plugins
  {
    "echasnovski/mini.align",
    config = function()
      require("mini.align").setup()
    end,
  },
}
