local status, _ = pcall(vim.cmd, "colorscheme dracula")

if not status then
    print("colorscheme dracula not found, using default")
    vim.cmd("colorscheme default")
end
