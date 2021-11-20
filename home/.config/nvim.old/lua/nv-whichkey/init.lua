local wk = require("which-key")

wk.register({
    a = {
        name = "+actions",
        c = {"<cmd>ColorizerToggle<cr>", "colorizer"},
        h = {"<cmd>let @/ = ''<cr>", "remove search highlight"},
        n = {"<cmd>set nonumber!<cr>", "line numbers"},
        r = {"<cmd>set norelativenumber!<cr>", "relative line numbers"},
        b = {"<cmd>Bracey<cr>", "start the bracey server"},
        B = {"<cmd>BraceyStop<cr>", "stop the bracey server"},
        t = {"<cmd>NvimTreeToggle<cr>", "nvim tree"}
    }
}, {prefix = "<leader>"})

wk.register({
    b = {
        name = "+buffer",
        n = {"<cmd>bnext<cr>", "next buffer"},
        p = {"<cmd>bprevious<cr>", "previous buffer"},
        f = {"<cmd>Telescope buffers<cr>", "find buffer"},
        b = {"<cmd>BufferPick<cr>", "pick buffer"},
        c = {"<cmd>BufferClose<cr>", "close buffer"}
    }
}, {prefix = "<leader>"})

wk.register({
    b = {
        name = "+buffer",
        n = {"<cmd>bnext<cr>", "next buffer"},
        p = {"<cmd>bprevious<cr>", "previous buffer"},
        f = {"<cmd>Telescope buffers<cr>", "find buffer"},
        b = {"<cmd>BufferPick<cr>", "pick buffer"},
        c = {"<cmd>BufferClose<cr>", "close buffer"}
    }
}, {prefix = "<leader>"})

wk.register({
    c = {
        name = "+code",
        f = {"<cmd>Neoformat<cr>", "format file"}
    }
}, {prefix = "<leader>"})

wk.register({
    w = {
        name = "+window",
        c = {"<cmd>q<cr>", "close split"},
        k = {"<cmd>on<cr>", "kill all splits"},
        K = {"<cmd>on!<cr>", "kill all splits (force)"},
        v = {"<cmd>vs<cr>", "vertical split"},
        h = {"<cmd>hs<cr>", "horizontal split"}
    }
}, {prefix = "<leader>"})

wk.register({
    s = {
        name = "+search",
        F = {"<cmd>Telescope filetypes<cr>", "filetypes"},
        B = {"<cmd>Telescope git_branches<cr>", "git brances"},
        d = {
            "<cmd>Telescope lsp_document_diagnostics<cr>",
            "document_diagnostics"
        },
        D = {
            "<cmd>Telescope lsp_workspace_diagnostics<cr>",
            "workspace_diagnostics"
        },
        f = {"<cmd>Telescope find_files<cr>", "files"},
        h = {"<cmd>Telescope command_history<cr>", "command history"},
        i = {"<cmd>Telescope media_files<cr>", "media files"},
        m = {"<cmd>Telescope marks<cr>", "marks"},
        M = {"<cmd>Telescope man_pages<cr>", "man pages"},
        o = {"<cmd>Telescope vim_options<cr>", "vim options"},
        t = {"<cmd>Telescope live_grep<cr>", "text"},
        r = {"<cmd>Telescope registers<cr>", "registers"},
        w = {"<cmd>Telescope file_browser<cr>", "buf_fuz_find"},
        u = {"<cmd>Telescope colorscheme<cr>", "colorschemes"}
    }
}, {prefix = "<leader>"})

wk.register({
    r = {
        name = "+ranger",
        r = {"<cmd>Ranger<cr>", "ranger"},
        c = {"<cmd>RangerCurrentDirectory<cr>", "current directory"},
        w = {"<cmd>RangerWorkingDirectory<cr>", "working directory"},
        f = {"<cmd>RangerCurrentFile<cr>", "current file"},
        t = {"<cmd>RangerNewTab<cr>", "new tab (current directory)"},
        T = {
            "<cmd>RangerWorkingDirectoryNewTab<cr>",
            "new tab (working directory)"
        }
    }
}, {prefix = "<leader>"})

wk.register({g = {name = "+git", g = {"<cmd>LazyGit<cr>", "lazygit"}}},
            {prefix = "<leader>"})

wk.register({
    e = {
        name = "+emmet",
        b = {"<cmd>Emmet !<cr>", "insert boilerplate html"},
        e = {
            "<cmd>call emmet#expandAbbr(3, \"\")<cr>", "insert boilerplate html"
        }
    }
}, {prefix = "<leader>"})
