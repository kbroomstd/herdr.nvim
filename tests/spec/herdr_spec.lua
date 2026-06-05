describe("herdr module", function ()
  it("exposes a setup function", function ()
    local ok, module = pcall(require, "herdr")

    assert.is_true(ok)
    assert.is_table(module)
    assert.is_function(module.setup)
  end)
end)
