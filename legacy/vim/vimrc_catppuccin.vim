################################################################################
# CATPPUCCIN MOCHA PALETTE & HIGHLIGHTS
################################################################################
set background=dark

# Map Catppuccin Mocha hexadecimal colors to standard names in Vim 9
v:colornames['ct_rosewater'] = '#f5e0dc'
v:colornames['ct_flamingo']  = '#f2cdcd'
v:colornames['ct_pink']      = '#f5c2e7'
v:colornames['ct_mauve']     = '#cba6f7'
v:colornames['ct_red']       = '#f38ba8'
v:colornames['ct_maroon']    = '#eba0ac'
v:colornames['ct_peach']     = '#fab387'
v:colornames['ct_yellow']    = '#f9e2af'
v:colornames['ct_green']     = '#a6e3a1'
v:colornames['ct_teal']      = '#94e2d5'
v:colornames['ct_sky']       = '#89dceb'
v:colornames['ct_sapphire']  = '#74c7ec'
v:colornames['ct_blue']      = '#89b4fa'
v:colornames['ct_lavender']  = '#b4befe'
v:colornames['ct_text']      = '#cdd6f4'
v:colornames['ct_subtext1']  = '#bac2de'
v:colornames['ct_subtext0']  = '#a6adc8'
v:colornames['ct_overlay2']  = '#9399b2'
v:colornames['ct_overlay1']  = '#7f849c'
v:colornames['ct_overlay0']  = '#6c7086'
v:colornames['ct_surface2']  = '#585b70'
v:colornames['ct_surface1']  = '#45475a'
v:colornames['ct_surface0']  = '#313244'
v:colornames['ct_base']      = '#1e1e2e'
v:colornames['ct_mantle']    = '#181825'
v:colornames['ct_crust']     = '#11111b'

def ApplyCatppuccinMocha()
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
  g:colors_name = "catppuccin_mocha"

  # Core UI
  hi Normal           guifg=ct_text      guibg=ct_base
  hi Visual           guifg=NONE         guibg=ct_surface1
  hi Search           guifg=ct_base      guibg=ct_sky
  hi IncSearch        guifg=ct_base      guibg=ct_pink
  hi MatchParen       guifg=ct_peach     guibg=NONE         gui=underline
  hi Question         guifg=ct_blue      guibg=NONE
  hi MoreMsg          guifg=ct_blue      guibg=NONE
  hi WarningMsg       guifg=ct_yellow    guibg=NONE
  hi ErrorMsg         guifg=ct_red       guibg=NONE         gui=bold

  # Gutter & Line Numbers
  hi LineNr           guifg=ct_surface1  guibg=ct_base
  hi CursorLineNr     guifg=ct_mauve     guibg=ct_base      gui=bold cterm=NONE
  hi SignColumn       guifg=ct_surface1  guibg=ct_base
  hi FoldColumn       guifg=ct_overlay0  guibg=ct_base
  hi Folded           guifg=ct_overlay0  guibg=ct_surface0

  # Cursorline
  hi CursorLine       guifg=NONE         guibg=ct_surface0
  hi CursorColumn     guifg=NONE         guibg=ct_surface0

  # Splits & Statusline (Dark Mocha Style)
  hi VertSplit        guifg=ct_surface1  guibg=ct_base      gui=NONE cterm=NONE
  hi StatusLine       guifg=ct_text      guibg=ct_mantle    gui=NONE cterm=NONE
  hi StatusLineNC     guifg=ct_overlay0  guibg=ct_crust     gui=NONE cterm=NONE
  hi StatusLineTerm   guifg=ct_text      guibg=ct_mantle    gui=NONE cterm=NONE
  hi StatusLineTermNC guifg=ct_overlay0 guibg=ct_crust      gui=NONE cterm=NONE

  # Popup Menu (Autocomplete)
  hi Pmenu            guifg=ct_text      guibg=ct_surface0
  hi PmenuSel         guifg=ct_base      guibg=ct_mauve     gui=bold
  hi PmenuSbar        guifg=NONE         guibg=ct_surface1
  hi PmenuThumb       guifg=NONE         guibg=ct_overlay0

  # Tabs
  hi TabLine          guifg=ct_overlay0  guibg=ct_mantle    gui=NONE
  hi TabLineSel       guifg=ct_text      guibg=ct_base      gui=bold
  hi TabLineFill      guifg=NONE         guibg=ct_crust

  # Diff
  hi DiffAdd          guifg=NONE         guibg=#26332d
  hi DiffChange       guifg=NONE         guibg=#242d3a
  hi DiffDelete       guifg=NONE         guibg=#3a232b
  hi DiffText         guifg=NONE         guibg=#394b59

  # Syntax Highlighting
  hi Comment          guifg=ct_overlay0  gui=italic
  hi Constant         guifg=ct_peach
  hi String           guifg=ct_green
  hi Character        guifg=ct_teal
  hi Number           guifg=ct_peach
  hi Boolean          guifg=ct_peach
  hi Float            guifg=ct_peach
  hi Identifier       guifg=ct_flamingo
  hi Function         guifg=ct_blue
  hi Statement        guifg=ct_mauve
  hi Conditional      guifg=ct_mauve
  hi Repeat           guifg=ct_mauve
  hi Label            guifg=ct_mauve
  hi Operator         guifg=ct_sky
  hi Keyword          guifg=ct_mauve
  hi Exception        guifg=ct_mauve
  hi PreProc          guifg=ct_pink
  hi Include          guifg=ct_mauve
  hi Define           guifg=ct_mauve
  hi Macro            guifg=ct_mauve
  hi PreCondit        guifg=ct_mauve
  hi Type             guifg=ct_yellow
  hi StorageClass     guifg=ct_yellow
  hi Structure        guifg=ct_yellow
  hi Typedef          guifg=ct_yellow
  hi Special          guifg=ct_pink
  hi SpecialChar      guifg=ct_pink
  hi Tag              guifg=ct_mauve
  hi Delimiter        guifg=ct_overlay2
  hi SpecialComment   guifg=ct_overlay2
  hi Debug            guifg=ct_peach
  hi Underlined       gui=underline
  hi Ignore           guifg=ct_overlay0
  hi Error            guifg=ct_red       guibg=NONE         gui=bold
  hi Todo             guifg=ct_base      guibg=ct_yellow    gui=bold

  # End of buffer tildes (~) and non-text characters
  hi EndOfBuffer     guifg=ct_surface1  guibg=ct_base
  hi NonText         guifg=ct_surface1  guibg=ct_base
enddef

# Automatically load theme
ApplyCatppuccinMocha()

