return function()
  require("presence").setup({
    auto_update = true,
    neovim_image_text = "neovim",
    -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    blacklist = {},
    show_time = false,

    -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`,
    -- or a function(buffer: string, repo_url: string|nil): table)
    --
    -- we have to reimplement this in my repo beacuse it breaks when using custom urls, so i have a check to alter the url based on what it provides
    buttons = function(_, parent_dirpath)
      -- Retrieve the git repository URL
      local repo_url
      if parent_dirpath then
        -- Escape quotes in the file path
        local path = parent_dirpath:gsub([["]], [[\"]])
        local git_url_cmd = "git config --get remote.origin.url"
        local cmd = string.format([[cd "%s" && %s]], path, git_url_cmd)

        -- Trim and coerce empty string value to nil
        repo_url = vim.trim(vim.fn.system(cmd))
        repo_url = repo_url ~= "" and repo_url or nil
      end

      -- Proceed if repo_url is valid
      if repo_url then
        -- Handle short SSH syntax
        local domain, project = repo_url:match("^git@(.+):(.+)$")
        if domain and project then
          repo_url = string.format("https://%s/%s", domain, project)
        end

        -- Custom protocols
        local custom_protocols = {
          github = "https://github.com/",
          gitlab = "https://gitlab.com/",
          aur = "https://aur.archlinux.org/",
          srht = "https://git.sr.ht/",
          codeberg = "https://codeberg.org/",
          me = "https://git.isabelroses.com/",
          aux = "https://git.auxolotl.org/",
        }

        -- Check if repo URL uses a valid custom protocol
        local protocol, relative = repo_url:match("^(.-):(.+)$")
        if custom_protocols[protocol] and relative then
          repo_url = custom_protocols[protocol] .. relative
          return { { label = "View Repository", url = repo_url } }
        end

        -- Check if repo URL uses a valid standard protocol
        local protocols = { "ftp", "git", "http", "https", "ssh" }
        protocol, relative = repo_url:match("^(.+)://(.+)$")
        if protocol and relative then
          if vim.tbl_contains(protocols, protocol) then
            return { { label = "View Repository", url = repo_url } }
          end
        end
      end

      return nil
    end,
  })
end
