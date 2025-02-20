require('nvim-tree')
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

nvim_tree.setup({
    on_attach = on_attach,

    disable_netrw = true,
    view = {
        adaptive_size = true,
        centralize_selection = true,
        number = false,
        relativenumber = false,
    },
    renderer = {
        group_empty = true,
        highlight_git = true,
        --highlight_opened_files = "all",
    },
    update_focused_file = {
        enable = true,
    },

    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    actions = {
        change_dir = {
            enable = false,
        },
				open_file = {
						quit_on_open = true,
				},
    },
})

-- auto close
local function is_modified_buffer_open(buffers)
    for _, v in pairs(buffers) do
        if v.name:match("NvimTree_") == nil then
            return true
        end
    end
    return false
end

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if
            #vim.api.nvim_list_wins() == 1
            and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil
            and is_modified_buffer_open(vim.fn.getbufinfo({ bufmodified = 1 })) == false
        then
            vim.cmd("quit")
        end
    end,
})
