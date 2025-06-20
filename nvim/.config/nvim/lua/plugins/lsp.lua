return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jinja_lsp = {
          cmd = { "jinja-lsp", "--max-memory=4096" }, -- Allocate 4GB of memory
        },

        bashls = {
          on_init = function(client)
            local bufname = vim.api.nvim_buf_get_name(0)
            if bufname:match("%.env$") or bufname:match("%.env%..+$") then
              vim.schedule(function()
                vim.lsp.stop_client(client.id)
              end)
            end
          end,
        },

        pyright = {
          settings = {
            python = {
              analysis = {
                -- 👇 Tells pyright that "python/" is the import root
                extraPaths = { "./python", "./python/src" },
              },
            },
          },
        },

        ruff = {
          settings = {
            args = {
              "--config=pyproject.toml",
            },
          },
        },
      },
    },
  },
}
