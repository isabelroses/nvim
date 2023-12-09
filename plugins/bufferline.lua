return function()
    local bufferline = require("bufferline")
    local ctp = require("catppuccin.groups.integrations.bufferline").get()

    local v = vim.version()
    local vStr = string.format("v%d.%d.%d", v.major, v.minor, v.patch)

    bufferline.setup({
        highlights = ctp,
        options = {
            show_close_icon = false,
            show_buffer_close_icons = false,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "   neovim " .. vStr,
                    text_align = "left",
                    separator = vim.g.bc.vert,
                },
            },
            left_mouse_command = "buffer %d",
            middle_mouse_command = "bdelete! %d",
            right_mouse_command = nil,
            numbers = "ordinal",
        },
    })

    local nmap = function(key, cmd)
        vim.api.nvim_set_keymap("n", key, cmd, { noremap = true, silent = true })
    end

    -- hop between buffers in order of the bar
    nmap("<A-,>", "<Cmd>BufferLineCyclePrev<CR>")
    nmap("<A-.>", "<Cmd>BufferLineCycleNext<CR>")
    -- Re-order to previous/next
    nmap("<A-<>", "<Cmd>BufferLineMovePrev<CR>")
    nmap("<A->>", "<Cmd>BufferLineMoveNext<CR>")
    -- stylua: ignore start
    -- Goto buffer in position...
    nmap("<A-1>", "<cmd>lua require('bufferline').go_to(1, true)<cr>")
    nmap("<A-2>", "<cmd>lua require('bufferline').go_to(2, true)<cr>")
    nmap("<A-3>", "<cmd>lua require('bufferline').go_to(3, true)<cr>")
    nmap("<A-4>", "<cmd>lua require('bufferline').go_to(4, true)<cr>")
    nmap("<A-5>", "<cmd>lua require('bufferline').go_to(5, true)<cr>")
    nmap("<A-6>", "<cmd>lua require('bufferline').go_to(6, true)<cr>")
    nmap("<A-7>", "<cmd>lua require('bufferline').go_to(7, true)<cr>")
    nmap("<A-8>", "<cmd>lua require('bufferline').go_to(8, true)<cr>")
    nmap("<A-9>", "<cmd>lua require('bufferline').go_to(9, true)<cr>")
    nmap("<A-0>", "<cmd>lua require('bufferline').go_to(-1, true)<cr>")
    -- stylua: ignore end
    -- Pin/unpin buffer
    nmap("<A-p>", "<Cmd>BufferLineTogglePin<CR>")
    -- Close buffer
    nmap("<A-x>", "<Cmd>bdelete<CR>")
    nmap("<A-X>", "<Cmd>bdelete!<CR>")
    -- create new buffer
    nmap("<A-c>", "<Cmd>enew<CR>")
    -- pick buffer
    nmap("<A-space>", "<Cmd>BufferLinePick<CR>")
    -- Sort automatically by...
    nmap("<Space>bd", "<Cmd>BufferLineSortByDirectory<CR>")
    nmap("<Space>bl", "<Cmd>BufferLineSortByExtension<CR>")
end
