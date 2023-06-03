-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, 'packer')
if not status then
    return
end

return packer.startup(function(use)
    use('wbthomason/packer.nvim') -- packer itself

    use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

    use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme

    use('Mofiqul/dracula.nvim') -- colorscheme

    use {
        'junegunn/fzf.vim',
        requires = {
            'junegunn/fzf',
            run = ':call fzf#install()'
        }
    } -- fuzzy finder

    use('christoomey/vim-tmux-navigator') -- navigate between vim and tmux

    use('szw/vim-maximizer') -- maximize vim window

    use('tpope/vim-surround') -- surround text objects

    use('vim-scripts/ReplaceWithRegister') -- replace text with register

    use('numToStr/Comment.nvim') -- comment text objects

    use('nvim-tree/nvim-tree.lua') -- file explorer

    use('kyazdani42/nvim-web-devicons')

    use('nvim-lualine/lualine.nvim') -- statusline

    -- fuzzy finding w/ telescope
    --- require brew install ripgrep
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make"
    }) -- dependency for better sorting performance
    use({
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x"
    }) -- fuzzy finder

    -- autocompletion
    use("hrsh7th/nvim-cmp") -- completion plugin
    use("hrsh7th/cmp-buffer") -- source for text in buffer
    use("hrsh7th/cmp-path") -- source for file system paths

    -- snippets
    use("L3MON4D3/LuaSnip") -- snippet engine
    use("saadparwaiz1/cmp_luasnip") -- for autocompletion
    use("rafamadriz/friendly-snippets") -- useful snippets

    -- github copilot
    use("github/copilot.vim")

    if packer_bootstrap then
        require('packer').sync()
    end
end)
