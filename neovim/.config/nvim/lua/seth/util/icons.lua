-- Used by lspkind and nvim-navic
-- TODO: would be nice to pass this through to vista somehow..

local symbol_table = {
    Text = "󰉿",
    Method = ' ',
    Function = '󰊕 ',
    Constructor = " ",
    Field = "󰜢 ",
    --Field = ' ',
    --Variable = "󰀫 ",
    Variable = ' ',
    Class = "󰠱 ",
    Interface = " ",
    Module = " ",
    Namespace = " ",
    Package = ' ',
    Property = "󰜢 ",
    --Property = ' ',
    Unit = "󰑭 ",
    Value = "󰎠 ",
    Enum = " ",
    Keyword = "󰌋 ",
    Snippet = " ",
    Color = "󰏘 ",
    File = "󰈙 ",
    --File = ' ',
    Reference = "󰈇 ",
    Folder = "󰉋 ",
    EnumMember = " ",
    --Constant = "󰏿 ",
    Constant = ' ',
    Struct = "󰙅 ",
    --Struct = ' ',
    Event = " ",
    --Event = ' ',
    Operator = "󰆕 ",
    --Operator = ' ',
    String = ' ',
    Number = ' ',
    Boolean = ' ',
    Array = ' ',
    Object = ' ',
    Key = ' ',
    Null = ' ',
    --TypeParameter = "",
    TypeParameter = '  ',

    -- For diags
    signs = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " "
    }
}
return symbol_table
