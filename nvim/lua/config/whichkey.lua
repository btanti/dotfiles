local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },

--Movement Keys
    j = { "<C-w>j", "Focus lower buffer"},
    k  = { "<C-w>k", "Focus upper buffer"},
    l = { "<C-w>l", "Focus right buffer"},
    h = { "<C-w>h", "Focus left buffer"},
--Buffer
    b = {
      name = "Buffer",
      d = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },
    c = {
      name = "NERDCommenter"
    },
    d = {"<cmd>DogeGenerate<cr>", "Generate documentation"},
    e = {
      name = "Edit",
      w =  {"<cmd>e %%"},
      s =  {"<cmd>sp %%"},
      v =  {"<cmd>vsp &&"}
    },
    f = {
      name = "Diagnostics",
      e = {"<cmd>lua vim.diagnostic.open_float()<CR>", "Open (floating)"},
      n = {"<cmd>lua vim.diagnostic.goto_next()<CR>", "Goto next"},
      p = {"<cmd>lua vim.diagnostic.goto_prev()<CR>", "Goto previous"}
    },
    g = {
        name = "Fugitive",
	a = {":Git add -v -- .<CR>", "Add"},
	s = {":Git status<CR>", "Status"},
	c = {":Git commit -v -q<CR>,", "Commit"},
	p = {
	   name = "Push/Pull",
	   s = {":Git push -v<CR>", "Push"},
	   l = {":Git pull<CR>", "Pull"},
	},
	t = {":Git commit -v -q %:p<CR>", "Verbose Commit"},
	d = {":Git diff<CR>", "Diff"},
	e = {":Gedit<CR>", "Edit"},
	r = {":Gread<CR>", "Read"},
	w = {":Gwrite<CR><CR>", "Write"},
	l = {":silent! Glog<CR>:bot copen<CR>", "Log"},
	m = {":Gmove<Space>", "Move"},
	b = {":Git branch<Space>", "Branch",},
	o = {":Git checkout<Space>", "Checkout"},
    },
    t = {
      name = "Vim-test",
      t = {"<cmd>TestNearest<cr>", "Nearest"},
      T = {"<cmd>TestFile<cr>", "File"},
      a = {"<cmd>TestSuite<cr>", "Suite"},
      l = {"<cmd>TestLast<cr>", "Last"},
      g = {"<cmd>TestVisit<cr>", "Visit"},
    },
    x = {
      name = "Trouble",
      x = {"<cmd>TroubleToggle<cr>", "Show all diagnostics"},
      w = {"<cmd>TroubleToggle workspace_diagnostics<cr>", "Show workspace diagnostics"},
      d = {"<cmd>TroubleToggle document_diagnostics<cr>", "Show document diagnostics"},
      q = {"<cmd>TroubleToggle quickfix<cr>", "Show quickfix list"},
      l = {"<cmd>TroubleToggle loclist<cr>", "Show loclist"},
    },

    u = {
      name = "UltiSnips",
      e = {"<cmd>UltiSnipsEdit<cr>", "Edit snippets"},
      r = {"<cmd>call UltiSnips#RefreshSnippets()<cr>", "Refresh snippets"}
    },
    z = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    ["<space>"] = {
	name = "Jupyter",
	x = {"<cmd>JupyterExecute", "Execute cell"},
	X = {"<cmd>JupyterExecuteAll", "Execute all cells"},
    },
--Inkscape
    ["<s-f>"] = {"<cmd>luafile ~/personal/vim-inkscape/new_fig.lua<cr>", "Create Figure (tex)"},
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
-- Control keybindings
  whichkey.register({
    ["<c-f>"] = {"<cmd>luafile ~/personal/vim-inkscape/selector.lua<cr>", "Select Figures (tex)"},
  },
{
    mode = "n", -- Normal mode
    prefix = "",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }
  )
end

return M
