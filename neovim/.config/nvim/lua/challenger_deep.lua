-- NeoVim Color File
-- Name:        challenger_deeper
-- Version:     1.0
-- Maintainer:  https://github.com/SethBarberee
-- Based On:    challenger_deep (https://www.github.com/challenger-deep-theme/vim)
--
-- This is mainly a port of challenger_deep to Lua to test the new APIs of Neovim
-- Still waiting for highlight linking to clean up some of this

local challenger_deeper = {

    -- Colors
    black         = { gui = '#212121', cterm = '0' };
    medium_gray   = { gui = '#767676', cterm = '243' };
    white         = { gui = '#F3F3F3', cterm = '15' };
    actual_white  = { gui = '#FFFFFF', cterm = '231' };
    light_black   = { gui = '#424242', cterm = '8' };
    lighter_black = { gui = '#545454', cterm = '240' };

    -- lighter shadows and darker grays
    subtle_black = { gui = '#303030', cterm = '236' };
    light_gray   = { gui = '#B2B2B2', cterm = '249' };
    lighter_gray = { gui = '#C6C6C6', cterm = '251' };

    bg      = { gui = '#1E1C31', cterm = '233' };
    asphalt = { gui = '#1E1C31', cterm = '233' };

    asphalt_subtle = { gui = '#100E23', cterm = '232' };
    bg_subtle      = { gui = '#100E23', cterm = '232' };

    dark_asphalt = { gui = '#565575', cterm = '236' };
    bg_dark      = { gui = '#565575', cterm = '236' };
    visual       = { gui = '#565575', cterm = '236' };

    red      = { gui = '#ff8080', cterm = '204' };
    dark_red = { gui = '#ff5458', cterm = '203' };

    green      = { gui = '#95ffa4', cterm = '120' };
    dark_green = { gui = '#62d196', cterm = '119' };

    yellow      = { gui = '#ffe9aa', cterm = '228' };
    dark_yellow = { gui = '#ffb378', cterm = '215' };

    blue      = { gui = '#91ddff', cterm = '159' };
    dark_blue = { gui = '#65b2ff', cterm = '75' };

    purple      = { gui = '#c991e1', cterm = '141' };
    dark_purple = { gui = '#906cff', cterm = '135' };

    cyan      = { gui = '#aaffe4', cterm = '122' };
    dark_cyan = { gui = '#63f2f1', cterm = '121' };

    clouds = { gui = '#cbe3e7', cterm = '253' };
    norm   = { gui = '#cbe3e7', cterm = '253' };

    dark_clouds = { gui = '#a6b3cc', cterm = '252' };
    norm_subtle = { gui = '#a6b3cc', cterm = '252' };

    fg = { gui = '#cbe3e7', cterm = '253' };

    none = 'NONE';
}

function challenger_deeper.terminal_color()
    vim.g.terminal_color_0 = challenger_deeper.bg_dark.gui
    vim.g.terminal_color_1 = challenger_deeper.red.gui
    vim.g.terminal_color_2 = challenger_deeper.green.gui
    vim.g.terminal_color_3 = challenger_deeper.yellow.gui
    vim.g.terminal_color_4 = challenger_deeper.blue.gui
    vim.g.terminal_color_5 = challenger_deeper.purple.gui
    vim.g.terminal_color_6 = challenger_deeper.cyan.gui
    vim.g.terminal_color_7 = challenger_deeper.clouds.gui
    vim.g.terminal_color_8 = challenger_deeper.bg_subtle.gui
    vim.g.terminal_color_9 = challenger_deeper.dark_red.gui
    vim.g.terminal_color_10 = challenger_deeper.dark_green.gui
    vim.g.terminal_color_11 = challenger_deeper.dark_yellow.gui
    vim.g.terminal_color_12 = challenger_deeper.dark_blue.gui
    vim.g.terminal_color_13 = challenger_deeper.dark_purple.gui
    vim.g.terminal_color_14 = challenger_deeper.dark_cyan.gui
    vim.g.terminal_color_15 = challenger_deeper.dark_clouds.gui
end

function challenger_deeper.highlight(group, color)

    local ctermfg = 'ctermfg=NONE'
    local ctermbg = 'ctermbg=NONE'
    local bg, fg, sp, gui, cterm

    if color.fg ~= nil then
        fg = color.fg.gui and 'guifg=' .. color.fg.gui
        ctermfg = color.fg.cterm and 'ctermfg=' .. color.fg.cterm
    else
        fg = 'guifg=NONE'
        ctermfg = 'ctermfg=NONE'
    end

    if color.bg ~= nil then
        bg = color.bg.gui and 'guibg=' .. color.bg.gui
        ctermbg = color.bg.cterm and 'ctermbg=' .. color.bg.cterm
    else
        bg = 'guibg=NONE'
        ctermbg = 'ctermbg=NONE'
    end

    if color.sp ~= nil then
        sp = color.sp.gui and 'guisp=' .. color.sp.gui
    else
        sp = 'guisp=NONE'
    end

    if color.gui ~= nil then
        gui = color.gui and 'gui=' .. color.gui
    else
        gui = 'gui=NONE'
    end

    if color.cterm ~= nil then
        cterm = color.cterm and 'cterm=' .. color.cterm
    else
        cterm = 'cterm=NONE'
    end

    vim.api.nvim_command('highlight ' .. group .. ' ' .. gui .. ' ' .. fg ..
        ' ' .. bg .. ' ' .. cterm .. ' ' .. ctermfg .. ' ' .. ctermbg .. ' ' .. sp)

end

function challenger_deeper.load_syntax()
    local syntax = {
        Normal = { fg = challenger_deeper.fg, bg = challenger_deeper.bg };
        Cursor = { fg = challenger_deeper.bg_dark, bg = challenger_deeper.blue };
        Comment = { fg = challenger_deeper.medium_gray, gui = 'italic', cterm = 'italic' };
        Constant = { fg = challenger_deeper.yellow };
        String = { fg = challenger_deeper.yellow };
        Character = { fg = challenger_deeper.yellow };
        Number = { fg = challenger_deeper.dark_yellow };
        Boolean = { fg = challenger_deeper.dark_yellow };
        Float = { fg = challenger_deeper.dark_yellow };
        Identifier = { fg = challenger_deeper.purple };
        Function = { fg = challenger_deeper.purple };
        Label = { fg = challenger_deeper.dark_blue };
        Operator = { fg = challenger_deeper.dark_cyan };
        Repeat = { fg = challenger_deeper.dark_cyan };
        PreProc = { fg = challenger_deeper.green };
        Include = { fg = challenger_deeper.green };
        Define = { fg = challenger_deeper.green };
        Macro = { fg = challenger_deeper.green };
        PreCondit = { fg = challenger_deeper.green };
        Keyword = { fg = challenger_deeper.red };
        Statement = { fg = challenger_deeper.red };
        Conditional = { fg = challenger_deeper.red };
        Exception = { fg = challenger_deeper.red };
        Type = { fg = challenger_deeper.blue };
        StorageClass = { fg = challenger_deeper.blue };
        Structure = { fg = challenger_deeper.blue };
        Typedef = { fg = challenger_deeper.blue };
        Special = { fg = challenger_deeper.cyan };
        SpecialChar = { fg = challenger_deeper.cyan };
        Tag = { fg = challenger_deeper.cyan };
        Delimiter = { fg = challenger_deeper.cyan };
        SpecialComment = { fg = challenger_deeper.cyan };
        Debug = { fg = challenger_deeper.cyan };
        Ignore = { fg = challenger_deeper.dark_red, bg = challenger_deeper.bg_subtle, gui = 'bold' };
        Underlined = { fg = challenger_deeper.norm, gui = 'underline', cterm = 'underline' };
        Error = { fg = challenger_deeper.dark_red, bg = challenger_deeper.bg_subtle, gui = 'bold', cterm = 'bold' };
        Todo = { fg = challenger_deeper.dark_yellow, bg = challenger_deeper.bg_subtle, gui = 'bold', cterm = 'bold' };
        SpecialKey = { fg = challenger_deeper.blue };
        NonText = { fg = challenger_deeper.bg_dark };
        Directory = { fg = challenger_deeper.purple };
        ErrorMsg = { fg = challenger_deeper.dark_red };
        IncSearch = { fg = challenger_deeper.clouds, bg = challenger_deeper.red };
        Search = { bg = challenger_deeper.bg_dark };
        MoreMsg = { fg = challenger_deeper.medium_gray, gui = 'bold', cterm = 'bold' };
        ModeMsg = { fg = challenger_deeper.medium_gray, gui = 'bold', cterm = 'bold' };
        LineNr = { fg = challenger_deeper.dark_asphalt, bg = challenger_deeper.bg_subtle };
        CursorLineNr = { fg = challenger_deeper.blue, bg = challenger_deeper.bg_subtle, gui = 'bold' };
        Question = { fg = challenger_deeper.red };
        StatusLine = { bg = challenger_deeper.bg_dark };
        Conceal = { fg = challenger_deeper.norm };
        StatusLineNC = { bg = challenger_deeper.bg_dark, fg = challenger_deeper.medium_gray };
        VertSplit = { fg = challenger_deeper.bg_subtle };
        Title = { fg = challenger_deeper.dark_blue };
        Visual = { bg = challenger_deeper.visual };
        WarningMsg = { fg = challenger_deeper.yellow };
        WildMenu = { fg = challenger_deeper.bg_subtle, bg = challenger_deeper.cyan };
        Folded = { fg = challenger_deeper.bg_subtle, bg = challenger_deeper.purple };
        FoldColumn = { fg = challenger_deeper.yellow };
        Pmenu = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_subtle };
        PmenuSel = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_dark };
        PmenuSbar = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_dark };
        PmenuThumb = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_dark };
        TabLine = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_dark };
        TabLineSel = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_subtle, gui = 'bold', cterm = 'bold' };
        TabLineFill = { fg = challenger_deeper.norm, bg = challenger_deeper.bg_dark };
        CursorColumn = { bg = challenger_deeper.bg_subtle };
        CursorLine = { bg = challenger_deeper.bg_subtle };
        ColorColumn = { bg = challenger_deeper.bg_subtle };
        MatchParen = { bg = challenger_deeper.bg_subtle, fg = challenger_deeper.purple, gui = 'bold', cterm = 'bold' };
        qfLineNr = { fg = challenger_deeper.medium_gray };
        SpellBad = { fg = challenger_deeper.dark_red, sp = challenger_deeper.dark_red, cterm = 'underline',
            gui = 'underline' };
        SpellCap = { fg = challenger_deeper.green, sp = challenger_deeper.green, cterm = 'underline', gui = 'underline' };
        SpellRare = { fg = challenger_deeper.red, sp = challenger_deeper.red, cterm = 'underline', gui = 'underline' };
        SpellLocal = { fg = challenger_deeper.dark_green, sp = challenger_deeper.dark_gren, cterm = 'underline',
            gui = 'underline' };
    }
    return syntax
end

function challenger_deeper.load_plugin_syntax()
    local plugin_syntax = {
        TreesitterContext = { bg = challenger_deeper.bg_dark };
        --TreesitterContextLineNumber = {bg=challenger_deeper.bg_dark};

        --TSFunction = {fg=challenger_deeper.cyan};
        --TSMethod = {fg=challenger_deeper.cyan};
        --TSKeywordFunction = {fg=challenger_deeper.red};
        --TSProperty = {fg=challenger_deeper.yellow};
        --TSType = {fg=challenger_deeper.teal};
        --TSVariable = {fg=challenger_deeper.blue};
        --TSPunctBracket = {fg=challenger_deeper.bracket};

        --vimCommentTitle = {fg=challenger_deeper.grey,gui='bold'};
        --vimLet = {fg=challenger_deeper.orange};
        --vimVar = {fg=challenger_deeper.cyan};
        --vimFunction = {fg=challenger_deeper.redwine};
        --vimIsCommand = {fg=challenger_deeper.fg};
        --vimCommand = {fg=challenger_deeper.blue};
        --vimNotFunc = {fg=challenger_deeper.violet,gui='bold'};
        --vimUserFunc = {fg=challenger_deeper.yellow,gui='bold'};
        --vimFuncName= {fg=challenger_deeper.yellow,gui='bold'};

        --diffAdded = {fg = challenger_deeper.dark_green};
        --diffRemoved = {fg =challenger_deeper.red};
        --diffChanged = {fg = challenger_deeper.blue};
        --diffOldFile = {fg = challenger_deeper.yellow};
        --diffNewFile = {fg = challenger_deeper.orange};
        --diffFile    = {fg = challenger_deeper.aqua};
        --diffLine    = {fg = challenger_deeper.grey};
        --diffIndexLine = {fg = challenger_deeper.violet};

        DiffAdd = { fg = challenger_deeper.green };
        DiffDelete = { fg = challenger_deeper.red };
        DiffChange = { fg = challenger_deeper.dark_yellow };
        DiffText = { fg = challenger_deeper.dark_blue };
        SignColumn = { fg = challenger_deeper.green };

        --gitcommitSummary = {fg = challenger_deeper.red};
        --gitcommitUntracked = {fg = challenger_deeper.grey};
        --gitcommitDiscarded = {fg = challenger_deeper.grey};
        --gitcommitSelected = { fg=challenger_deeper.grey};
        --gitcommitUnmerged = { fg=challenger_deeper.grey};
        --gitcommitOnBranch = { fg=challenger_deeper.grey};
        --gitcommitArrow  = {fg = challenger_deeper.grey};
        --gitcommitFile  = {fg = challenger_deeper.dark_green};

        --VistaBracket = {fg=challenger_deeper.grey};
        --VistaChildrenNr = {fg=challenger_deeper.orange};
        --VistaKind = {fg=challenger_deeper.purpl};
        --VistaScope = {fg=challenger_deeper.red};
        --VistaScopeKind = {fg=challenger_deeper.blue};
        --VistaTag = {fg=challenger_deeper.magenta,gui='bold'};
        --VistaPrefix = {fg=challenger_deeper.grey};
        --VistaColon = {fg=challenger_deeper.magenta};
        --VistaIcon = {fg=challenger_deeper.yellow};
        --VistaLineNr = {fg=challenger_deeper.fg};

        GitGutterAdd = { fg = challenger_deeper.green, bg = challenger_deeper.bg_subtle };
        GitGutterDelete = { fg = challenger_deeper.red, bg = challenger_deeper.bg_subtle };
        GitGutterChange = { fg = challenger_deeper.yellow, bg = challenger_deeper.bg_subtle };
        GitGutterChangeDelete = { fg = challenger_deeper.red, bg = challenger_deeper.bg_subtle };

        --LspDiagnosticsSignError = {fg=challenger_deeper.red};
        --LspDiagnosticsSignWarning = {fg=challenger_deeper.yellow};
        --LspDiagnosticsSignInformation = {fg=challenger_deeper.blue};
        --LspDiagnosticsSignHint = {fg=challenger_deeper.cyan};
        --LspDiagnosticsVirtualTextError = {fg=challenger_deeper.red};
        --LspDiagnosticsVirtualTextWarning= {fg=challenger_deeper.yellow};
        --LspDiagnosticsVirtualTextInformation = {fg=challenger_deeper.blue};
        --LspDiagnosticsVirtualTextHint = {fg=challenger_deeper.cyan};
        --LspDiagnosticsUnderlineError = {gui="undercurl",sp=challenger_deeper.red};
        --LspDiagnosticsUnderlineWarning = {gui="undercurl",sp=challenger_deeper.yellow};
        --LspDiagnosticsUnderlineInformation = {gui="undercurl",sp=challenger_deeper.blue};
        --LspDiagnosticsUnderlineHint = {gui="undercurl",sp=challenger_deeper.cyan};

        --CursorWord0 = {bg=challenger_deeper.currsor_bg};
        --CursorWord1 = {bg=challenger_deeper.currsor_bg};
        --NvimTreeFolderName = {fg=challenger_deeper.blue};
        --NvimTreeRootFolder = {fg=challenger_deeper.red,gui='bold'};
        --NvimTreeSpecialFile = {fg=challenger_deeper.fg, bg=challenger_deeper.none,stryle='NONE'};
        --TelescopeBorder = {fg=challenger_deeper.teal};
        --TelescopePromptBorder = {fg=challenger_deeper.blue};
        --TelescopeMatching = {fg=challenger_deeper.teal};
        --TelescopeSelection = {fg=challenger_deeper.yellow, bg=challenger_deeper.bg_highlight,gui= 'bold'};
        --TelescopeSelectionCaret = {fg=challenger_deeper.yellow};
        --TelescopeMultiSelection = {fg=challenger_deeper.teal};

        -- nvim-cmp
        CmpItemAbbrMatchFuzzy = { fg = challenger_deeper.dark_cyan };
        CmpItemAbbrMatch = { fg = challenger_deeper.dark_cyan };
    }
    return plugin_syntax
end

local async_load_plugin

async_load_plugin = vim.loop.new_async(vim.schedule_wrap(function()
    challenger_deeper.terminal_color()
    local syntax = challenger_deeper.load_plugin_syntax()
    for group, colors in pairs(syntax) do
        challenger_deeper.highlight(group, colors)
    end
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
    local syntax = challenger_deeper.load_syntax()
    for group, colors in pairs(syntax) do
        challenger_deeper.highlight(group, colors)
    end
    async_load_plugin:send()
end

challenger_deeper.colorscheme()

return challenger_deeper
