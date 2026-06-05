default:
  @just --list

mini_dir := "deps/mini.nvim"

[script]
setup:
  mkdir -p deps
  if [ ! -d "{{mini_dir}}" ]; then
    git clone --filter=blob:none https://github.com/nvim-mini/mini.nvim "{{mini_dir}}"
  fi

test: setup
  nvim --headless --noplugin -u ./scripts/minimal_init.lua -c "lua MiniTest.run()"

lint:
  emmylua_check -c .emmyrc.json  lua tests

format-check:
  luafmt --check --config luafmt.toml --recursive ./lua ./tests

format:
  luafmt --write --config luafmt.toml --recursive ./lua ./tests

