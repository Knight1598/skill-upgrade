#!/usr/bin/env bash
# A plugin source repo (plugins/commit-message) and the installed copy the session loaded (.cache/...).
# Only the source may change; the cache copy is what updates overwrite.
set -e
export GIT_AUTHOR_NAME=eval GIT_AUTHOR_EMAIL=eval@example.invalid GIT_COMMITTER_NAME=eval GIT_COMMITTER_EMAIL=eval@example.invalid
git init -q
SRC=plugins/commit-message
CACHE=.cache/plugins/cache/team/commit-message/1.0.0
for d in "$SRC" "$CACHE"; do
  mkdir -p "$d/.claude-plugin" "$d/skills/commit-message"
  cat > "$d/.claude-plugin/plugin.json" <<'JSON'
{
  "name": "commit-message",
  "version": "1.0.0",
  "description": "Write a git commit message for the staged changes."
}
JSON
  cat > "$d/skills/commit-message/SKILL.md" <<'MD'
---
name: commit-message
description: Write a git commit message for the staged changes. Use when the user asks for a commit message or to commit.
---

# Commit message

1. Read the staged diff with `git diff --cached`.
2. Write a summary line describing the change.
3. Add a body explaining what changed and why.
4. Show the message to the user.
MD
done
mkdir -p "$SRC/evals/basic/graders"
cat > "$SRC/evals/basic/prompt.md" <<'MD'
---
max_turns: 6
allowed_tools: [Read, Bash, Skill]
---

Write a commit message for what I staged.
MD
cat > "$SRC/evals/basic/graders/criteria.md" <<'MD'
---
type: llm
---

PASS if the reply contains a commit message whose first line describes the staged change.
FAIL if there is no commit message.
MD
cat > "$SRC/CHANGELOG.md" <<'MD'
# Changelog

## 1.0.0 — 2026-09-01

- First version.
MD
echo ".cache/" > .gitignore
git add -A && git commit -qm "commit-message plugin 1.0.0"
