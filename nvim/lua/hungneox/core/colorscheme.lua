local status, _ = pcall(vim.cmd, "colorscheme catppuccin-frappe")

if not status then
    print("colorscheme catppuccin-frappe not found, using default")
    vim.cmd("colorscheme default")
end
