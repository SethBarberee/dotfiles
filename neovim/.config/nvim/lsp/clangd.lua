return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "-j=8",
        "--malloc-trim",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--limit-results=0",
        "--enable-config",
    },

    filetypes = {'c', 'cpp'},
    root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac' },
    init_options = { clangdFileStatus = true, },
}

