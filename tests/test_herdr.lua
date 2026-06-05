local MiniTest = require("mini.test")

M = require("herdr")

local new_set = MiniTest.new_set
local eq = MiniTest.expect.equality

local child = MiniTest.new_child_neovim()

local T = new_set({
  hooks = {
    pre_case = function ()
      child.restart({ "-u", "scripts/minimal_init.lua" })
      child.lua([[M = require("herdr")]])
    end,
    post_once = child.stop
  }
})

T['setup()'] = new_set()

T['setup()']['stores and returns supplied opts'] = function ()
  local result = child.lua_func(function ()
    local opts = { foo = "bar" }

    return { result = M.setup(opts), stored = M.opts }
  end)

  eq(result, {
    result = { foo = "bar" },
    stored = { foo = "bar" }
  })
end

T['setup()']['uses empty opts by default'] = function ()
  local result = child.lua_func(function ()
    return M.setup()
  end)

  eq(result, {})
end

return T
