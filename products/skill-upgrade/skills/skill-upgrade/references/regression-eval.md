# Regression eval

One case per fixed miss. It must fail on the old skill and pass on the new one.

## Layout

Use the repository's existing eval layout. If it has none, use the Claude Code plugin-eval layout at the plugin root:

```
evals/<case-name>/
  prompt.md           frontmatter: max_turns, allowed_tools; body: the request
  graders/<check>.md  one check per file
  case.yaml           only when the case needs files: context.scaffold_script: fixture.sh
  fixture.sh          creates the smallest set of files the request needs
```

## Prompt

- Start from the real request in this session. Remove secrets, personal data, customer names and private paths; keep the wording that caused the miss.
- Don't name the skill unless the miss was about invoking it by name.
- Grant only the tools the case needs. Cases without Bash run on any OS.

## Graders by miss

| Miss | Grader frontmatter |
| --- | --- |
| didn't trigger | `type: tool_used`, `tool: Skill`, `input_match` on the skill name |
| triggered wrongly | the same on the wrong-trigger request, plus `min: 0`, `max: 0`, `arm: both` |
| wrong file content | `type: regex`, `target: { source: file, path: <file> }`, `pattern` |
| touched a file it shouldn't | `type: tool_used`, `tool: Edit` or `Write`, `input_match` on that path, `max: 0` |
| read too much | `type: tool_used`, `tool: Read`, `max: <n>` |
| reply too long or wrong shape | `type: llm`, body with one concrete `PASS if …` line and one `FAIL if …` line |

## Running

From the plugin root: `claude plugin eval . --scaffold --allow-tools <tools> --no-publish`. Run it only when the user asks; otherwise report "evals not run". Record results the way the repository already does (a factory workshop: `factory.mjs report <package>`).
