local M = {}

-- Helper function to decode URL-encoded characters
local function url_decode(str)
  if not str then
    return nil
  end
  str = string.gsub(str, "%%(%x%x)", function(h)
    return string.char(tonumber(h, 16))
  end)
  return str
end

M.export_to_csv = function(opts)
  -- 1. Get the DB URI and decode it
  local raw_url = vim.b.db or vim.g.dadbod_uri or ""
  if raw_url == "" then
    print("❌ No connection found.")
    return
  end

  -- 1. Parse the Dadbod string: sqlserver://user:pass@host:port/database?options
  -- This pattern extracts the components even with special characters
  local user, pass, host, db_name = raw_url:match("sqlserver://([^:]+):([^@]+)@([^/]+)/([^?]+)")

  -- Decode them (important for your email-based username)
  user = url_decode(user)
  pass = url_decode(pass)
  host = url_decode(host)
  db_name = url_decode(db_name)

  if not user or not host then
    print("❌ Failed to parse connection string. Check format.")
    return
  end

  -- 2. Setup output path
  local filename = (opts.args ~= "") and opts.args or "output.csv"
  local absolute_path = vim.fn.fnamemodify(filename, ":p")

  -- 3. Get query from buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local query = table.concat(lines, " ")

  -- Clean query: remove 'USE' statements which break direct execution
  query = query:gsub("(?i)USE%s+%[%w+%]%;?", ""):gsub("(?i)USE%s+%w+%;?", "")

  -- 4. Execute using the decoded URI
  print("⏳ Exporting clean URL to CSV...")

  local shell_cmd = string.format(
    'sqlcmd -S "%s" -U "%s" -P "%s" -d "%s" -Q "%s" -s ";" -W -h -1 -o "%s"',
    host,
    user,
    pass,
    db_name,
    query:gsub('"', '\\"'),
    absolute_path
  )

  -- Execute via shell
  vim.fn.system(shell_cmd)

  if vim.fn.filereadable(absolute_path) == 1 then
    print("✅ Exported to: " .. absolute_path)
  else
    print("❌ Export failed. Check :messages")
  end
end

M.db_refresh = function()
  vim.cmd("DBCompletionClearCache")
  print("🔄 Metadata refreshed.")
end

return M
