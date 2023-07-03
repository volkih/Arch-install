--[[ Переменные ]]--
-- Пeременная для настройки опций Neovim
-- Все время использовать vim.opt- не удобно, поэтому сделаем алиас
local set = vim.opt
local cmd = vim.cmd
-- Глобальные переменные
-- То же самое делаем и с vim.global
local g = vim.g
--[[ Настройка панелей ]]--
-- Вертикальные сплиты становятся справа
-- По умолчанию панели в Neovim ставятся в зависимости от расположения текущей панели. Данная настройка поможет нам держать панели в порядке
set.splitright = true

-- Горизонтальные сплиты становятся снизу
set.splitbelow = true

--[[ Дополнительные настройки ]]--
-- Используем системный буфер обмена
set.clipboard = 'unnamedplus'

-- Отключаем дополнение файлов в конце
set.fixeol = false

-- Автодополнение (встроенное в Neovim)
set.completeopt = 'menuone,noselect'

-- Не автокомментировать новые линии при переходе на новую строку
cmd [[autocmd BufEnter * set fo-=c fo-=r fo-=o]]

-----------------------------------------------------------
-- Главные
-----------------------------------------------------------

cmd([[
filetype indent plugin on
syntax enable
set nocompatible "Отключает:syntax sync fromstart обратную совместимость с Vi
set wrap linebreak nolist
set mouse=a

let &t_SI.="\e[5 q" "SI = режим вставки
let &t_SR.="\e[3 q" "SR = режим замены
let &t_EI.="\e[1 q" "EI = нормальный режим


"Где 1 - это мигающий прямоугольник
"2 - обычный прямоугольник
"3 - мигающее подчёркивание
"4 - просто подчёркивание
"5 - мигающая вертикальная черта
"6 - просто вертикальная черта
]])

set.cursorline = true
set.textwidth = 80
set.showtabline = 0

set.number = true
set.scrolloff=7

set.fileformat = unix
set.spelllang = { 'en_us', 'ru_RU' } 
set.ttimeoutlen = 10 --Понижаем задержку ввода escape последовательностей
g.Powerline_symbols='unicode' --Поддержка unicode

set.guifont = { "Fira Code", ":h12" }




