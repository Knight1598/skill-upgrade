# Locate the editable source

Work down the list; the first match wins. Say which path you chose and why. `~` is the user's home folder (`%USERPROFILE%` on Windows).

## 1. Installed plugin: find its repository, never edit the cache

A base directory under `~/.claude/plugins/cache/<marketplace>/<plugin>/<version>/` or `~/.claude/plugins/marketplaces/<marketplace>/` is an installed copy.

1. Search the current workspace and its parent folder for a `.claude-plugin/plugin.json` whose `name` is the plugin. A match inside a git repository is the source; use it.
2. Otherwise read `~/.claude/plugins/known_marketplaces.json`. The `<marketplace>` entry gives `source.repo` (GitHub `owner/repo`) or `source.url`. `~/.claude/plugins/installed_plugins.json` gives the installed version and commit.
3. Look for an existing clone of that repository in the user's recent project folders before cloning. Otherwise clone it into the session's working folder.
4. In the repository, `.claude-plugin/marketplace.json` maps the plugin to its root (`./` or `./products/<plugin>`). The skill is `<root>/skills/<skill>/`.
5. Treat the remote as writable only when its owner is the user's account or the user says so. Otherwise commit on a local branch and go to section 4.

## 2. Project or personal skill: edit in place

`.claude/skills/<name>/` or `.agents/skills/<name>/` in the project, or `~/.claude/skills/<name>/` for a personal skill. If its README or CHANGELOG names an upstream repository, edit upstream as in section 1 and tell the user the local copy must be re-copied.

## 3. Codex

Skills live in `~/.codex/skills/<name>/` or `.agents/skills/<name>/`. A skill copied from a repository is upgraded in that repository, as in section 1.

## 4. No write access

Built-in skills and other owners' repositories are not the user's to change. Write the change as a unified diff, `skill-upgrade-<skill>.patch`, in the working folder. Tell the user in two lines what it fixes and where to send it (an issue or pull request on the source repository).
