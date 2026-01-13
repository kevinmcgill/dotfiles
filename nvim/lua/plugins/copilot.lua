-- Description: Copilot plugin configuration

return {
  'github/copilot.vim',
  init = function()
    local cur = vim.env.NODE_OPTIONS or ''
    if not cur:match('%-%-experimental%-sqlite') then
      vim.env.NODE_OPTIONS = (cur ~= '' and (cur .. ' ') or '') .. '--experimental-sqlite'
    end
  end,
}
