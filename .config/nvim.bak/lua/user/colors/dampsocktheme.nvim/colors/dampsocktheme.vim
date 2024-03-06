" clear cache so this reloads changes.
" useful for development
" lua package.loaded['dampsocktheme'] = nil
" lua package.loaded['dampsocktheme.theme'] = nil
" lua package.loaded['dampsocktheme.colors'] = nil
" lua package.loaded['dampsocktheme.util'] = nil
lua package.loaded['dampsocktheme.config'] = nil

lua require('dampsocktheme').colorscheme()
