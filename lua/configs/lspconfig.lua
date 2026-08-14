require("nvchad.configs.lspconfig").defaults()

local util = require("lspconfig.util")

-- Auto-collect global Composer stub paths (php-stubs + baxtian)
local function composer_php_stubs()
  local vendors = {
    "~/.config/composer/vendor/php-stubs",
    "~/.config/composer/vendor/baxtian",
    "~/.composer/vendor/php-stubs",
    "~/.composer/vendor/baxtian",
  }

  local seen, paths = {}, {}

  local function add_dir_if_exists(dir)
    local h = vim.loop.fs_scandir(dir)
    if not h then
      return
    end
    while true do
      local name = vim.loop.fs_scandir_next(h)
      if not name then
        break
      end
      local full = dir .. "/" .. name
      if vim.loop.fs_stat(full) and not seen[full] then
        seen[full] = true
        table.insert(paths, full)
      end
    end
  end

  for _, base in ipairs(vendors) do
    add_dir_if_exists(vim.fn.expand(base))
  end

  return paths
end

-- Vue/Nuxt LSP Config
local vue_language_server_path = vim.fn.stdpath "data"
  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}
vim.lsp.config("vtsls", {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

vim.lsp.config("intelephense", {
  on_init = require("nvchad.configs.lspconfig").on_init,
  on_attach = require("nvchad.configs.lspconfig").on_attach,
  capabilities = require("nvchad.configs.lspconfig").capabilities,

  settings = {
    intelephense = {
      environment = {
        includePaths = composer_php_stubs(), -- ← auto-adds all stubs
      },
      stubs = {
        "wordpress",
        "apache",
        "bcmath",
        "bz2",
        "calendar",
        "curl",
        "date",
        "dom",
        "fileinfo",
        "filter",
        "gd",
        "hash",
        "iconv",
        "intl",
        "json",
        "libxml",
        "mbstring",
        "openssl",
        "pcntl",
        "pcre",
        "PDO",
        "pdo_mysql",
        "posix",
        "readline",
        "session",
        "SimpleXML",
        "sockets",
        "sodium",
        "SPL",
        "standard",
        "tokenizer",
        "xml",
        "xmlreader",
        "xmlwriter",
        "zip",
        "zlib",
      },
      files = {
        maxSize = 10000000,
        exclude = {
          "**/.git/**",
          "**/node_modules/**",
          "**/vendor/**/tests/**",
          "**/vendor/**/docs/**",
          "**/dist/**",
          "**/build/**",
          "**/.cache/**",
          "**/uploads/**",
        },
      },
      telemetry = { enabled = false },
    },
  },
})

-- --- Twig / twiggy_language_server
vim.lsp.config("twiggy_language_server", {
  on_init = require("nvchad.configs.lspconfig").on_init,
  on_attach = require("nvchad.configs.lspconfig").on_attach,
  capabilities = require("nvchad.configs.lspconfig").capabilities,

  -- ensure the workspaceFolder = your THEME root
  root_dir = function(fname)
    return util.root_pattern("style.css", "composer.json", ".git")(fname)
  end,

  settings = {
    -- support both keys (some builds read one or the other)
    twiggy = {
      templatePaths = {
        "${workspaceFolder}",            -- allows "templates/components/…" to resolve
        "${workspaceFolder}/templates",  -- allows "components/…" to resolve
        "${workspaceFolder}/views",
      },
      diagnostics = { missingTemplates = "ignore" },
    },
    ["twiggy-language-server"] = {
      templatePaths = {
        "${workspaceFolder}",
        "${workspaceFolder}/templates",
        "${workspaceFolder}/views",
      },
      diagnostics = { missingTemplates = "ignore" },
    },
  },
})

-- Emmet: enable HTML-like tag expansion in Twig, PHP, Vue, etc.
vim.lsp.config("emmet_ls", {
  on_init = require("nvchad.configs.lspconfig").on_init,
  on_attach = require("nvchad.configs.lspconfig").on_attach,
  capabilities = require("nvchad.configs.lspconfig").capabilities,

  filetypes = {
    "html",
    "css",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "php",
    "twig", -- 👈 add this so it works in Twig files
  },

  init_options = {
    html = {
      options = { ["bem.enabled"] = true }, -- optional
    },
  },
})

local servers =
  { "html", "cssls", "vue_ls", "vtsls", "tailwindcss", "twiggy_language_server", "intelephense", "emmet_ls" }
vim.lsp.enable(servers)
-- read :h vim.lsp.config for changing options of lsp servers
