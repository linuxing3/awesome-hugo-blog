+++
date = "2022-06-20T14:06:05-04:00"
title = "NeoVim is a modern life style"
+++

# Neovim outstanding configuration file

# My neovim simple configuration

- pure lua
- super fast
- intuitive

https://gitee.com/linuxing3/nvim

## 依赖

For newer version of neovim, use `snap` to install

```bash
sudo snap install neovim
sudo apt install -y ripgrep fd-find
```

## 构建

```bash
alias nvim=/snap/bin/nvim
nvim +PackerSync
nvim +Compile
```

## pack

```lua

---@diagnostic disable:undefined-global
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP =
        fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://hub.fastgit.xyz/wbthomason/packer.nvim",
        install_path
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the pack.lua and plugins.lua file
local packer_user_config = vim.api.nvim_create_augroup("packer_user_config", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "pack", "plugins.lua" },
    callback = function()
        vim.cmd("source <afile>")
        -- vim.cmd("PackerSync")
        vim.pretty_print("Reloading plugins successify...")
    end,
    group = packer_user_config,
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {border = "rounded"}
        end
    },
    git = {
        default_url_format = "https://hub.fastgit.xyz/%s"
    }
}

-- Install your plugins here
return packer.startup(
    function(use)
        -- My plugins here
        use "wbthomason/packer.nvim" -- Have packer manage itself
        use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
        use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
        -- Fuzzy finder
        use "junegunn/fzf"
        use "junegunn/fzf.vim"

	-- formatter
        use "sbdchd/neoformat"
        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if PACKER_BOOTSTRAP then
            require("packer").sync()
        end

        -- Loading custom plugins
        require("custom.plugins").install(use)
    end
)
```
## Plugins


```lua
---@diagnostic disable:undefined-global

local options = require("core.options")
local path = require("utils.api.path")

local M = {}

local plugins = {
    --     --[[
    -- 	=====================================
    -- 	  ------------- basic -------------
    -- 	=====================================
    -- 	--]]
    -- ["wbthomason/packer.nvim"] = {}, -- package manager
    ["lewis6991/impatient.nvim"] = {}, -- speed up startup
    ["tami5/sqlite.lua"] = {
        -- persistent storage history yank records
        after = {"impatient.nvim"}
    },
    ["nathom/filetype.nvim"] = {}, -- speed up startup
    ["rcarriga/nvim-notify"] = {}, -- fancy notification message
    -- ["akinsho/bufferline.nvim"] = {
    --     -- buffer label
    --     after = {"nvim-web-devicons"}
    -- },
    ["mbbill/undotree"] = {
        -- undo tree
        ptp = "viml",
    },
    ["folke/which-key.nvim"] = {
        -- keybinder
    },
    ["kyazdani42/nvim-tree.lua"] = {},
    --[[
	=====================================
	 ------------- Theme ---------------
	=====================================
	--]]
    ["askfiy/catppuccin"] = {},
    ["Mofiqul/vscode.nvim"] = {},
    ["projekt0n/github-nvim-theme"] = {},
    ["lunarvim/colorschemes"] = {},
    ["lunarvim/darkplus.nvim"] = {},
    ["folke/tokyonight.nvim"] = {},
    ["folke/lsp-colors.nvim"] = {},
    ["sainnhe/sonokai"] = {},
    ["NTBBloodbath/doom-one.nvim"] = {},
    ["glepnir/dashboard-nvim"] = {},
    --[[
 =====================================
  ---------- Fuzzy Finder ---------
 =====================================
 --]]
    -- ["vim-telescope/telescope-fzf-native.nvim"] = {run = "make"},
    ["nvim-telescope/telescope-project.nvim"] = {
        config = function()
            require "telescope".load_extension("project")
        end
    },
    ["nvim-telescope/telescope-file-browser.nvim"] = {
        config = function()
            require "telescope".load_extension("file_browser")
        end
    },
    ["liuchengxu/vim-clap"] = {
        ptp = "viml"
    },
    -- ["nvim-telescope/telescope-frecency.nvim"] = {
    --     config = function()
    --         require "telescope".load_extension("frecency")
    --     end,
    --     requires = {"tami5/sqlite.lua"}
    -- },
    ["nvim-telescope/telescope.nvim"] = {},
    --[[
	=====================================
	 ------------- Tools ---------------
	=====================================
	--]]
    --
    ["davidgranstrom/nvim-markdown-preview"] = {
        -- markdown preview tool
        ptp = "viml",
        ft = {"markdown"},
        cmd = {"MarkdownPreview"}
    },
    -- ["askfiy/nvim-picgo"] = {},
    ["mg979/vim-visual-multi"] = {
        -- multi-cursor mode
        ptp = "viml",
        fn = {"vm##add_cursor_up", "vm##add_cursor_down"},
        keys = {"<c-d>"}
    },
    ["jbyuki/venn.nvim"] = {},
    ["kristijanhusak/vim-carbon-now-sh"] = {
        -- carbon-based code screenshot tool (requires internet connection)
        ptp = "viml",
        cmd = {"CarbonNowSh"}
    },
    ["akinsho/toggleterm.nvim"] = {},
    --[[
	=====================================
	 ----- language server protocol ----
	=====================================
	--]]
    ["neovim/nvim-lspconfig"] = {
        -- Basic LSP configuration support
        after = {"impatient.nvim"}
    },
    ["hrsh7th/cmp-nvim-lsp"] = {
        -- Enhance neovim completion
        after = {"nvim-lspconfig"}
    },
    -- In order to keep the order of lazy loading, so this plugin is placed here
    -- but it is not part of the LSP plugin scope
    ["stevearc/aerial.nvim"] = {
        -- outline notation preview
        after = {"nvim-lspconfig"}
    },
    ["folke/lua-dev.nvim"] = {
        -- sumneko_lua enhancement plugin for neovim-lua development
        after = {"nvim-lspconfig"}
    },
    ["jose-elias-alvarez/null-ls.nvim"] = {
        -- Provides third-party diagnostics, debugging, formatting, etc. for the built-in LSP
        after = {"nvim-lspconfig"}
    },
    ["williamboman/nvim-lsp-installer"] = {
        -- automatically install LSP service
        after = {"nvim-lspconfig", "cmp-nvim-lsp", "aerial.nvim", "lua-dev.nvim", "null-ls.nvim"}
    },
    -- ["j-hui/fidget.nvim"] = {
    --     -- prompt LSP initialization status
    --     after = {"nvim-lsp-installer"}
    -- },
    ["kosayoda/nvim-lightbulb"] = {
        -- prompt a lightbulb when code behavior is available
        after = {"nvim-lsp-installer"}
    },
    --[[
	=====================================
	 --------- Code Completion ---------
	=====================================
	--]]
    ["rafamadriz/friendly-snippets"] = {
        -- provide rich snippet support
        event = {"InsertEnter", "CmdlineEnter"}
    },
    ["hrsh7th/vim-vsnip"] = {
        -- provide snippet support for nvim-cmp
        ptp = "viml",
        after = {"friendly-snippets"}
    },
    ["hrsh7th/nvim-cmp"] = {},
    ["hrsh7th/cmp-vsnip"] = {
        -- vsnip support for cmp
        after = {"nvim-cmp"}
    },
    ["hrsh7th/cmp-buffer"] = {
        -- provide buffer completion
        after = {"nvim-cmp"}
    },
    ["hrsh7th/cmp-path"] = {
        -- provide path completion
        after = {"nvim-cmp"}
    },
    ["hrsh7th/cmp-cmdline"] = {
        -- provide command line completion
        after = {"nvim-cmp"}
    },
    --[[
    -- 	=====================================
    -- 	 ----- debug adapter protocol ------
    -- 	=====================================
	--]]
    ["mfussenegger/nvim-dap"] = {},
    ["theHamsta/nvim-dap-virtual-text"] = {
        -- provide dummy text for debugging
        after = {"nvim-dap"}
    },
    ["rcarriga/nvim-dap-ui"] = {
        -- provide UI interface for debugging
        after = {"nvim-dap"}
    },
    --[[
	=====================================
	 ----------- Code Editor -----------
	=====================================
	--]]
    ["klen/nvim-test"] = {},
    ["windwp/nvim-autopairs"] = {
        -- autocomplete parentheses
        event = {"InsertEnter"}
    },
    -- ["norcalli/nvim-colorizer.lua"] = {
    --     -- view code color
    --     event = {"BufReadPre", "BufNewFile"}
    -- },
    ["RRethy/vim-illuminate"] = {
        -- highlight the same word under the cursor
        ptp = "viml",
    },
    ["lukas-reineke/indent-blankline.nvim"] = {
        -- highlight indent
    },
    ["nvim-treesitter/nvim-treesitter"] = {
        -- syntax tree plugin
        event = {"BufRead", "BufNewFile"},
        run = ":TSUpdate"
    },
    ["lewis6991/spellsitter.nvim"] = {
        after = {"nvim-treesitter"}
    },
    ["p00f/nvim-ts-rainbow"] = {
        -- rainbow brackets
        after = {"nvim-treesitter"}
    },
    ["windwp/nvim-ts-autotag"] = {
        -- autocomplete tags
        after = {"nvim-treesitter"}
    },
    ["JoosepAlviste/nvim-ts-context-commentstring"] = {
        -- Provides context-based commenting behavior for Comment
        after = {"nvim-treesitter"}
    },
    ["numToStr/Comment.nvim"] = {
        -- provide code comment function
        keys = {"gb", "gc"},
        after = {"nvim-ts-context-commentstring"}
    },
    ["tpope/vim-repeat"] = {
        -- repeat the modified surround operation of surround
        ptp = "viml",
        fn = "repeat#set"
    },
    ["ur4ltz/surround.nvim"] = {
        -- modify surround
        event = {"BufRead", "BufNewFile"}
    },
    ["folke/todo-comments.nvim"] = {
        -- highlight and find all TODO comments
        event = {"BufRead", "BufNewFile"}
    },
    ["AndrewRadev/switch.vim"] = {
        -- quickly switch the opposite of the word
        ptp = "viml",
        cmd = {"Switch"},
        fn = {"switch#Switch"}
    },
    ["Vimjas/vim-python-pep8-indent"] = {
        -- Python indentation rules
        ptp = "viml",
        ft = "py",
        event = {"InsertEnter"}
    },
    ["mattn/emmet-vim"] = {
        -- emmet abbreviation support
        ptp = "viml",
        ft = {"html", "javascript", "typescript", "vue", "xml", "jsx"}
    },
    --     --[[
    -- 	=====================================
    -- 	 ------- Database connection -------
    -- 	=====================================
    -- 	--]]
    ["tpope/vim-dadbod"] = {
        -- core tool for linking databases
        ptp = "viml",
        fn = {"db#resolve"}
    },
    ["kristijanhusak/vim-dadbod-ui"] = {
        -- quick link database
        ptp = "viml",
        cmd = "DBUIToggle"
    },
    --[[
 =====================================
  ---------- Other function ---------
 =====================================
 --]]
    ["NTBBloodbath/rest.nvim"] = {},
    ["nvim-pack/nvim-spectre"] = {},
    ["olimorris/persisted.nvim"] = {
        -- session manager
        after = {"impatient.nvim"}
    },
    ["yianwillis/vimcdoc"] = {
        -- vim Chinese documentation
        ptp = "viml",
        event = {"CmdlineEnter"},
        after = {"telescope.nvim"}
    },
    ["dstein64/vim-startuptime"] = {
        -- query startup time
        ptp = "viml",
        cmd = {"StartupTime"}
    },
    ["ethanholz/nvim-lastplace"] = {
        event = {"BufRead"}
    },
    ["uga-rosa/translate.nvim"] = {
        -- an excellent translation plugin
        cmd = {"Translate"}
    },
    ["jghauser/mkdir.nvim"] = {
        event = "CmdlineEnter"
    },
    ["michaelb/sniprun"] = {
        opt = true,
        run = "bash ./install.sh",
        cmd = {"SnipRun", "'<,'>SnipRun"}
    }
    -- ["AckslD/nvim-neoclip.lua"] = {
    --     -- can be used to quickly view historical yank records
    --     after = {"sqlite.lua"}
    -- },
    -- ["dstein64/nvim-scrollview"] = {
    --     -- draggable scrollbar
    --     event = {"BufRead", "BufNewFile"}
    -- },
}

-- local plugins_extra = {
--     ["kristijanhusak/vim-dadbod-completion"] = {
--         -- complete completion for dadbod  (it may affect performance)
--         ptp = "viml",
--         after = {"nvim-cmp"}
--     },
--     ["tzachar/cmp-tabnine"] = {
--         -- AI smart completion (it may affect performance)
--         disable = false,
--         run = "./install.sh",
--         after = {"nvim-cmp"}
--     },
--     ["github/copilot.vim"] = {
--         -- AI smart completion
--         disable = false,
--         ptp = "viml",
--         event = {"InsertEnter"}

function M.install(use)
    for plug_name, plug_config in pairs(plugins) do
        local plug_options = vim.tbl_deep_extend("force", {plug_name}, plug_config)
        local plug_filename = plug_options.as or string.match(plug_name, "/([%w%-_]+).?")
        -- The plugin configuration module that needs to be loaded
        -- Path: ~/.config/nvim/lua/custom/configure/plugins/
        local load_disk_path =
            path.join("custom", "configure", "plugins", string.format("nv_%s", plug_filename:lower()))
        -- Path of the plugin configuration module on disk
        local file_disk_path = path.join(vim.fn.stdpath("config"), "lua", string.format("%s.lua", load_disk_path))
        -- If the path exists, load the configuration, otherwise apply the plugin directly
        if path.is_exists(file_disk_path) then
            if plug_config.ptp == "viml" then
                plug_options.setup = string.format("require('%s').entrance()", load_disk_path)
            else
                plug_options.setup = string.format("require('%s').before()", load_disk_path)
                plug_options.config =
                    string.format(
                    [[
                        require('%s').load()
                        require('%s').after()
                        ]],
                    load_disk_path,
                    load_disk_path
                )
            end
        end
        use(plug_options)
    end
    if Packer_bootstrap then
        -- Automatically download plugins when neovim is opened for the first time
        packer.sync()
    end
end

return M
```

> The `install` function will do the trick, all configuration will be under `~/.config/nvim/lua/custom/configure/plugins/` with name as `nv_plugin_name.lua`

> Each configuration file is a lua module which has `before`, `load` and `after` method
> `before` for prepare
> `load` for setup, most of time you make `plugin_name.setup{}` here
> `after` for post actions like key mapping

| i.e.

```lua
-- https://github.com/numToStr/Comment.nvim

local M = {}

function M.before() end

function M.load()
    local ok, m = pcall(require, "Comment")
    if not ok then
        return
    end

    M.comment = m
    M.comment_utils = require("Comment.utils")
    M.comment.setup({
        toggler = {
            line = "gcc",
            block = "gcb",
        },
        opleader = {
            line = "gc",
            block = "gb",
        },
        extra = {
            above = "gck",
            below = "gcj",
            eol = "gca",
        },
        pre_hook = function(ctx)
            local location = nil
            if ctx.ctype == M.comment_utils.ctype.block then
                location = require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == M.comment_utils.cmotion.v or ctx.cmotion == M.comment_utils.cmotion.V then
                location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring.internal").calculate_commentstring({
                key = ctx.ctype == M.comment_utils.ctype.line and "__default" or "__multiline",
                location = location,
            })
        end,
    })
end

function M.after() end

return M
```

## Workflow

1. Add a new blog

2. Editing

3. Saving

4. toggle float terminal with `<Space>tf`

5. Press `a` to add new file

6. Press `c` to commit

7. Press `P` to push

8. Wait for `github workflow` to generate blog

9. Visit blog at `https://linuxing3.github.io` and `http://localhost:1313`

## 参与贡献

## 翻译

## 授权协议

