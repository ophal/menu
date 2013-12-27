local module_invoke_all, empty, l = module_invoke_all, seawolf.variable.empty, l
local tconcat, tinsert, theme, pairs = table.concat, table.insert, theme, pairs

local debug = debug

module 'ophal.modules.menu'

local menus = {
  primary_links = {
  }
}

local menus_build

function get_menus(reset)
  if reset then
    menus_build = false
  end

  if not menus_build then
    module_invoke_all('menus_alter', menus)
    menus_build = true
  end

  return menus
end

function theme.menu(variables)
  local menu_id = variables.id
  local menu = get_menus()[menu_id] or {}

  local items = {}
  for k, v in pairs(menu) do
    tinsert(items, l(v, k))
  end
  return theme{'item_list', id = 'menu_' .. menu_id, class = 'menu', list = items}
end
