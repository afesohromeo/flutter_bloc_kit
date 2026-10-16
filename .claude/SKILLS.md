# Agent Skills (installed locally, not committed)

The kit's `CLAUDE.md` refers to agent skills in `.claude/skills/`. They are **third-party content** without licence files in our copies, so they are **not committed** (see `.gitignore`); install them in each project.

| Folder | Skills | Source |
|--------|--------|--------|
| `.claude/skills/superpowers/` | brainstorming, writing-plans, executing-plans, subagent-driven-development, test-driven-development, systematic-debugging, verification-before-completion, requesting/receiving-code-review, using-git-worktrees, finishing-a-development-branch, dispatching-parallel-agents, writing-skills, using-superpowers | [obra/superpowers](https://github.com/obra/superpowers) |
| `.claude/skills/flutter/` | Flutter architecture, responsive layout, layout fixes, widget/integration tests, widget previews, JSON, routing, localization, http | [flutter/skills](https://github.com/flutter/skills) (Flutter team) |
| `.claude/skills/stitch/` | stitch-design, taste-design, design-md, enhance-prompt, stitch-loop, react-components, shadcn-ui, remotion | [google-labs-code/stitch-skills](https://github.com/google-labs-code/stitch-skills) |
| `.claude/skills/flutter-bloc-*` | feature-workflow, api-errors, serverpod, review: the kit's standards as tested agent skills (MIT) | [afesohromeo/flutter-bloc-skills](https://github.com/afesohromeo/flutter-bloc-skills): `npx skills add afesohromeo/flutter-bloc-skills` |
| `.claude/skills/serverpod-*`, `relic-*` | 28 Serverpod and Relic skills (start with `serverpod-overview`) | Installed by `serverpod create --ide claude` in Serverpod projects (`_standards/14` §0.4) |

## Setup in a new project
1. Copy the skills folders from the latest project (or reinstall them from their sources) into `.claude/skills/`.
2. `.claude/knowledge/` (skill overviews) is optional and also local.
3. Register the MCP servers for the project folder (they live in your local Claude Code config, not in the repo):
   - **dart:** on Windows `dart` is a `.bat`, so register it through `cmd`:
     `claude mcp add-json dart '{"type":"stdio","command":"cmd","args":["/c","dart","mcp-server"]}' --scope local`
   - **stitch:** `claude mcp add-json stitch '{"type":"http","url":"https://stitch.googleapis.com/mcp","headers":{"X-Goog-Api-Key":"<key>"}}' --scope local` (never commit the key)
   - **serverpod** (Serverpod projects only): in the gitignored `.mcp.json`, by full path to `serverpod.bat` on Windows; see `_standards/14` §0.4. Its tools work only while the developer runs `serverpod start`.
4. Check with `claude mcp list`.

## Precedence
Where a skill contradicts `_standards/` (e.g. the Flutter architecture skill teaches MVVM/ViewModels), **`_standards/` wins**. Known conflicts are listed in `CLAUDE.md`.
