(module core
  {autoload {nvim aniseed.nvim}})

;; Generic Neovim configuration.
(set nvim.o.inccommand :split)

(nvim.ex.set :spell)
(nvim.ex.set :list)

(set nvim.o.backup false)                           ;; creates a backup file
(set nvim.o.clipboard "unnamedplus")                ;; allows neovim to access the system clipboard
(set nvim.o.cmdheight 2)                            ;; more space in the neovim command line for displaying messages
(set nvim.o.completeopt "menuone,noselect")         ;; mostly just for cmp
(set nvim.o.conceallevel 0)                         ;; so that `` is visible in markdown files
(set nvim.o.fileencoding "utf-8")                   ;; the encoding written to a file
(set nvim.o.hlsearch true)                          ;; highlight all matches on previous search pattern
(set nvim.o.ignorecase true)                        ;; ignore case in search patterns
(set nvim.o.mouse "a")                              ;; allow the mouse to be used in neovim
(set nvim.o.pumheight 10)                           ;; pop up menu height
(set nvim.o.showmode false)                         ;; we don't need to see things like ;; INSERT ;; anymore
(set nvim.o.showtabline 2)                          ;; always show tabs
(set nvim.o.smartcase true)                         ;; smart case
(set nvim.o.smartindent true)                       ;; make indenting smarter again
(set nvim.o.splitbelow true)                        ;; force all horizontal splits to go below current window
(set nvim.o.splitright true)                        ;; force all vertical splits to go to the right of current window
(set nvim.o.swapfile false)                         ;; creates a swapfile
(set nvim.o.termguicolors true)                     ;; set term gui colors (most terminals support this)
(set nvim.o.timeoutlen 500)                         ;; time to wait for a mapped sequence to complete (in milliseconds)
(set nvim.o.undofile true)                          ;; enable persistent undo
(set nvim.o.updatetime 500)                         ;; faster completion (4000ms default)
(set nvim.o.writebackup false)                      ;; if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
(set nvim.o.expandtab true)                         ;; convert tabs to spaces
(set nvim.o.shiftwidth 2)                           ;; the number of spaces inserted for each indentation
(set nvim.o.tabstop 2)                              ;; insert 2 spaces for a tab
(set nvim.o.cursorline false)                       ;; highlight the current line
(set nvim.o.number true)                            ;; set numbered lines
(set nvim.o.relativenumber true)                    ;; set relative numbered lines
(set nvim.o.numberwidth 1)                          ;; set number column width to 2 {default 4}
;; (set nvim.o.signcolumn "no")                     ;; shift the left column by a fixed amount for line numbers
(set nvim.o.wrap false)                             ;; display lines as one long line
(set nvim.o.scrolloff  8)                           ;; is one of my fav
(set nvim.o.sidescrolloff 8)
(set nvim.o.guifont "JetBrainsMono:h17")            ;; the font used in graphical neovim applications
(set nvim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
