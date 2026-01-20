return {
	{
		"williamboman/mason.nvim",
		config = function()
			local mason = require("mason")

			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			local mason_tool_installer = require("mason-tool-installer")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Get capabilities from nvim-cmp for autocompletion
			local capabilities = cmp_nvim_lsp.default_capabilities()

			-- Configure default settings for all servers
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Configure servers with custom settings using the new vim.lsp.config API
			vim.lsp.config.svelte = {
				capabilities = capabilities,
				filetypes = { "svelte" },
				on_attach = function(client)
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
				end,
			}

			vim.lsp.config.graphql = {
				capabilities = capabilities,
				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			}

			vim.lsp.config.emmet_ls = {
				capabilities = capabilities,
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
			}

			vim.lsp.config.lua_ls = {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			}

			-- Setup mason-lspconfig to automatically install and enable servers
			mason_lspconfig.setup({
				ensure_installed = {
					"ts_ls",
					"html",
					"cssls",
					"tailwindcss",
					"svelte",
					"lua_ls",
					"graphql",
					"emmet_ls",
					"prismals",
					"pyright",
				},
				automatic_enable = true, -- Automatically enable all installed servers
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"prettier", -- prettier formatter
					"stylua", -- lua formatter
					"ruff", -- python linter & formatter (replaces black, isort, pylint)
					"eslint_d", -- js linter
				},
			})
		end,
	},
}
