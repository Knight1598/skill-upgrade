# Skill Registry

The Gate searches this file before anything is built: `factory.mjs search "<need>"`.
**Skills** is generated from each package's `spec.yaml` by `factory.mjs registry`; edit specs, not that table. The Gate appends to the other sections by hand.

## Skills

<!-- BEGIN GENERATED -->
| name | version | status | tier | release | problem | delta | triggers | path |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| skill-upgrade | 0.1.0 | beta | standard | internal | When a skill underperforms, the lesson stays in the chat; asked to fix it, agents edit the installed cache copy that updates overwrite, rewrite the whole skill, or guess at problems nobody observed. | Picks the skill that just ran, lists concrete misses from that run, edits its real source with one minimal change per miss, adds a regression eval, bumps the version, and reports. | upgrade the skill I just used; improve that skill; the skill did badly; make the last skill better; อัพเกรดสกิล; ปรับสกิลที่เพิ่งใช้; สกิลเมื่อกี้ทำงานไม่ดี | products/skill-upgrade/skills/skill-upgrade |
<!-- END GENERATED -->

## External

Skills built elsewhere that the Gate must consider before creating.

| name | source | covers | notes |
| --- | --- | --- | --- |
| factory | github.com/Knight1598/factory-skill-Claude-Code (plugin) | gate, spec, build, lint, eval and release a new skill; EXTEND an existing one from a stated idea | starts from an idea, not from a finished run; skill-upgrade hands a purpose change to it |
| plain2dev | github.com/Knight1598/plain2dev (plugin) | turn a plain Thai or English request into a scoped, testable developer spec | a frequent upgrade target, not an overlap |
| skill-creator | Anthropic skills plugin | general skill authoring, evals, benchmark loop, description tuning | starts from a described goal; does not mine the last run or find the editable source behind a plugin cache |

## Planned

Accepted ideas not built yet. Build from here instead of re-gating.

| name | covers | notes |
| --- | --- | --- |

## Stacks

COMPOSE results: existing skills used in sequence instead of a new skill.

| stack | skills | use for |
| --- | --- | --- |

## Rules

REJECT results: one-line instructions that replace a skill. Paste into AGENTS.md or CLAUDE.md where needed.

| rule | replaces idea |
| --- | --- |
