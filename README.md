# skill-upgrade

A skill for Claude Code and Codex that upgrades the skill you just used, based on what actually went wrong when it ran.

```
/plain2dev:plain2dev เพิ่มหน้าเบิกของ        ← a skill runs; you have to correct it twice
/skill-upgrade:skill-upgrade                 ← turn those corrections into a better plain2dev
```

> **ภาษาไทยโดยย่อ:** ใช้สกิลไหนแล้วมันทำงานไม่ดี (ต้องแก้ซ้ำ ข้ามขั้นตอน อ่านไฟล์เยอะเกิน ตอบยาวเกิน หรือไม่ทำงานตอนที่ควรทำ) ให้พิมพ์ `/skill-upgrade:skill-upgrade` ต่อท้ายทันที มันจะดูว่าในรอบนั้นพลาดตรงไหน แล้วแก้ที่ **ซอร์สจริง** ของสกิลนั้น ไม่ใช่สำเนาใน plugin cache ที่จะถูกทับตอนอัพเดต โดยแก้เฉพาะจุดที่พลาด จุดละหนึ่งอย่าง เพิ่ม eval กันพลาดซ้ำ เพิ่มเวอร์ชัน แล้ว commit ให้ ถ้าไม่เห็นว่าพลาดตรงไหน มันจะถามก่อนหนึ่งคำถาม ไม่เดาเอง

## What it does

1. Picks the target: the skill you name, or the last skill that ran in this session.
2. Lists concrete misses from that run: your corrections, skipped or missing steps, failed checks, wasted reads, wrong triggering. With no visible miss, it asks one question instead of guessing.
3. Finds the skill's real source. For a plugin, that is the repository behind the marketplace, not `~/.claude/plugins/cache/...`, which updates overwrite.
4. Makes one minimal edit per miss and keeps the rest of the skill as it was. A fix that would change the skill's purpose becomes a proposal for a new skill (build it with [factory](https://github.com/Knight1598/factory-skill-Claude-Code)).
5. Adds one regression eval per fixed miss, bumps the version and CHANGELOG, and runs the repository's own lint.
6. Commits. It pushes only when you allowed pushing in the session and the remote is yours. It reports in 8 lines or fewer.

## Install

| Agent | How | Invoke |
| --- | --- | --- |
| Claude Code, plugin | `/plugin marketplace add Knight1598/skill-upgrade`, then `/plugin install skill-upgrade@skill-upgrade` | `/skill-upgrade:skill-upgrade`, or say "upgrade the skill I just used" |
| Claude Code, project or personal | copy `products/skill-upgrade/skills/skill-upgrade/` to `.claude/skills/skill-upgrade/` or `~/.claude/skills/skill-upgrade/` | `/skill-upgrade` |
| Codex | copy `products/skill-upgrade/skills/skill-upgrade/` to `.agents/skills/skill-upgrade/` | `$skill-upgrade` |

Start a new session after installing.

## Examples

- After `/plain2dev:plain2dev` asked three questions the project files already answered: "อัพเกรดสกิลเมื่อกี้ ไม่ต้องถามสิ่งที่อ่านจากโค้ดได้". It clones or opens `Knight1598/plain2dev`, adds one line to the step that asks questions, adds an eval built from your request, bumps 0.2.0 → 0.3.0, and commits.
- "Upgrade the skill I just used" in a session where no skill ran: it asks which skill and what it did badly, and edits nothing.

## Limits

- It only sees the current session. It does not read old transcripts; describe older problems yourself.
- It does not edit built-in skills or repositories you can't write to. It leaves a `.patch` file to send upstream.
- It writes behavior evals but runs them only when asked (`claude plugin eval`).

## Layout

This repository is a [factory](https://github.com/Knight1598/factory-skill-Claude-Code) workshop.

- `products/skill-upgrade/` — the plugin: `skills/skill-upgrade/` (SKILL.md, spec.yaml, references), `evals/` (4 cases), CHANGELOG.
- `registry/` — REGISTRY.md (skills and neighbors the gate checks) and LEDGER.md (build decisions).
- `.claude-plugin/marketplace.json` — makes the repository installable as a marketplace.

## Evidence

Lint passes with no warnings. Behavior evals are in `products/skill-upgrade/evals/`. No run has been recorded yet, so nothing about the skill's effect is measured.
