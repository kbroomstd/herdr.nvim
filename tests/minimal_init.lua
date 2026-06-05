local cwd = vim.fn.getcwd()

vim.opt.runtimepath:prepend(cwd)
vim.opt.runtimepath:prepend(cwd .. "/.tests/site/pack/deps/start/plenary.nvim")
vim.opt.packpath = { cwd .. "/.tests/site" }

vim.cmd("runtime! plugin/plenary.vim")
