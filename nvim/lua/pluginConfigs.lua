------------------------------------------------------------------------
--  _  __              _      _        ____  _             _
-- | |/ /___ _ __  ___(_) ___( )___   |  _ \| |_   _  __ _(_)_ __  ___
-- | ' // _ \ '_ \|_  / |/ _ \// __|  | |_) | | | | |/ _` | | '_ \/ __|
-- | . \  __/ | | |/ /| |  __/ \__ \  |  __/| | |_| | (_| | | | | \__ \
-- |_|\_\___|_| |_/___|_|\___| |___/  |_|   |_|\__,_|\__,_|_|_| |_|___/
--                                                   |___/
------------------------------------------------------------------------

-- Configuration for cmp {{{
vim.opt.spell = true
vim.spelllang = { 'en_ca' }

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.menu = ({
        vsnip = '[Snippet]',
        buffer = '[File]',
        path = '[Path]',
      })[entry.source.name]

      return vim_item
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 1 },
    { name = 'vsnip', priority = 2 },
    { name = 'spell', priority = 3 },
    { name = 'buffer', priority = 4 },
    { name = 'path', priority = 5 },

    -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer'},
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pyright'].setup {
  capabilities = capabilities
}
require('lspconfig')['bashls'].setup {
  capabilities = capabilities
}
require('lspconfig')['vimls'].setup {
  capabilities = capabilities
}
require('lspconfig')['tsserver'].setup {
  capabilities = capabilities
}
require('lspconfig')['clangd'].setup {
  capabilities = capabilities
}
require('lspconfig')['java_language_server'].setup {
  capabilities = capabilities
}

require('lspconfig')['sumneko_lua'].setup {
  capabilities = capabilities,
  cmd = { '/Users/kenzie_mackinnon/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server' }
}
-- }}}

-- Configuration for lualine {{{

-- Bubbles config for lualine {{{2
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}
-- }}}

-- Function that will add word count for markdown and text files {{{2
local function getWords()
  if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. " word"
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. " words"
    else
      return tostring(vim.fn.wordcount().words) .. " words"
    end
  else
    return ""
  end
end
-- }}}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = '|',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true, -- For later ''
  },
  sections = {
    lualine_a = {
        {'mode', separator = { right = '', left = '' }, right_padding = 1 },
    },
    lualine_b = {'filename','branch', 'diff'},
    lualine_c = { getWords },
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {
      { 'location', separator = { right = '', left = '' }, left_padding = 1 },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
-- }}}

-- Configuration for telescope {{{
require('telescope').setup {
  defaults = {
    sort_method = 'mru',
    preview_width = 0.4,
    preview_height = 0.4,
    preview_method = 'auto',
    preview_delay = 0.1
  },
}
-- }}}

-- Congiuration for bufferline {{{
require('bufferline').setup {
  options = {
    -- separator_style = "slant"
    -- indicator_icon = ' ',
    left_trunc_marker = '|',
    right_trunc_marker = '|',
    right_mouse_command = 'vertical sbuffer %d'
  },
}

-- }}}

-- Congiuration for tabline {{{

-- require'tabline'.setup {
--   -- Defaults configuration options
--   enable = true,
--   options = {
--   -- If lualine is installed tabline will use separators configured in lualine by default.
--   -- These options can be used to override those settings.
--     section_separators = {'', ''},
--     component_separators = {'|', '|'},
--     max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
--     show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
--     show_devicons = true, -- this shows devicons in buffer section
--     show_bufnr = false, -- this appends [bufnr] to buffer section,
--     show_filename_only = false, -- shows base filename only instead of relative path in filename
--     modified_icon = "+ ", -- change the default modified icon
--     modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
--   }
-- }
-- vim.cmd[[
--   set guioptions-=e " Use showtabline in gui vim
--   set sessionoptions+=tabpages,globals " store tabpages and globals in session
-- ]]

-- }}}

-- Configuration for mdeval {{{
require ('mdeval').setup{
  -- Don't ask before executing code blocks
  require_confirmation=false,
  -- Change code blocks evaluation options.
  eval_options = {
    -- Set custom configuration for C++
    cpp = {
      command = {"clang++", "-std=c++20", "-O0"},
      default_header = [[
    #include <iostream>
    #include <vector>
    using namespace std;
      ]]
    },
    -- Add new configuration for Racket
    racket = {
      command = {"racket"},        -- Command to run interpreter
      language_code = "racket",    -- Markdown language code
      exec_type = "interpreted",   -- compiled or interpreted
      extension = "rkt",           -- File extension for temporary files
    },
    python = {
      command = {"python3"},
      language_code = "python",
      exec_type = "interpreted",
      extension = "py",
    },
  },
}
--
-- }}}

-- Configuration for nvim-transparent {{{
require("transparent").setup({
  enable = true, -- boolean: enable transparent
  extra_groups = { -- table/string: additional groups that should be clear
    -- In particular, when you set it to 'all', that means all avaliable groups

    -- for akinsho/nvim-bufferline.lua
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
    -- for akinsho/lualine.lua
  },
  exclude = {}, -- table: groups you don't want to clear
})

-- }}}

-- Configuration for spellsitter {{{
-- require('spellsitter').setup {}

-- }}}

-- Configuration for TrueZen {{{
local true_zen = require("true-zen")

true_zen.setup({
	ui = {
		bottom = {
			laststatus = 0,
			ruler = false,
			showmode = false,
			showcmd = false,
			cmdheight = 1,
		},
		top = {
			showtabline = 0,
		},
		left = {
			number = false,
			relativenumber = false,
			signcolumn = "no",
		},
	},
	modes = {
		ataraxis = {
			left_padding = 32,
			right_padding = 32,
			top_padding = 1,
			bottom_padding = 1,
			ideal_writing_area_width = {0},
			auto_padding = true,
			keep_default_fold_fillchars = true,
			custom_bg = {"none", ""},
			bg_configuration = true,
			quit = "untoggle",
			ignore_floating_windows = true,
			affected_higroups = {
				NonText = true,
				FoldColumn = true,
				ColorColumn = true,
				VertSplit = true,
				StatusLine = true,
				StatusLineNC = true,
				SignColumn = true,
			},
		},
		focus = {
			margin_of_error = 5,
			focus_method = "experimental"
		},
	},
	integrations = {
		vim_gitgutter = false,
		galaxyline = false,
		tmux = false,
		gitsigns = false,
		nvim_bufferline = false,
		limelight = false,
		twilight = false,
		vim_airline = false,
		vim_powerline = false,
		vim_signify = false,
		express_line = false,
		lualine = false,
		lightline = false,
		feline = false
	},
	misc = {
		on_off_commands = false,
		ui_elements_commands = false,
		cursor_by_mode = false,
	}
})

-- }}}

-- Configuration for ToggleTerm {{{
require('toggleterm').setup{
--  -- size can be a number or function which is passed the current terminal
--  function (term)
--    if term.direction == "horizontal" then
--      return 15
--    elseif term.direction == "vertical" then
--      return vim.o.columns * 0.4
--    end
--  end,
--  open_mapping = [[<c-\>]],
--  on_open = fun(t: Terminal), -- function to run when the terminal opens
--  on_close = fun(t: Terminal), -- function to run when the terminal closes
--  hide_numbers = true, -- hide the number column in toggleterm buffers
--  shade_filetypes = {},
--  shade_terminals = true,
--  shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
--  start_in_insert = true,
--  insert_mappings = true, -- whether or not the open mapping applies in insert mode
--  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
--  persist_size = true,
--  direction = 'vertical' | 'horizontal' | 'window' | 'float',
--  close_on_exit = true, -- close the terminal window when the process exits
--  shell = zsh, -- change the default shell
--  -- This field is only relevant if direction is set to 'float'
--  float_opts = {
--    -- The border key is *almost* the same as 'nvim_open_win'
--    -- see :h nvim_open_win for details on borders however
--    -- the 'curved' border is a custom border type
--    -- not natively supported but implemented in this plugin.
--    border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
--    width = <value>,
--    height = <value>,
--    winblend = 3,
--    highlights = {
--      border = "Normal",
--      background = "Normal",
--    }
--  }
}

-- }}}

-- Configuration for Discord Presence {{{
-- The setup config table shows all available config options with their default values:
-- require("presence"):setup({
--     -- General options
--     auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
--     neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
--     main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
--     client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
--     log_level           = "debug",                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
--     debounce_timeout    = 30,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
--     enable_line_number  = false,                      -- Displays the current line number instead of the current project
--     blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
--     buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
--     file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
-- 
--     -- Rich Presence text options
--     editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
--     file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
--     git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
--     plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
--     reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
--     workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
--     line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
-- })
-- }}}
