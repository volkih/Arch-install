local g = vim.g

local set = vim.opt
------------------LATEX-----------------------

g.vimtex_compiler_method = 'latex'
g.vimtex_view_method='zathura'
g.vimtex_quickfix_mode=0
g.tex_conceal='abdmg'
--To conceal fraction (½⅓⅔¼⅕⅖⅗⅘⅙⅚⅛⅜⅝⅞)

g.tex_conceal_frac=1
set.conceallevel = 2

g.tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
g.tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"


