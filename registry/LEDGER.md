# Factory Ledger

One row per factory run. The Gate adds the row; QA and Release update `stage`.
Stages: gated → qa-pass | qa-fail → released. Terminal: released, rejected, reused, composed, abandoned.
`/factory resume` continues the newest row whose stage is not terminal.

| id | date | idea | decision | target | stage | note |
| --- | --- | --- | --- | --- | --- | --- |
| F-0001 | 2026-09-25 | skill that upgrades the skill just used, from that run | CREATE | skill-upgrade | released | nearest, skill-creator, ignores run evidence and edits no source behind caches |
