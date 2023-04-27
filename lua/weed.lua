local ts_utils = require("nvim-treesitter.ts_utils")
local M = {}

local function get_main_node()
    local node = ts_utils.get_node_at_cursor()
    if (node == nil) then
        error("No treesitter parser found")
    end

    local root = ts_utils.get_root_for_node(node)
    local start_row = node:start()
    local parent = node:parent()

    while (parent ~= nil and parent ~= root and parent:start() == start_row) do
        node = parent
        parent = node:parent()
    end
    return node
end

local function highlight_node()
    local node = get_main_node()
    local bufnr = vim.api.nvim_get_current_buf()
    ts_utils.update_selection(bufnr, node)
end

local function on_error(error)
    print("Error: ", error)
end

local function select()
    -- highlight_node()
    local status = xpcall(highlight_node, on_error)
end

M.select = select

return M
