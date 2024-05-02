return {

  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ansible-language-server",
        "ansible-lint",
        "arduino-language-server",
        "bash-debug-adapter",
        "bash-language-server",
        "beautysh",
        "black",
        "clangd",
        "dockerfile-language-server",
        "flake8",
        "flake8",
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
        "luaformatter",
        "markdownlint",
        "marksman",
        "nginx-language-server",
        "powershell-editor-services",
        "pylint",
        "python-lsp-server",
        "ruff-lsp",
        "shellcheck",
        "shellharden",
        "shfmt",
        "stylua",
        "terraform-ls",
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
      capabilities = {
        workspace = {
          didChangeWatchedFiles = { dynamicRegistration = false },
        },
      },
      ---@type lspconfig.options
      servers = {
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
        tsserver = {
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
        pyright = {
          enabled = true,
        },
        -- basedpyright = {
        --   enabled = lsp == "basedpyright",
        -- },
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
    config = function()
      local nullls = require("null-ls")
      nullls.register(require("none-ls-luacheck.diagnostics.luacheck"))
      nullls.register(require("none-ls-shellcheck.code_actions"))
      nullls.register(require("none-ls-shellcheck.diagnostics"))

      nullls.register(require("none-ls.formatting.beautysh"))
      nullls.register(require("none-ls.formatting.beautysh"))
      nullls.register(require("none-ls.formatting.jq"))

      nullls.register(require("null-ls.builtins.diagnostics.cppcheck"))
      nullls.register(require("null-ls.builtins.diagnostics.markdownlint"))
      nullls.register(require("null-ls.builtins.diagnostics.selene"))
      nullls.register(require("null-ls.builtins.diagnostics.tfsec"))
      nullls.register(require("null-ls.builtins.diagnostics.yamllint"))
      nullls.register(require("null-ls.builtins.diagnostics.zsh"))

      nullls.register(require("null-ls.builtins.formatting.astyle"))
      nullls.register(require("null-ls.builtins.formatting.black"))
      nullls.register(require("null-ls.builtins.formatting.gofumpt"))
      nullls.register(require("null-ls.builtins.formatting.hclfmt"))
      nullls.register(require("null-ls.builtins.formatting.isort"))
      nullls.register(require("null-ls.builtins.formatting.packer"))
      nullls.register(require("null-ls.builtins.formatting.prettier"))
      nullls.register(require("null-ls.builtins.formatting.shfmt"))
      nullls.register(require("null-ls.builtins.formatting.stylua"))
      nullls.register(require("null-ls.builtins.formatting.tidy"))
    end,
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
      "gbprod/none-ls-shellcheck.nvim",
      "gbprod/none-ls-luacheck.nvim",
    },
  }, -- null-ls config
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

      -- add markdownlint as diagnostics
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.markdownlint,
      })

      -- add misspell as diagnostics
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.diagnostics.misspell })

      -- add mypy as diagnostics
      opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.diagnostics.mypy })

      -- add ruff as diagnostics
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.diagnostics.ruff })

      -- add selene as diagnostics
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.selene,
      })

      -- add shellcheck as diagnostics
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.diagnostics.shellcheck })

      -- add terraform_validate as diagnostics
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.terraform_validate,
      })

      -- add tfsec as diagnostics
      opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.diagnostics.tfsec })

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

      -- FORMATTING

      -- add black as formatting
      opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.black })

      -- add beautysh as formatting
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.beautysh })

      -- add gofmt as formatting
      opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.gofmt })

      -- add gofumpt as formatting
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.formatting.gofumpt,
      })

      -- add hclfmt as formatting
      opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.hclfmt })

      -- add isort as formatting
      opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.isort })

      -- add lua_format as formatting
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.lua_format })

      -- add markdown_toc as formatting
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.markdown_toc })

      -- add nginx_beautifier as formatting
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.formatting.nginx_beautifier,
      })

      -- add packer as formatting
      opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.packer })

      -- add reorder_python_imports as formatting
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.reorder_python_imports })

      -- add shellharden as formatting
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.formatting.shellharden,
      })

      -- add shfmt as formatting
      opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.shfmt })

      -- add stylua as formatting
      opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.stylua })

      -- add terrafmt as formatting
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.terrafmt })

      -- add terraform_fmt as formatting
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.formatting.terraform_fmt,
      })

      -- add trim_newlines as formatting
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.trim_newlines })

      -- add trim_whitespace as formatting
      -- opts.sources = vim.list_extend(opts.sources, { null_ls.builtins.formatting.trim_whitespace })

      -- add yamlfix as formatting
      opts.sources = vim.list_extend(opts.sources, {
        null_ls.builtins.formatting.yamlfix,
      })

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



-- nvim-lspconfig.opts.autoformat` is deprecated. Please use `vim.g.autoformat` instead
