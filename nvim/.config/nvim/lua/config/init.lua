require 'config.options'

local plugins_ready = require('config.packages').setup()
if not plugins_ready then
  return
end

require 'config.commands'
require 'config.keymaps'
require 'config.autocmds'
require 'config.format'
require 'config.lsp'
