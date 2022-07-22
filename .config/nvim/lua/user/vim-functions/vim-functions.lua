-- local status_ok, nvim_lastpace = pcall(require, "nvim-lastplace")
-- if not status_ok then
--   return
-- end
--

vim.cmd([[
  " Opening help in the current window				*help-curwin*
  "
  " By default, help is displayed in a split window.  If you prefer it opens in
  " the current window, try this custom `:HelpCurwin` command:
  " 
  command -bar -nargs=? -complete=help HelpCurwin execute s:HelpCurwin(<q-args>)
  let s:did_open_help = v:false

  function s:HelpCurwin(subject) abort
    let mods = 'silent noautocmd keepalt'
    if !s:did_open_help
      execute mods .. ' help'
      execute mods .. ' helpclose'
      let s:did_open_help = v:true
    endif
    if !empty(getcompletion(a:subject, 'help'))
      execute mods .. ' edit ' .. &helpfile
      set buftype=help
    endif
    return 'help ' .. a:subject
  endfunction
]])

