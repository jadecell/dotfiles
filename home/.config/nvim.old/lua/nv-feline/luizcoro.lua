local vi_mode_utils = require 'feline.providers.vi_mode'

local colors = {
    fg = '#8FBCBB',
    bg = '#2E3440',
    line_bg = '#434C5E',
    nord_1 = '#3B4252',
    nord_3 = '#4C566A',
    nord_5 = '#E5E9F0',
    nord_6 = '#ECEFF4',
    nord_7 = '#8FBCBB',
    blue1 = '#88C0D0',
    blue2 = '#81A1C1',
    blue3 = '#5E81AC',
    red = '#ec5f67',
    yellow = '#EBCB8B',
    purple = '#B48EAD'
}

local get_diag = function(str)
    local count = vim.lsp.diagnostic.get_count(0, str)
    if (count == 0) then return '' end
    return ' ' .. count .. ' '
end

local mode_alias = {
    n = 'NORMAL',
    no = 'NORMAL',
    i = 'INSERT',
    v = 'VISUAL',
    V = 'V-LINE',
    [''] = 'V-BLOCK',
    c = 'COMMAND',
    cv = 'COMMAND',
    ce = 'COMMAND',
    R = 'REPLACE',
    Rv = 'REPLACE',
    s = 'SELECT',
    S = 'SELECT',
    [''] = 'SELECT',
    t = 'TERMINAL'
}

local vi_mode_component = {
    provider = function() return ' ' .. mode_alias[vim.fn.mode()] .. ' ' end,
    hl = function()
        return {
            name = vi_mode_utils.get_mode_highlight_name(),
            fg = colors.bg,
            bg = vi_mode_utils.get_mode_color(),
            style = 'bold'
        }
    end,
    right_sep = ' '
}

require'feline'.setup {
    default_bg = colors.bg,
    default_fg = colors.fg,
    components = {
        left = {
            active = {
                vi_mode_component, {
                    provider = 'git_branch',
                    icon = ' ',
                    right_sep = '  ',
                    enabled = function()
                        return vim.b.gitsigns_status_dict ~= nil
                    end
                }, {provider = 'file_info'},
                {provider = '', hl = {fg = colors.bg, bg = colors.line_bg}}
            },
            inactive = {
                vi_mode_component, {
                    provider = 'git_branch',
                    icon = ' ',
                    right_sep = '  ',
                    enabled = function()
                        return vim.b.gitsigns_status_dict ~= nil
                    end
                }, {provider = 'file_info'},
                {provider = '', hl = {fg = colors.bg, bg = colors.line_bg}}
            }
        },
        mid = {active = {}, inactive = {}},
        right = {
            active = {
                {
                    provider = function()
                        return get_diag("Error")
                    end,
                    hl = {fg = colors.bg, bg = colors.red, style = 'bold'},
                    left_sep = {
                        str = '',
                        hl = {fg = colors.red, bg = colors.line_bg}
                    },
                    right_sep = {
                        str = '',
                        hl = {fg = colors.yellow, bg = colors.red}
                    }
                }, {
                    provider = function()
                        return get_diag("Warning")
                    end,
                    hl = {fg = colors.bg, bg = colors.yellow, style = 'bold'},
                    right_sep = {
                        str = '',
                        hl = {fg = colors.blue1, bg = colors.yellow}
                    }
                }, {
                    provider = function()
                        return get_diag("Information")
                    end,
                    hl = {fg = colors.bg, bg = colors.blue1, style = 'bold'},
                    right_sep = {
                        str = '',
                        hl = {fg = colors.blue3, bg = colors.blue1}
                    }
                }, {
                    provider = function()
                        return get_diag("Hint")
                    end,
                    hl = {fg = colors.bg, bg = colors.blue3, style = 'bold'},
                    right_sep = {
                        str = '',
                        hl = {fg = colors.bg, bg = colors.blue3}
                    }
                }, {provider = 'file_encoding', left_sep = ' '},
                {provider = 'position', left_sep = ' ', right_sep = ' '}, {
                    provider = 'line_percentage',
                    hl = {fg = colors.bg, bg = colors.blue2, style = 'bold'},
                    left_sep = {
                        str = ' ',
                        hl = {fg = colors.bg, bg = colors.blue2}
                    },
                    right_sep = {
                        str = ' ',
                        hl = {fg = colors.bg, bg = colors.blue2}
                    }
                }
            },
            inactive = {}
        }
    },
    properties = {
        force_inactive = {
            filetypes = {
                'NvimTree', 'packer', 'dap-repl', 'dapui_scopes',
                'dapui_stacks', 'dapui_watches', 'dapui_repl'
            },
            buftypes = {'terminal'},
            bufnames = {}
        }
    },
    vi_mode_colors = {
        NORMAL = colors.blue1,
        INSERT = colors.nord_6,
        VISUAL = colors.nord_7,
        OP = colors.nord_7,
        BLOCK = colors.nord_7,
        REPLACE = colors.yellow,
        ['V-REPLACE'] = colors.yellow,
        ENTER = colors.cyan,
        MORE = colors.cyan,
        SELECT = colors.blue3,
        COMMAND = colors.blue1,
        SHELL = colors.purple,
        TERM = colors.purple,
        NONE = colors.yellow
    }
}

