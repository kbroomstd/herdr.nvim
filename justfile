default:
  @just --list

mini_dir := "deps/mini.nvim"

[script]
setup:
  mkdir -p deps
  if [ ! -d "{{mini_dir}}" ]; then
    git clone --filter=blob:none https://github.com/nvim-mini/mini.nvim "{{mini_dir}}"
  fi

[script]
test:
  if [ ! -d "{{mini_dir}}" ]; then
    printf '%s\n' "error: missing test dependency: run 'just setup' first" >&2
    exit 1
  fi
  nvim --headless --noplugin -u ./scripts/minimal_init.lua -c "lua MiniTest.run()"

lint:
  emmylua_check -c .emmyrc.json  lua tests

ci-quality:
  just lint
  just format-check

format-check:
  luafmt --check --config luafmt.toml --recursive ./lua ./tests

format:
  luafmt --write --config luafmt.toml --recursive ./lua ./tests
