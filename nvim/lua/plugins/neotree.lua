return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      bind_to_cwd = true,
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["H"] = "none",
      },
    },
    source_selector = {
      winbar = true,
      content_layout = "center",
      tab_labels = {
        filesystem = " File",
        buffers = "➜ Buffs",
        git_status = " Git",
        diagnostics = "",
      },
    },
  },
}
