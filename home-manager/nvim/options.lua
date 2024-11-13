local set = vim.opt

set.relativenumber = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true				-- make tabs spaces so formatting consistent across all platforms
set.clipboard = "unnamedplus"

set.laststatus = 3

set.showmode = false

vim.cmd([[
	" Filetype-specific settings
	augroup filetypes
		autocmd!
		" MIPS files: set tab width to 8 spaces
		autocmd BufRead,BufNewFile *.s setlocal ts=8 sw=8 sts=8

		" Config files should have 2 spaces
		autocmd FileType nix setlocal ts=2 sw=2 sts=2
		autocmd FileType lua setlocal ts=2 sw=2 sts=2
	augroup END
]])
