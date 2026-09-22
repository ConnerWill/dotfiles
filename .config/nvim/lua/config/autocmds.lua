-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Define locals
local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd
local create_nvim_command = vim.api.nvim_command
create_augroup("file_types", { clear = true })

-- Autocommand to set filetype for Jenkinsfile to groovy
create_autocmd({ "BufEnter", "BufRead", "BufNewFile" }, {
  desc = "Recognize Jenkins files as groovy",
  group = "file_types",
  pattern = { "*.Jenkinsfile", "*.jenkinsfile", "Jenkinsfile", "jenkinsfile" },
  command = [[ set filetype=groovy ]],
})

-- Scoped YAML filetype detection.
--
-- Previously an autocmd tagged EVERY *.yaml/*.yml file as yaml.ansible, which
-- caused ansible-lint and the Ansible YAML schema to run against non-Ansible
-- YAML (docker-compose, k8s manifests, CI configs, etc.) and produce false
-- positives. Instead we scope detection to well-known conventions:
--
--   * Docker Compose files  -> yaml.docker-compose
--   * Ansible files         -> yaml.ansible
--
-- yamlls natively understands the "yaml.docker-compose" filetype and, together
-- with SchemaStore.nvim (enabled via the LazyVim yaml extra), applies the
-- Compose schema for completion + validation automatically.
--
-- Priorities are set explicitly because Lua table key order is not
-- deterministic: the specific Compose/Ansible rules must outrank the generic
-- ".*%.ya?ml" Ansible content fallback.
vim.filetype.add({
  pattern = {
    -- Docker Compose: match common compose filenames anywhere in the tree.
    [".*/docker%-compose[^/]*%.ya?ml"] = { "yaml.docker-compose", { priority = 100 } },
    [".*/compose[^/]*%.ya?ml"] = { "yaml.docker-compose", { priority = 100 } },
    ["docker%-compose[^/]*%.ya?ml"] = { "yaml.docker-compose", { priority = 100 } },
    ["compose[^/]*%.ya?ml"] = { "yaml.docker-compose", { priority = 100 } },

    -- Standard Ansible layout: playbooks, roles, and *_vars directories.
    [".*/playbooks/.*%.ya?ml"] = { "yaml.ansible", { priority = 100 } },
    [".*/roles/.*/tasks/.*%.ya?ml"] = { "yaml.ansible", { priority = 100 } },
    [".*/roles/.*/handlers/.*%.ya?ml"] = { "yaml.ansible", { priority = 100 } },
    [".*/roles/.*/meta/.*%.ya?ml"] = { "yaml.ansible", { priority = 100 } },
    [".*/group_vars/.*%.ya?ml"] = { "yaml.ansible", { priority = 100 } },
    [".*/host_vars/.*%.ya?ml"] = { "yaml.ansible", { priority = 100 } },
    -- Common top-level playbook/inventory names.
    ["site%.ya?ml"] = { "yaml.ansible", { priority = 100 } },
    ["playbook%.ya?ml"] = { "yaml.ansible", { priority = 100 } },

    -- Content-based fallback for Ansible files outside the standard layout.
    -- Lower priority so the specific rules above win. Also bails out if the
    -- file looks like Compose so it is never mislabeled as Ansible.
    [".*%.ya?ml"] = function(path, bufnr)
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 40, false)
      for _, line in ipairs(lines) do
        -- Compose marker: leave it as plain yaml (yamlls + SchemaStore handle
        -- Compose by filename, so no yaml.docker-compose tag needed here).
        if line:match("^services:%s*$") then
          return
        end
        if line:match("^%s*%-?%s*hosts:%s") or line:match("^%s*tasks:%s*$") or line:match("^%s*ansible%.builtin%.") then
          return "yaml.ansible"
        end
      end
      -- Return nil to fall through to Neovim's default yaml detection.
    end,
  },
})

-- show cursor line only in active window
create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

-- create directories when needed, when saving a file
create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("better_backup", { clear = true }),
  callback = function(event)
    local file = vim.uv.fs_realpath(event.match) or event.match
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

-- Go straight to INSERT mode in commit message
create_autocmd({ "VimEnter" }, {
  desc = "Go straight to INSERT mode in commit message",
  group = "file_types",
  pattern = { "COMMIT_EDITMSG" },
  command = [[ exec 'norm gg' | startinsert! ]],
})
