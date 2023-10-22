G = {}

G.lazy_ft = function(name, ft, init)
    vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = ft,
        once = true,
        callback = function()
            vim.cmd.packadd(name)
            init()
        end,
    })
end

LAZY = {}
LOADED = {}

G.lazy_load = function(name, settings, package_name)
    LOADED[name] = false
    LAZY[name] = function()
        local pname = package_name or name
        vim.cmd.packadd(pname)
        if not LOADED[name] then
            LOADED[name] = true
            require(name).setup(settings)
        end
    end
end

G.lazy = function(name, action, args)
    return function()
        if LAZY[name] then LAZY[name]() end
        require(name)[action](args or {})
    end
end

G.inplace = function(f)
    local pos = vim.api.nvim_win_get_cursor(0)
    local temp = f()
    vim.api.nvim_win_set_cursor(0, pos)
    return temp
end

G.makeset = function(arr)
    local temp = {}
    for _, v in ipairs(arr) do
        temp[v] = true
    end
    return temp
end
