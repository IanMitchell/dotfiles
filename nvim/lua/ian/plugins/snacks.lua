return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      gitbrowse = {
        enabled = true,
        remote_patterns = {
          { "^git@git.pierre.co:(.*)%.git", "https://pierre.co/%1" },
        },
        url_patterns = {
          ["pierre%.co"] = {
            branch = "/{branch}",
            file = "/files/{branch}?path={file}#L{line_start}-L{line_end}",
            permalink = "/files/{commit}?path={file}#L{line_start}-L{line_end}",
            commit = "/history?commit={commit}",
          },
        },
      },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "OilActionsPost",
        callback = function(event)
          if event.data.actions.type == "move" then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
          end
        end,
      })

      ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
      local progress = vim.defaulttable()
      vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
          if not client or type(value) ~= "table" then
            return
          end
          local p = progress[client.id]

          for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
              p[i] = {
                token = ev.data.params.token,
                msg = ("[%3d%%] %s%s"):format(
                  value.kind == "end" and 100 or value.percentage or 100,
                  value.title or "",
                  value.message and (" **%s**"):format(value.message) or ""
                ),
                done = value.kind == "end",
              }
              break
            end
          end

          local msg = {} ---@type string[]
          progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
          end, p)

          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
              notif.icon = #progress[client.id] == 0 and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })
    end,
    keys = {
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "[B]uffer [D]elete",
      },
      {
        "<leader>og",
        function()
          Snacks.gitbrowse()
        end,
        desc = "[O]pen [G]it",
        mode = { "n", "v" },
      },
      {
        "<leader>nh",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>dn",
        function()
          Snacks.notifier.hide()
        end,
        desc = "[D]ismiss All [N]otifications",
      },
      {
        "<leader>nh",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "[N]otification [H]istory",
      },
      {
        "<leader>ln",
        function()
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):toggle()
        end,
        desc = "Toggle Relative [L]ine [N]umbers",
      },
      {
        "<leader>cl",
        function()
          Snacks.toggle.option("cursorline", { name = "Cursor Line" }):toggle()
        end,
        desc = "Toggle [C]ursor [L]ine",
      },
      {
        "<leader>td",
        function()
          Snacks.toggle.diagnostics():toggle()
        end,
        desc = "[T]oggle [D]iagnostics",
      },
      {
        "<leader>tt",
        function()
          local tsc = require "treesitter-context"
          Snacks.toggle({
            name = "Treesitter Context",
            get = tsc.enabled,
            set = function(state)
              if state then
                tsc.enable()
              else
                tsc.disable()
              end
            end,
          }):toggle()
        end,
        desc = "[T]oggle [T]reesitter Context",
      },
      {
        "<leader>hl",
        function()
          local hc = require "nvim-highlight-colors"
          Snacks.toggle({
            name = "Highlight Colors",
            get = function()
              return hc.is_active()
            end,
            set = function(state)
              if state then
                hc.turnOn()
              else
                hc.turnOff()
              end
            end,
          }):toggle()
        end,
        desc = "Toggle [H]igh[L]ight Colors",
      },
    },
  },
}
