vim.api.nvim_create_user_command("Weed", function(opts)
    require("weed").select(unpack(opts.fargs))
end, {})

