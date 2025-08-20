if vim.g.loaded_session then
  return
end

vim.g.loaded_session = true

local session = {}

function session.get_uri()
  return string.gsub(vim.fn.getcwd(), "[^a-zA-Z0-9_.-]", function(s)
    return "<" .. vim.fn.char2nr(s)
  end)
end

local sessiondir = vim.g.sessiondir or vim.fs.joinpath(vim.fn.stdpath("state"), "sessions")

function session.get_path()
  return vim.fs.joinpath(sessiondir, session.get_uri() .. ".vim")
end

function session.save()
  local session_file = session.get_path()

  vim.fn.mkdir(sessiondir, "p")

  vim.api.nvim_cmd({
    cmd = "mksession",
    bang = true,
    args = { vim.fn.escape(session_file, "%") },
  }, {})
end

function session.clean()
  vim.iter(ipairs(vim.api.nvim_list_bufs())):each(function(_, bufnr)
    if vim.bo[bufnr].buftype ~= "" then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end)
end

function session.load()
  local path = session.get_path()
  if vim.uv.fs_stat(path) then
    vim.api.nvim_cmd({
      cmd = "source",
      args = { vim.fn.escape(path, "%") },
    }, {})
    vim.api.nvim_exec_autocmds("SessionLoadPost", {})
  end
end

local group = vim.api.nvim_create_augroup("izvim:session", { clear = true })

vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
  group = group,
  callback = function()
    session.clean()
    session.save()
  end,
})

if vim.fn.argc() > 0 then
  return
end
vim.schedule(function()
  session.load()
end)
