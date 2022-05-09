require('nvim-treesitter.configs').setup {
  ensure_installed = "c", "cpp", "python", "vim", "comment", "query",
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = "vim",
    disable = function(lang, bufnr) -- Disable in large C buffers (found that 2000 lines is a good limit)
        return lang == "c" and vim.api.nvim_buf_line_count(bufnr) > 5000
    end,
  },
  indent = {
    enable = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
