return {
  {
    'stevearc/overseer.nvim',
    event = 'VeryLazy',
    config = function()
      require('overseer').setup()
    end,
  },
}
