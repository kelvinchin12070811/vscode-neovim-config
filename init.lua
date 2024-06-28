require("config.lazy")

vim.cmd('noremap yy "*yy')
vim.cmd('noremap y "*y')
vim.cmd('noremap p "*p')
vim.cmd('noremap P "*P')

vim.api.nvim_set_keymap("n", "<leader>sl", "i<CR><Esc>", { noremap = true, desc = "Split line infront of cursor" })
vim.api.nvim_set_keymap("n", "<leader>sL", "a<CR><Esc>", { noremap = true, desc = "Split lien behind of cursor" })
vim.api.nvim_set_keymap("n", "<leader>tn", "<cmd>Settab 2<CR>", { noremap = true, desc = "Narrow tab size (2 tab)"})
vim.api.nvim_set_keymap("n", "<leader>tw", "<cmd>Settab 4<CR>", { noremap = true, desc = "Wide tab size (4 tab)"})

for _, mode_char in pairs({ "n", "v" }) do
  for _, op_char in pairs({ "c", "d", "x" }) do
    if op_char == "x" and mode_char == "v" then
      goto continue
    end

    local desc = ""

    if op_char == "c" then
      desc = "Change op"
    elseif op_char == "d" then
      desc = "Delete op"
    elseif op_char == "x" then
      desc = "Delete word"
    end

    vim.api.nvim_set_keymap(mode_char, op_char, '"_' .. op_char, { noremap = true, silent = true, desc = desc })
    vim.api.nvim_set_keymap(
      mode_char,
      "<leader>" .. op_char,
      '"+' .. op_char,
      { noremap = true, silent = true, desc = desc .. ", but copy to clipboard too" }
    )

    ::continue::
  end
end

function SetTab(value)
    vim.bo.shiftwidth = tonumber(value)
    vim.bo.tabstop = tonumber(value)
  end

  function ShowTab()
    print("shiftwidth=" .. vim.bo.shiftwidth .. " tabstop=" .. vim.bo.tabstop)
  end

  -- Register custom commands
  vim.cmd "command! -nargs=1 Settab lua SetTab(<f-args>)"
  vim.cmd "command! Showtab lua ShowTab()"
