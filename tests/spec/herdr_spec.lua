describe("herdr module", function ()
  it("exposes a setup function", function ()
    local herdr = require("herdr")

    assert.is_table(herdr)
    assert.is_function(herdr.setup)
  end)
end)
