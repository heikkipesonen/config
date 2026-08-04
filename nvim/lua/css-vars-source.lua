-- Custom blink.cmp source for CSS design token variables.
-- Reads token file paths from .neoconf.json `cssVars` key in the project root.

local Source = {}

local items_cache = nil
local cache_cwd = nil

local function load_items()
  local cwd = vim.fn.getcwd()
  if items_cache and cache_cwd == cwd then
    return items_cache
  end

  local config_path = cwd .. '/.neoconf.json'
  local f = io.open(config_path, 'r')
  if not f then return {} end
  local content = f:read('*a')
  f:close()

  local ok, config = pcall(vim.json.decode, content)
  if not ok or not config.cssVars then return {} end

  local items = {}
  for _, file in ipairs(config.cssVars) do
    local path = cwd .. '/' .. file
    local cf = io.open(path, 'r')
    if cf then
      for line in cf:lines() do
        local name, value = line:match('%s*(%-%-[%w%-]+):%s*([^;/]+)')
        if name then
          value = value:gsub('%s+$', '')
          table.insert(items, {
            label = name,
            kind = 6, -- Variable
            detail = value,
            documentation = { kind = 'plaintext', value = value },
            insertText = name,
            filterText = name,
          })
        end
      end
      cf:close()
    end
  end

  items_cache = items
  cache_cwd = cwd
  return items
end

function Source.new()
  return setmetatable({}, { __index = Source })
end

function Source:enabled()
  local ft = vim.bo.filetype
  if ft ~= 'css' and ft ~= 'scss' then return false end
  local config_path = vim.fn.getcwd() .. '/.neoconf.json'
  local f = io.open(config_path, 'r')
  if not f then return false end
  local content = f:read('*a')
  f:close()
  local ok, config = pcall(vim.json.decode, content)
  return ok and config.cssVars ~= nil
end

function Source:get_trigger_characters()
  return { '-' }
end

function Source:get_completions(ctx, resolve)
  local items = load_items()
  resolve({ is_incomplete_forward = false, is_incomplete_backward = false, items = items })
end

return Source
