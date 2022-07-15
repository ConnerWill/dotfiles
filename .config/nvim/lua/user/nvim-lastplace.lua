-- local status_ok, lastpace = pcall(require, "nvim-lastplace")
-- if not status_ok then
--   return
-- end

require'nvim-lastplace'.setup{
  lastplace_ignore_buftype = {
    "quickfix",
    "nofile"
  },
  lastplace_ignore_filetype = {
    "gitcommit",
    "gitrebase",
    "svn",
    "hgcommit"
  },
  lastplace_open_folds = true
}
