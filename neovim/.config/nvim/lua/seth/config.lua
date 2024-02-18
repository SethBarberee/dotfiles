-- for my more complicated stuff, this is to easily disable the whole chunk with
-- a nice little config table

return {
    dap = true,
    treesitter = true,
    treesitter_extras = true, -- the extra parsers (asm/pory)
    lsp = true,
    ufo = true,               -- fancy folds
    whichkey = true,
}
