return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  opts = {
    formatters_by_ft = {
      css = { "prettier" },
      graphql = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      json = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
      python = { "isort", "black" },
      ruby = { "rubocop" },
      terraform = { "terraform_fmt" },
      tf = { "terraform_fmt" },
      typescript = { "prettier" },
      yaml = { "prettier" },
      -- Moved here from none-ls so all formatting lives in one place (conform).
      go = { "gofumpt" },
      hcl = { "hclfmt" },
      sh = { "shfmt", "shellharden" },
      bash = { "shfmt", "shellharden" },
    },
  }
}
