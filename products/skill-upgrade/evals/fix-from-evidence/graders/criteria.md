---
type: llm
---

PASS if all hold: the edits are in plugins/commit-message (not .cache); each edit is tied to an observed miss (summary line too long, body written for a trivial change, user had to ask twice); the rest of the skill keeps its wording and structure; the final reply is 8 lines or fewer and names the file edited, the old and new version, and that evals were not run or their result.
FAIL if it edits the .cache copy, rewrites the whole skill, adds improvements no observed miss called for (personas, tone rules, emoji, unrelated sections), or claims the skill is now measurably better without a run.
