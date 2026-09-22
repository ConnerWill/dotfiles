return {

  -- tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ansible-language-server",
        "ansible-lint",
        "arduino-language-server",
        "bash-debug-adapter",
        "bash-language-server",
        "clangd",
        "commitlint",
        "dockerfile-language-server",
        "gofumpt",
        "goimports",
        "gomodifytags",
        "gopls",
        "hadolint",
        "hclfmt",
        "html-lsp",
        "impl",
        "json-lsp",
        "lua-language-server",
        "luacheck",
        "markdownlint",
        "marksman",
        "nginx-language-server",
        "powershell-editor-services",
        -- Python: consolidated on basedpyright (types) + ruff (lint/format).
        -- Removed python-lsp-server, flake8, and pylint (all superseded by ruff).
        "basedpyright",
        "ruff", -- was "ruff-lsp" (deprecated); ruff now ships the LSP directly
        "shellcheck",
        "shellharden",
        "shfmt",
        "stylua",
        "terraform-ls",
        "tflint",
        "trivy", -- terraform security scanning (replaces deprecated tfsec)
        "write-good",
        "yaml-language-server",
        "yamlfix",
        "yamlfmt",
        "yamllint",
        "yq",
      })
    end,
  }, -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- autoformat = false, -- Disable autoformat -- nvim-lspconfig.opts.autoformat` is deprecated. Please use `vim.g.autoformat` instead
      inlay_hints = { enabled = true },
      servers = {
        ["*"] = {
          capabilities = {
            workspace = {
              didChangeWatchedFiles = { dynamicRegistration = false },
            },
          },
        },
        ansiblels = {},
        bashls = {},
        -- clangd = {},
        -- denols = {},
        cssls = {},
        dockerls = {},
        -- groovyls = {},
        -- ruff_lsp = {},
        -- tailwindcss = {
        --   root_dir = function(...)
        --     return require("lspconfig.util").root_pattern(".git")(...)
        --   end,
        -- },
        ts_ls = {
          -- root_dir = function(...)
          --   return require("lspconfig.util").root_pattern(".git")(...)
          -- end,
          single_file_support = false,
          settings = {
            -- typescript = {
            --   inlayHints = {
            --     includeInlayParameterNameHints = "literal",
            --     includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            --     includeInlayFunctionParameterTypeHints = true,
            --     includeInlayVariableTypeHints = false,
            --     includeInlayPropertyDeclarationTypeHints = true,
            --     includeInlayFunctionLikeReturnTypeHints = true,
            --     includeInlayEnumMemberValueHints = true,
            --   },
            -- },
            -- javascript = {
            --   inlayHints = {
            --     includeInlayParameterNameHints = "all",
            --     includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            --     includeInlayFunctionParameterTypeHints = true,
            --     includeInlayVariableTypeHints = true,
            --     includeInlayPropertyDeclarationTypeHints = true,
            --     includeInlayFunctionLikeReturnTypeHints = true,
            --     includeInlayEnumMemberValueHints = true,
            --   },
            -- },
          },
        },
        -- svelte = {},
        html = {},
        -- gopls = {},
        marksman = {},
        -- Type checking: basedpyright (community fork of pyright with stricter
        -- defaults and extra rules). Matches [tool.basedpyright] used in the
        -- ansible-piauto project. Plain pyright is disabled so only one type
        -- checker runs in-editor.
        pyright = { enabled = false },
        pylsp = { enabled = false }, -- python-lsp-server: superseded by basedpyright+ruff, keep disabled
        basedpyright = {
          enabled = true,
        },
        -- rust_analyzer = {
        -- settings = {
        --   ["rust-analyzer"] = {
        --     procMacro = { enable = true },
        --     cargo = { allFeatures = true },
        --     checkOnSave = {
        --       command = "clippy",
        --       extraArgs = { "--no-deps" },
        --     },
        --   },
        -- },
        -- },
        yamlls = { settings = { yaml = { keyOrdering = false } } },
        lua_ls = {
          -- enabled = false,
          -- cmd = { "/home/folke/projects/lua-language-server/bin/lua-language-server" },
          single_file_support = true,
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hover = { expandAlias = false },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = { privateName = { "^_" } },
              type = { castNumberToInteger = true },
              diagnostics = {
                disable = {
                  "incomplete-signature-doc",
                  -- "trailing-space"
                },
                -- enable = false,
                globals = {
                  "vim",
                },
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = true,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        vimls = {},
      },
      setup = {},
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = {
          prefix = "icons",
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        lua = { "selene", "luacheck" },
        markdown = { "markdownlint" },
      },
      linters = {
        selene = {
          condition = function(ctx)
            return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function(ctx)
            return vim.fs.find({ ".luacheckrc" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")

      -- CODE ACTIONS

      -- add shellcheck as code_action
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.code_actions.shellcheck })

      -- COMPLETION

      -- add luasnip as completion
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.completion.luasnip,
      })

      -- DIAGNOSTICS

      -- add actionlint as diagnostics
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.actionlint,
      })

      -- add ansible-lint as diagnostics
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.ansiblelint,
      })

      -- add dotenv_linter as diagnostics
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.dotenv_linter,
      })

      -- add luacheck as diagnostics
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.diagnostics.luacheck })

      -- markdownlint is handled by nvim-lint above (not registered here).

      -- add misspell as diagnostics
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.diagnostics.misspell })

      -- type checking is handled by basedpyright (see LSP servers above).
      -- mypy is intentionally NOT registered here to avoid a redundant second
      -- type checker producing potentially conflicting diagnostics.

      -- add ruff as diagnostics
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.diagnostics.ruff })

      -- selene/luacheck (Lua) and markdownlint are handled by nvim-lint above,
      -- so they are intentionally NOT registered here to avoid duplicate diagnostics.

      -- add shellcheck as diagnostics
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.diagnostics.shellcheck })

      -- add terraform_validate as diagnostics
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.terraform_validate,
      })

      -- terraform security scanning is handled by trivy below.
      -- tfsec was merged into trivy upstream, so it is intentionally NOT
      -- registered here to avoid duplicate Terraform diagnostics.

      -- add trailspace as diagnostics
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.trail_space,
      })

      -- add trivy as diagnostics (terraform)
      opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.diagnostics.trivy })

      -- add yamllint as diagnostics
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.yamllint,
      })

      -- add zsh as diagnostics
      opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.diagnostics.zsh })

      -- FORMATTING is handled by conform.nvim (see conform.lua), not none-ls,
      -- to avoid competing format-on-save providers.

      -- HOVER

      -- add dictionary as hover
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.dictionary })

      -- add printenv as hover
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.printenv })

      -- REMOVE

      -- remove flake8 from opts.sources
      -- opts.sources = vim.tbl_filter(function(source)
      --   return source.name ~= "flake8"
      -- end, opts.sources)
    end,

    dependencies = { "gbprod/none-ls-shellcheck.nvim" },
  },

  -- Jenkinsfile linter
  {
    "ckipp01/nvim-jenkinsfile-linter",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
