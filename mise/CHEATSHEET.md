# mise — everyday commands (for an asdf user)

This repo manages tool versions with [mise](https://mise.jdx.dev). The global
config lives in [`config.toml`](./config.toml), symlinked to
`~/.config/mise/config.toml` by dotbot. mise reads the same version files asdf
did — `.tool-versions`, `.ruby-version`, `.nvmrc` — so existing project repos
work unchanged.

> **Biggest difference from asdf:** mise activates by editing `PATH` per
> directory (no shims by default), so there is **no `asdf reshim`**. Activation
> happens in `zshrc` via `eval "$(mise activate zsh)"`.

## asdf → mise quick reference

| Task | asdf | mise |
|---|---|---|
| Install everything from config | `asdf install` | `mise install` |
| Install one version | `asdf install node 22.6.0` | `mise install node@22.6.0` |
| List installed | `asdf list` / `asdf list node` | `mise ls` / `mise ls node` |
| List available (remote) | `asdf list all node` | `mise ls-remote node` |
| Show active versions | `asdf current` | `mise current` |
| Set **global** version | `asdf set --home node 22` | `mise use -g node@22` |
| Set **project** version | `asdf set node 22` | `mise use node@22` |
| Uninstall a version | `asdf uninstall node 22.6.0` | `mise uninstall node@22.6.0` |
| Where a version lives | `asdf where node` | `mise where node@22.6.0` |
| Which binary resolves | `asdf which node` | `mise which node` |
| Run one-off with a version | — | `mise exec node@20 -- node app.js` (alias `mise x`) |
| Reshim after `gem install` | `asdf reshim` | not needed (no shims) |
| Add a plugin first | `asdf plugin add x` | usually unnecessary — `mise use x` resolves from the registry |

## Common workflows

**Install / sync everything pinned globally**
```sh
mise install
```

**Change a global tool version** (e.g. bump Node)
```sh
mise use -g node@24
```
⚠️ `~/.config/mise/config.toml` is a **symlink into this repo**, so `mise use -g`
edits `mise/config.toml` here — commit the change like any other dotfile edit.

**Work in a project** — versions come from the repo's committed `.ruby-version` /
`.nvmrc` / `.tool-versions`; just install them:
```sh
cd ~/Sites/<repo> && mise install
```

**See what's active in the current directory**
```sh
mise current          # or: mise ls --current
```

**Find and upgrade outdated tools**
```sh
mise outdated
mise upgrade [tool]
```

**Run a project task** (mise has a built-in task runner — e.g. adminfacer)
```sh
mise tasks            # list available tasks
mise run <task>
```

**Trust a project's `mise.toml` / env** (the equivalent of `direnv allow`)
```sh
mise trust
```

**Inspect / debug**
```sh
mise doctor           # activation + PATH health
mise config ls        # which config files are in scope here
mise settings         # effective settings
```

**Reclaim disk**
```sh
mise prune            # remove installed versions no config references
```

## Notes specific to this setup

- **Upgrade mise itself** via Homebrew: `brew upgrade mise` (not `mise self-update`).
- **`.tool-versions` still works** — mise reads it. A *personal*, machine-only
  override can go in a gitignored `mise.local.toml` in a repo (highest
  precedence, never committed).
- **Idiomatic version files** (`.ruby-version`, `.nvmrc`) are read because
  `idiomatic_version_file_enable_tools` is set in `config.toml` — the equivalent
  of asdf's `legacy_version_file = yes`.
- **direnv is still installed** and handles project env (`.envrc`); mise handles
  tools. They coexist.
- **Corepack is auto-enabled per node** (`node.corepack = true`), so `yarn` /
  `pnpm` follow each project's `packageManager` field instead of a global classic
  yarn.
