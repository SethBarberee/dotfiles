require("indent_blankline").setup {
    use_treesitter = true,
    --use_treesitter_scope = true,
    show_current_context = true,
    show_current_context_start = true,
    viewport_buffer = 30, -- increase the amount of context lines highlighted (default: 10)
    context_patterns = { -- Mainly default except adding switch
        "class",
        "^func",
        "method",
        "^if",
        "while",
        "for",
        "with",
        "try",
        "except",
        "arguments",
        "argument_list",
        "object",
        "dictionary",
        "element",
        "table",
        "tuple",
        "do_block",
        "^switch",
        "^case",
        "^struct",
    },
}

--vim.g.indent_blankline_use_treesitter = true
