return function()
    require("session_manager").setup({
        autoload_mode = "CurrentDir",
    })

    local function apply_gradient_hl(text)
        local lines = {}
        for i, line in ipairs(text) do
            local tbl = {
                type = "text",
                val = line,
                opts = {
                    hl = "HeaderGradient" .. i,
                    shrink_margin = false,
                    position = "center",
                },
            }
            table.insert(lines, tbl)
        end

        return {
            type = "group",
            val = lines,
            opts = { position = "center" },
        }
    end

    local alpha = require("alpha")
    local theta = require("alpha.themes.theta")
    local dashboard = require("alpha.themes.dashboard")

    local header = {
        "          ':::::    ':::::.  ::::'         ",
        "            :::::     '::::.:::::          ",
        "      .......:::::..... ::::::::           ",
        "     ::::::::::::::::::. ::::::    ::::.   ",
        "    ::::::::::::::::::::: :::::.  .::::'   ",
        "           .....           ::::' :::::'    ",
        "          :::::            '::' :::::'     ",
        " ........:::::               ' :::::::::::.",
        ":::::::::::::                 :::::::::::::",
        " ::::::::::: ..              :::::         ",
        "     .::::: .:::            :::::          ",
        "    .:::::  :::::          '''''    .....  ",
        "    :::::   ':::::.  ......:::::::::::::'  ",
        "     :::     ::::::. ':::::::::::::::::'   ",
        "            .:::::::: '::::::::::          ",
        "           .::::''::::.     '::::.         ",
        "          .::::'   ::::.     '::::.        ",
        "         .::::      ::::      '::::.       ",
        " ",
    }

    local buttons = {
        type = "group",
        position = "center",
        val = {
            dashboard.button("n", "  New file", ":ene <bar> startinsert <cr>"),
            dashboard.button("SPC SPC", "  Find file", ":Telescope find_files<cr>"),
            dashboard.button("SPC fs", "  Live grep", ":Telescope live_grep<cr>"),
            dashboard.button("s", "  Show sessions", ":SessionManager load_session<cr>"),
            dashboard.button("SPC fp", "  Projects", ":Telescope project<CR>"),
            dashboard.button("q", "  Quit", ":qa<CR>"),
        },
    }

    local v = vim.version()
    local vStr = string.format("v%d.%d.%d", v.major, v.minor, v.patch)

    local footer = {
        type = "group",
        position = "center",
        val = {
            {
                type = "text",
                val = "neovim " .. vStr,
                opts = { hl = "Comment", position = "center" },
            },
            {
                type = "text",
                val = require("lazy").stats().count .. " plugins",
                opts = { hl = "Comment", position = "center" },
            },
        },
    }
    dashboard.config.opts.noautocmd = true

    theta.config.layout = {
        { type = "padding", val = 4 },
        apply_gradient_hl(header),
        { type = "padding", val = 1 },
        buttons,
        { type = "padding", val = 1 },
        footer,
    }

    alpha.setup(theta.config)
end
