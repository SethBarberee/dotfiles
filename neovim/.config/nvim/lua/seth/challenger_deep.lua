-- NeoVim Color File
-- Name:        challenger_deeper
-- Version:     1.0
-- Maintainer:  https://github.com/SethBarberee
-- Based On:    challenger_deep (https://www.github.com/challenger-deep-theme/vim) and zephyr (https://www.github.com/glepnir/zephyr-nvim)
--
local challenger_deeper = {

    -- Colors
    black         = '#212121',
    medium_gray   = '#767676',
    white         = '#F3F3F3',
    actual_white  = '#FFFFFF',
    light_black   = '#424242',
    lighter_black = '#545454',

    -- lighter shadows and darker grays
    subtle_black = '#303030',
    light_gray   = '#B2B2B2',
    lighter_gray = '#C6C6C6',

    bg      = '#1E1C31',
    asphalt = '#1E1C31',

    asphalt_subtle = '#100E23',
    bg_subtle      = '#100E23',

    dark_asphalt = '#565575',
    bg_dark      = '#565575',
    visual       = '#565575',

    red      = '#ff8080',
    dark_red = '#ff5458',

    green      = '#95ffa4',
    dark_green = '#62d196',

    yellow      = '#ffe9aa',
    dark_yellow = '#ffb378',

    blue      = '#91ddff',
    dark_blue = '#65b2ff',

    purple      = '#c991e1',
    dark_purple = '#906cff',

    cyan      = '#aaffe4',
    dark_cyan = '#63f2f1',

    clouds = '#cbe3e7',
    norm   = '#cbe3e7',

    dark_clouds = '#a6b3cc',
    norm_subtle = '#a6b3cc',

    fg = '#cbe3e7',

    none = "NONE",
}

function challenger_deeper.terminal_color()
    vim.g.terminal_color_0 = challenger_deeper.bg_dark
    vim.g.terminal_color_1 = challenger_deeper.red
    vim.g.terminal_color_2 = challenger_deeper.green
    vim.g.terminal_color_3 = challenger_deeper.yellow
    vim.g.terminal_color_4 = challenger_deeper.blue
    vim.g.terminal_color_5 = challenger_deeper.purple
    vim.g.terminal_color_6 = challenger_deeper.cyan
    vim.g.terminal_color_7 = challenger_deeper.clouds
    vim.g.terminal_color_8 = challenger_deeper.bg_subtle
    vim.g.terminal_color_9 = challenger_deeper.dark_red
    vim.g.terminal_color_10 = challenger_deeper.dark_green
    vim.g.terminal_color_11 = challenger_deeper.dark_yellow
    vim.g.terminal_color_12 = challenger_deeper.dark_blue
    vim.g.terminal_color_13 = challenger_deeper.dark_purple
    vim.g.terminal_color_14 = challenger_deeper.dark_cyan
    vim.g.terminal_color_15 = challenger_deeper.dark_clouds
end

local syntax = {
    Normal = { fg = challenger_deeper.fg, bg = challenger_deeper.bg },
    Cursor = { fg = challenger_deeper.bg_dark, bg = challenger_deeper.blue },
    Comment = { fg = challenger_deeper.medium_gray, italic = true },
    Constant = { fg = challenger_deeper.yellow },
    String = { link = 'Constant' },
    Character = { link = 'Constant' },
    Number = { fg = challenger_deeper.dark_yellow },
    Boolean = { fg = challenger_deeper.dark_yellow },
    Float = { fg = challenger_deeper.dark_yellow },
    Identifier = { fg = challenger_deeper.purple },
    Function = { fg = challenger_deeper.purple },
    Label = { fg = challenger_deeper.dark_blue },
    Operator = { fg = challenger_deeper.dark_cyan },
    Repeat = { fg = challenger_deeper.dark_cyan },
    PreProc = { fg = challenger_deeper.green },
    Include = { link = 'PreProc' },
    Define = { link = 'PrePrec' },
    Macro = { link = 'PreProc' },
    PreCondit = { link = 'PreProc' },
    Keyword = { fg = challenger_deeper.red },
    Statement = { fg = challenger_deeper.red },
    Conditional = { fg = challenger_deeper.red },
    Exception = { fg = challenger_deeper.red },
    Type = { fg = challenger_deeper.blue },
    StorageClass = { fg = challenger_deeper.blue },
    Structure = { fg = challenger_deeper.blue },
    Typedef = { fg = challenger_deeper.blue },
    Special = { fg = challenger_deeper.cyan },
    SpecialChar = { fg = challenger_deeper.cyan },
    Tag = { fg = challenger_deeper.cyan },
    Delimiter = { fg = challenger_deeper.cyan },
    SpecialComment = { fg = challenger_deeper.cyan },
    Debug = { fg = challenger_deeper.cyan },
    Ignore = { fg = challenger_deeper.dark_red, bg = challenger_deeper.bg_subtle, bold = true },
    Underlined = { fg = challenger_deeper.norm, underline = true },
    Error = { fg = challenger_deeper.dark_red, bg = challenger_deeper.bg_subtle, bold = true },
    Todo = { fg = challenger_deeper.dark_yellow, bg = challenger_deeper.bg_subtle, bold = true },
    SpecialKey = { fg = challenger_deeper.blue },
    NonText = { fg = challenger_deeper.bg_dark },
    Directory = { fg = challenger_deeper.purple },
    ErrorMsg = { fg = challenger_deeper.dark_red },
    IncSearch = { fg = challenger_deeper.clouds, bg = challenger_deeper.red },
    Search = { bg = challenger_deeper.bg_dark },
    MoreMsg = { fg = challenger_deeper.medium_gray, bold = true },
    ModeMsg = { fg = challenger_deeper.medium_gray, bold = true },
    LineNr = { fg = challenger_deeper.dark_asphalt, bg = challenger_deeper.bg_subtle },
    CursorLineNr = { fg = challenger_deeper.blue, bg = challenger_deeper.bg_subtle, bold = true },
    Question = { fg = challenger_deeper.red },
    StatusLine = { bg = challenger_deeper.bg_dark },
    Conceal = { fg = challenger_deeper.norm },
    StatusLineNC = { bg = challenger_deeper.bg_dark, fg = challenger_deeper.medium_gray },
    VertSplit = { fg = challenger_deeper.bg_subtle },
    Title = { fg = challenger_deeper.dark_blue },
    Visual = { bg = challenger_deeper.visual },
    WarningMsg = { fg = challenger_deeper.yellow },
    WildMenu = { fg = challenger_deeper.bg_subtle, bg = challenger_deeper.cyan },
    Folded = { link = 'PmenuSbar' },
    FoldColumn = { fg = challenger_deeper.yellow },
    Pmenu = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_subtle },
    PmenuSel = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_dark },
    PmenuSbar = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_dark },
    PmenuThumb = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_dark },
    TabLine = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_dark },
    TabLineSel = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_subtle, bold = true },
    TabLineFill = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_dark },
    CursorColumn = { bg = challenger_deeper.bg_subtle },
    CursorLine = { bg = challenger_deeper.bg_subtle },
    ColorColumn = { bg = challenger_deeper.bg_subtle },
    MatchParen = { bg = challenger_deeper.bg_subtle, fg = challenger_deeper.purple, bold = true },
    qfLineNr = { fg = challenger_deeper.medium_gray },
    SpellBad = { fg = challenger_deeper.dark_red, sp = challenger_deeper.dark_red,
        underline = true },
    SpellCap = { fg = challenger_deeper.green, sp = challenger_deeper.green, underline = true },
    SpellRare = { fg = challenger_deeper.red, sp = challenger_deeper.red, underline = true },
    SpellLocal = { fg = challenger_deeper.dark_green, sp = challenger_deeper.dark_green,
        underline = true },

    -- NVIM floating window theming
    NormalFloat = { fg = challenger_deeper.fg, bg = challenger_deeper.bg },
    FloatBorder = { fg = challenger_deeper.white, bg = challenger_deeper.bg },

}

local plugin_syntax = {
    TreesitterContext = { bg = challenger_deeper.bg_dark },

    DiffAdd = { bg = challenger_deeper.green, fg = challenger_deeper.black },
    DiffAdded = { bg = challenger_deeper.green, fg = challenger_deeper.black },
    DiffDelete = { bg = challenger_deeper.red, fg = challenger_deeper.black },
    DiffRemoved = { bg = challenger_deeper.red, fg = challenger_deeper.black },
    DiffChange = { bg = challenger_deeper.dark_yellow, fg = challenger_deeper.black },
    DiffChanged = { bg = challenger_deeper.dark_yellow, fg = challenger_deeper.black },
    DiffText = { bg = challenger_deeper.yellow, fg = challenger_deeper.black },


    GitSignsAdd = { fg = challenger_deeper.green },
    GitSignsAdded = { fg = challenger_deeper.green },
    GitSignsDelete = { fg = challenger_deeper.red },
    GitSignsRemoved = { fg = challenger_deeper.red },
    GitSignsChange = { fg = challenger_deeper.dark_yellow },
    GitSignsChanged = { fg = challenger_deeper.dark_yellow },


    SignColumn = { fg = challenger_deeper.green },

    GitGutterAdd = { fg = challenger_deeper.green, bg = challenger_deeper.bg_subtle },
    GitGutterDelete = { fg = challenger_deeper.red, bg = challenger_deeper.bg_subtle },
    GitGutterChange = { fg = challenger_deeper.yellow, bg = challenger_deeper.bg_subtle },
    GitGutterChangeDelete = { fg = challenger_deeper.red, bg = challenger_deeper.bg_subtle },


    NeoTreeGitAdded = { fg = challenger_deeper.green },
    NeoTreeGitModified = { fg = challenger_deeper.yellow },
    NeoTreeGitDeleted = { fg = challenger_deeper.red },
    NeoTreeDotfile = { fg = challenger_deeper.white },

    --VistaBracket = {fg=challenger_deeper.grey},
    --VistaChildrenNr = {fg=challenger_deeper.yellow},
    --VistaKind = {fg=challenger_deeper.purpl},
    --VistaScope = {fg=challenger_deeper.red},
    --VistaScopeKind = {fg=challenger_deeper.blue},
    --VistaTag = {fg=challenger_deeper.magenta,gui='bold'},
    --VistaPrefix = {fg=challenger_deeper.grey},
    --VistaColon = {fg=challenger_deeper.magenta},
    --VistaIcon = {fg=challenger_deeper.yellow},
    --VistaLineNr = {fg=challenger_deeper.fg},



    --LspDiagnosticsSignError = {fg=challenger_deeper.red},
    --LspDiagnosticsSignWarning = {fg=challenger_deeper.yellow},
    --LspDiagnosticsSignInformation = {fg=challenger_deeper.blue},
    --LspDiagnosticsSignHint = {fg=challenger_deeper.cyan},
    --LspDiagnosticsVirtualTextError = {fg=challenger_deeper.red},
    --LspDiagnosticsVirtualTextWarning= {fg=challenger_deeper.yellow},
    --LspDiagnosticsVirtualTextInformation = {fg=challenger_deeper.blue},
    --LspDiagnosticsVirtualTextHint = {fg=challenger_deeper.cyan},
    --LspDiagnosticsUnderlineError = {gui="undercurl",sp=challenger_deeper.red},
    --LspDiagnosticsUnderlineWarning = {gui="undercurl",sp=challenger_deeper.yellow},
    --LspDiagnosticsUnderlineInformation = {gui="undercurl",sp=challenger_deeper.blue},
    --LspDiagnosticsUnderlineHint = {gui="undercurl",sp=challenger_deeper.cyan},

    TelescopeBorder = { link = 'LspInfoBorder' },
    --TelescopePromptBorder = {fg=challenger_deeper.blue},
    --TelescopeMatching = {fg=challenger_deeper.teal},
    --TelescopeSelection = {fg=challenger_deeper.yellow, bg=challenger_deeper.bg_highlight,gui= 'bold'},
    --TelescopeSelectionCaret = {fg=challenger_deeper.yellow},
    --TelescopeMultiSelection = {fg=challenger_deeper.teal},

    -- nvim-cmp
    -- TODO: Maybe use the TS Highlight groups?
    -- Currently, doing a VSCode style
    CmpItemAbbrMatchFuzzy = { bg = challenger_deeper.bg_subtle, fg = challenger_deeper.dark_cyan },
    CmpItemAbbrMatch = { bg = challenger_deeper.bg_subtle, fg = challenger_deeper.dark_cyan },

    CmpItemKindFunction = { fg = challenger_deeper.purple },
    CmpItemKindMethod = { link = 'CmpItemKindFunction' },

    CmpItemKindModule = { fg = challenger_deeper.yellow },
    CmpItemKindClass = { link = 'CmpItemKindModule' },
    CmpItemKindProperty = { link = 'CmpItemKindModule' },
    CmpItemKindField = { link = 'CmpItemKindModule' },
    CmpItemKindStruct = { link = 'CmpItemKindModule' },
    CmpItemKindInterface = { link = 'CmpItemKindModule' },
    CmpItemKindConstructor = { link = 'CmpItemKindModule' },
    CmpItemKindNamespace = { link = 'CmpItemKindModule' },
    CmpItemKindFile = { link = 'CmpItemKindModule' },

    CmpItemKindValue = { fg = challenger_deeper.dark_cyan },

    CmpItemKindVariable = { fg = challenger_deeper.blue },
    CmpItemKindTypeParameter = { link = 'CmpItemKindVariable' },

    ---- nvim-scrollbar
    --ScrollbarWarn = { fg = challenger_deeper.dark_yellow },
    --ScrollbarWarnHandle = { bg = challenger_deeper.bg_dark, fg = challenger_deeper.dark_yellow },
    --ScrollbarError = { fg = challenger_deeper.red },
    --ScrollbarErrorHandle = { bg = challenger_deeper.bg_dark, fg = challenger_deeper.red },
    --ScrollbarHint = { fg = challenger_deeper.green },
    --ScrollbarHintHandle = { bg = challenger_deeper.bg_dark, fg = challenger_deeper.green },
    --ScrollbarHandle = { bg = challenger_deeper.bg_dark },

    -- nvim-navic
    NavicIconsFile = { link = 'CmpItemKindFile' },
    NavicIconsModule = { link = 'CmpItemKindModule' },
    NavicIconsNamespace = { link = 'CmpItemKindNamespace' },
    NavicIconsPackage = { bg = challenger_deeper.bg, fg = challenger_deeper.yellow },
    NavicIconsClass = { link = 'CmpItemKindClass' },
    NavicIconsMethod = { link = 'CmpItemKindMethod' },
    NavicIconsProperty = { link = 'CmpItemKindProperty' },
    NavicIconsField = { link = 'CmpItemKindField' },
    NavicIconsConstructor = { link = 'CmpItemKindConstructor' },
    NavicIconsEnum = { link = 'CmpItemKindEnum' },
    NavicIconsEnumMember = { link = 'CmpItemKindEnumMember' },
    NavicIconsInterface = { link = 'CmpItemKindInterface' },
    NavicIconsFunction = { link = 'CmpItemKindFunction' },
    NavicIconsVariable = { link = 'CmpItemKindVariable' },
    NavicIconsConstant = { link = 'CmpItemKindConstant' },
    NavicIconsString = { link = 'CmpItemKindValue' },
    NavicIconsNumber = { link = 'CmpItemKindValue' },
    NavicIconsBoolean = { link = 'CmpItemKindValue' },
    NavicIconsArray = { link = 'CmpItemKindValue' },
    NavicIconsObject = { link = 'CmpItemKindValue' },
    NavicIconsKey = { bg = challenger_deeper.bg, fg = challenger_deeper.yellow },
    NavicIconsNull = { link = 'CmpItemKindValue' },
    NavicIconsStruct = { link = 'CmpItemKindStruct' },
    NavicIconsEvent = { link = 'CmpItemKindEvent' },
    NavicIconsOperator = { link = 'CmpItemKindValue' },
    NavicIconsTypeParameter = { link = 'CmpItemKindTypeParameter' },
    NavicText = { link = 'Normal' },
    NavicSeparator = { bg = challenger_deeper.bg, fg = challenger_deeper.white },

    -- Link up Null-LS windows to be like LspInfo
    NullLsInfoTitle = { link = 'LspInfoTitle' },
    NullLsInfoBorder = { link = 'LspInfoBorder' },
    NullLsInfoSources = { link = 'Type' },
}

local async_load_plugin

local set_hl = function(tbl)
    for group, conf in pairs(tbl) do
        vim.api.nvim_set_hl(0, group, conf)
    end
end

async_load_plugin = vim.loop.new_async(vim.schedule_wrap(function()
    challenger_deeper.terminal_color()
    set_hl(plugin_syntax)
    async_load_plugin:close()
end))

function challenger_deeper.colorscheme()
    vim.api.nvim_command('hi clear')
    if vim.fn.exists('syntax_on') then
        vim.api.nvim_command('syntax reset')
    end
    vim.o.background = 'dark'
    vim.o.termguicolors = true
    vim.g.colors_name = 'challenger_deep'
    set_hl(syntax)
    async_load_plugin:send()
end

challenger_deeper.colorscheme()

return challenger_deeper
