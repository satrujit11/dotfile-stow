-- return {
--   "rcarriga/nvim-dap-ui",
--   dependencies = {
--     "mfussenegger/nvim-dap",
--     "nvim-neotest/nvim-nio"
--   },
--   config = function()
--     local dap, dapui = require("dap"), require("dapui")
--
--     dapui.setup()
--
--     dap.listeners.before.attach.dapui_config = function() dapui.open() end
--     dap.listeners.before.launch.dapui_config = function() dapui.open() end
--     dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
--     dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
--
--     --- SDK Helpers
--     local function get_asdf_bin(name)
--       local handle = io.popen("asdf which " .. name)
--       if not handle then return nil end
--       local result = handle:read("*a")
--       handle:close()
--       return result:gsub("/bin/" .. name .. "%s*$", "")
--     end
--
--     local flutter_sdk = get_asdf_bin("flutter")
--     local dart_sdk = flutter_sdk
--     -- local node_path = io.popen("asdf which nodejs"):read("*a"):gsub("%s*$", "")
--
--     -- --- FLUTTER: Device Picker
--     -- local function pick_flutter_device(callback)
--     --   local handle = io.popen("flutter devices --machine")
--     --   if not handle then return callback(nil) end
--     --   local output = handle:read("*a")
--     --   handle:close()
--     --
--     --   local ok, devices = pcall(vim.fn.json_decode, output)
--     --   if not ok or not devices or #devices == 0 then
--     --     vim.notify("No Flutter devices found", vim.log.levels.ERROR)
--     --     return callback(nil)
--     --   end
--     --
--     --   local entries = {}
--     --   for _, dev in ipairs(devices) do
--     --     table.insert(entries, {
--     --       label = dev.name .. " (" .. dev.id .. ")",
--     --       id = dev.id,
--     --     })
--     --   end
--     --
--     --   -- Using Telescope to display the options
--     --   local actions = require('telescope.actions')
--     --   local action_state = require('telescope.actions.state')
--     --
--     --   require('telescope.pickers').new({}, {
--     --     prompt_title = "Select Flutter Device",
--     --     finder = require('telescope.finders').new_table {
--     --       results = entries,
--     --       entry_maker = function(entry)
--     --         return {
--     --           value = entry.id,
--     --           display = entry.label,
--     --           ordinal = entry.label,
--     --         }
--     --       end,
--     --     },
--     --     sorter = require('telescope.sorters').get_fuzzy_file(),
--     --     attach_mappings = function(_, map)
--     --       -- Selecting an item
--     --       map('i', '<CR>', function(prompt_bufnr)
--     --         local selection = action_state.get_selected_entry(prompt_bufnr)
--     --         callback(selection and selection.value or nil)
--     --         actions.close(prompt_bufnr)
--     --       end)
--     --
--     --       -- Using 'Esc' to close the picker without selecting anything
--     --       map('i', '<Esc>', function(prompt_bufnr)
--     --         actions.close(prompt_bufnr)
--     --         callback(nil) -- Return nil when cancelled
--     --       end)
--     --
--     --       return true
--     --     end,
--     --   }):find()
--     -- end
--
--
--
--     --- Command to trigger Flutter attach with picker
--     -- vim.api.nvim_create_user_command("DapFlutterAttach", function()
--     --   pick_flutter_device(function(device_id)
--     --     if not device_id then return end
--     --     dap.configurations.dart = {
--     --       {
--     --         type = "flutter",
--     --         request = "attach",
--     --         name = "Attach to Flutter",
--     --         dartSdkPath = dart_sdk .. "/bin/dart",
--     --         flutterSdkPath = flutter_sdk .. "/bin/flutter",
--     --         cwd = "${workspaceFolder}",
--     --         deviceId = device_id,
--     --       }
--     --     }
--     --     dap.continue()
--     --   end)
--     -- end, {})
--
--     dap.adapters["dart"] = {
--       type = "executable",
--       command = flutter_sdk .. "/bin/flutter",
--       args = { "debug_adapter" },
--     }
--
--     dap.adapters["flutter"] = {
--       type = "executable",
--       command = flutter_sdk .. "/bin/flutter",
--       args = { "attach" },
--     }
--     --- FLUTTER DAP
--     dap.configurations.dart = {
--       {
--         type = "dart",
--         request = "launch",
--         name = "Launch Dart",
--         dartSdkPath = dart_sdk .. "/bin/dart",
--         flutterSdkPath = flutter_sdk .. "/bin/flutter",
--         program = "${workspaceFolder}/lib/main.dart",
--         cwd = "${workspaceFolder}",
--       },
--       {
--         type = "flutter",
--         request = "launch",
--         name = "Launch Flutter",
--         dartSdkPath = dart_sdk .. "/bin/dart",
--         flutterSdkPath = flutter_sdk .. "/bin/flutter",
--         program = "${workspaceFolder}/lib/main.dart",
--         cwd = "${workspaceFolder}",
--       }
--     }
--
--     -- --- NODEJS / TYPESCRIPT
--     -- dap.adapters["pwa-node"] = {
--     --   type = "server",
--     --   host = "::1",
--     --   port = "${port}",
--     --   executable = {
--     --     command = "node",
--     --     args = {
--     --       vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
--     --       "${port}",
--     --     },
--     --   },
--     -- }
--     --
--     --
--     -- local node_dap_config = {
--     --   {
--     --     type = "pwa-node",
--     --     request = "launch",
--     --     name = "Launch file (TS/JS)",
--     --     program = "${file}",
--     --     cwd = "${workspaceFolder}",
--     --     runtimeExecutable = node_path,
--     --     runtimeArgs = { "--loader", "ts-node/esm" },
--     --     sourceMaps = true,
--     --     protocol = "inspector",
--     --     skipFiles = { "<node_internals>/**", "node_modules/**" },
--     --   },
--     --   {
--     --     type = "pwa-node",
--     --     request = "attach",
--     --     name = "Attach to process",
--     --     processId = "pick",
--     --     cwd = "${workspaceFolder}",
--     --     protocol = "inspector",
--     --     sourceMaps = true,
--     --     skipFiles = { "<node_internals>/**", "node_modules/**" },
--     --   }
--     -- }
--     --
--     -- dap.configurations.typescript = node_dap_config
--     -- dap.configurations.javascript = node_dap_config
--   end
-- }
-- --
-- -- local function flutter_path()
-- --   -- asdf installs shims in ~/.asdf/shims
-- --   -- `asdf which flutter` returns the actual path to the Flutter binary
-- --   local handle = io.popen("asdf which flutter")
-- --   local flutter_bin = handle and handle:read("*l")
-- --   handle:close()
-- --
-- --   if flutter_bin == nil then
-- --     error("Could not find Flutter via asdf")
-- --   end
-- --
-- --   -- Strip the trailing "/bin/flutter" to get the root Flutter path
-- --   return flutter_bin:gsub("/bin/flutter$", "")
-- -- end
-- --
-- -- return {
-- --   {
-- --     "jay-babu/mason-nvim-dap.nvim",
-- --     dependencies = {
-- --       "williamboman/mason.nvim",
-- --       "mfussenegger/nvim-dap",
-- --     },
-- --     config = function()
-- --       require("mason").setup()
-- --
-- --       require("mason-nvim-dap").setup({
-- --         ensure_installed = { "flutter", "dart", "node2" },
-- --         automatic_installation = true,
-- --         handlers = {
-- --           ["dart"] = function(config)
-- --             local dap = require("dap")
-- --             local flutter_root = flutter_path()
-- --
-- --             dap.adapters.dart = {
-- --               type = "executable",
-- --               command = flutter_root .. "/bin/cache/dart-sdk/bin/dart",
-- --               args = { "debug_adapter" },
-- --             }
-- --
-- --             dap.configurations.dart = {
-- --               {
-- --                 type = "dart",
-- --                 request = "launch",
-- --                 name = "Launch Flutter",
-- --                 dartSdkPath = flutter_root .. "/bin/cache/dart-sdk",
-- --                 flutterSdkPath = flutter_root,
-- --                 program = "${workspaceFolder}/lib/main.dart",
-- --                 cwd = "${workspaceFolder}",
-- --               },
-- --             }
-- --           end,
-- --         },
-- --       })
-- --     end,
-- --   }
-- -- }
-- --
-- -- return {}
--
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",
  },
  config = function()
    require("dapui").setup()
    require("nvim-dap-virtual-text").setup()

    local dap = require("dap")

    dap.adapters["pwa-node"] = {
      type = "executable",
      host = "127.0.0.1",
      port = 9229,
      command = "node",
      args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "--stdio" },

      -- executable = {
      --   command = "js-debug-adapter",
      -- }
    }

    for _, language in ipairs({ "typescript", "javascript" }) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file (" .. language .. ")",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to nodemon (9229)",
          port = 9229,
          cwd = "${workspaceFolder}",
          skipFiles = { "<node_internals>/**" },
          restart = true,
          sourceMaps = true,
          protocol = "inspector",
        },
      }
    end
  end
}
