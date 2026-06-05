default:
  @just --list

plenary_dir := ".tests/site/pack/deps/start/plenary.nvim"

[script]
setup:
  mkdir -p .tests/site/pack/deps/start
  if [ ! -d "{{plenary_dir}}" ]; then
    git clone --depth 1 https://github.com/nvim-lua/plenary.nvim "{{plenary_dir}}"
  fi

[script]
test:
  if [ ! -d "{{plenary_dir}}" ]; then
    printf '%s\n' "error: missing test dependency: run 'just setup' first" >&2
    exit 1
  fi
  nvim --headless --noplugin -u tests/minimal_init.lua -c "PlenaryBustedDirectory tests/spec { minimal_init = 'tests/minimal_init.lua' }"

lint:
  emmylua_check -c .emmyrc.json -i ".tests/**,.git/**" lua tests

ci-quality:
  just lint
  just format-check

format-check:
  luafmt --check --config luafmt.toml --recursive ./lua ./tests

format:
  luafmt --write --config luafmt.toml --recursive ./lua ./tests
