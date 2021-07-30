-- Easier mapping
-----------------
local M = {}

M.map = function(mode, keys, action, bufnr, opts)
    local default_opts = { noremap = true, silent = true }
    opts = opts or default_opts
    opts = vim.tbl_extend("keep", opts, default_opts)
    if bufnr then
        vim.api.nvim_buf_set_keymap(bufnr, mode, keys, action, opts)
    else
        vim.api.nvim_set_keymap(mode, keys, action, opts)
    end
end

M.cmdi = function(mode, keys, action, bufnr, opts)
    local default_opts = { silent = false }
    opts = opts or default_opts
    opts = vim.tbl_extend("keep", opts, default_opts)
    M.map(mode, keys, ":" .. action, bufnr, opts)
end

M.cmd = function(mode, keys, action, bufnr, opts)
    M.map(mode, keys, "<cmd>" .. action .. "<cr>", bufnr, opts)
end

M.luai = function(mode, keys, action, bufnr, opts)
    M.cmdi(mode, keys, "lua " .. action, bufnr, opts)
end

M.lua = function(mode, keys, action, bufnr, opts)
    M.cmd(mode, keys, "lua " .. action, bufnr, opts)
end

M.plug = function(mode, keys, action, bufnr, opts)
    local default_opts = { noremap = false }
    opts = opts or default_opts
    opts = vim.tbl_extend("keep", opts, default_opts)
    M.map(mode, keys, "<Plug>(" .. action .. ")", bufnr, opts)
end

M.n = function(keys, action, bufnr, opts)
    M.map("n", keys, action, bufnr, opts)
end
M.ncmdi = function(keys, action, bufnr, opts)
    M.cmdi("n", keys, action, bufnr, opts)
end
M.ncmd = function(keys, action, bufnr, opts)
    M.cmd("n", keys, action, bufnr, opts)
end
M.nluai = function(keys, action, bufnr, opts)
    M.luai("n", keys, action, bufnr, opts)
end
M.nlua = function(keys, action, bufnr, opts)
    M.lua("n", keys, action, bufnr, opts)
end
M.nplug = function(keys, action, bufnr, opts)
    M.plug("n", keys, action, bufnr, opts)
end

M.v = function(keys, action, bufnr, opts)
    M.map("v", keys, action, bufnr, opts)
end
M.vcmdi = function(keys, action, bufnr, opts)
    local default_opts = { silent = false }
    opts = opts or default_opts
    opts = vim.tbl_extend("keep", opts, default_opts)
    M.v(keys, ":" .. action, bufnr, opts)
end
M.vcmd = function(keys, action, bufnr, opts)
    M.vcmdi(keys, action .. "<cr>", bufnr, opts)
end
M.vluai = function(keys, action, bufnr, opts)
    M.vcmdi(keys, "lua " .. action, bufnr, opts)
end
M.vlua = function(keys, action, bufnr, opts)
    M.vcmd(keys, "lua " .. action, bufnr, opts)
end
M.vplug = function(keys, action, bufnr, opts)
    M.plug("v", keys, action, bufnr, opts)
end

M.i = function(keys, action, bufnr, opts)
    M.map("i", keys, action, bufnr, opts)
end
M.ilua = function(keys, action, bufnr, opts)
    local default_opts = { expr = true }
    opts = opts or default_opts
    opts = vim.tbl_extend("keep", opts, default_opts)
    M.i(keys, "v:lua." .. action, bufnr, opts)
end
M.iplug = function(keys, action, bufnr, opts)
    M.plug("i", keys, action, bufnr, opts)
end

M.t = function(keys, action, bufnr, opts)
    M.map("t", keys, action, bufnr, opts)
end
M.tcmdi = function(keys, action, bufnr, opts)
    M.cmdi("t", keys, action, bufnr, opts)
end
M.tcmd = function(keys, action, bufnr, opts)
    M.cmd("t", keys, action, bufnr, opts)
end
M.tluai = function(keys, action, bufnr, opts)
    M.luai("t", keys, action, bufnr, opts)
end
M.tlua = function(keys, action, bufnr, opts)
    M.lua("t", keys, action, bufnr, opts)
end
M.tplug = function(keys, action, bufnr, opts)
    M.plug("t", keys, action, bufnr, opts)
end

return M
