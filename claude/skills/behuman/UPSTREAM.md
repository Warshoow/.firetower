# Upstream tracking

This skill merges two sources. One of them is a live repository that keeps shipping new patterns, so this file records what it was merged from and how to check for drift.

```
UPSTREAM_REPO=blader/humanizer
UPSTREAM_PINNED_VERSION=2.11.2
UPSTREAM_PINNED_PATTERN_COUNT=35
MERGED_ON=2026-09-05
```

The lines above are parsed by `scripts/check-upstream.sh`. Keep the format exactly as it is, and update the values after every catch-up merge.

## How to check

```bash
bash scripts/check-upstream.sh          # report drift, list new pattern titles
bash scripts/check-upstream.sh --show   # also print the full text of the new patterns
bash scripts/check-upstream.sh --pin    # move the pin, after the merge is done
```

It fetches the upstream `SKILL.md` from `raw.githubusercontent.com`, reads `metadata.version` and the number of numbered patterns, and compares both against the pinned values.

The first two modes only read. `--pin` is the only mode that writes, it touches nothing but the three pinned values in this file, and it asks for confirmation first. It does not merge anything, so running it before the catalog is actually updated makes the skill claim coverage it does not have.

The merge itself stays manual on purpose. Deciding whether a new pattern belongs in the always-loaded kill list or only in the catalog, and whether it needs a French counterpart, is a judgement call. A script that guessed would produce exactly the kind of filler this skill exists to remove.

Run it when the user asks whether the skill is current, or roughly every couple of months. The upstream repo shipped versions 2.4 through 2.11 over a few months, so drift is the normal state rather than the exception.

## How to catch up

1. Run the script. If it reports new patterns, it prints their numbers and titles.
2. Fetch the upstream file and read the new sections:
   `curl -sL https://raw.githubusercontent.com/blader/humanizer/main/SKILL.md`
3. For each new pattern, add a section to `references/pattern-catalog.md` under the same number. Numbering alignment with upstream is the whole point, so never renumber 1 to 35 and never reuse an upstream number for a BeHuman addition.
4. If the pattern is common enough to matter while drafting, add a one-line entry to the kill list in `SKILL.md`. If it only matters when editing, leave it in the catalog.
5. Check whether it needs a French counterpart in `references/francais.md`.
6. Update the three pinned values above with `--pin`, then bump `metadata.version` in `SKILL.md`.

## What this skill changed relative to upstream

Recorded so a future catch-up merge does not silently undo a deliberate decision.

**Numbering.** Upstream patterns keep their numbers 1 to 35. BeHuman additions use B1 to B7 so the two sets never collide.

**Dash rule (14).** Upstream bans em and en dashes outright in the final rewrite. Here the ban applies in editing mode only. In writing mode it becomes a density budget, because a blanket ban degrades sentences where a dash is correct. A writing sample still overrides both, as upstream specifies. French usage is carved out in `references/francais.md`.

**Activation.** Upstream is invoked on demand, on a text the user supplies. This skill is also active by default while drafting, which is what the original BeHuman skill was for. Code, technical reference, and legal text are excluded in both modes.

**Anti-invention guardrail.** Kept from upstream and promoted to the top of `SKILL.md`, because the original BeHuman skill lacked it and its rewrite drills demonstrated fabrication: they replaced vague claims with invented numbers. Those drills were rewritten so that every "after" only cuts or reorganizes.

**Hyphenation (26).** Kept, but downgraded to a weak signal that should not be applied alone or against a house style.

**Additions not in upstream.** B1 generic smoothing, B2 formula openers, B3 compulsive summaries, B4 piled transitions, B5 list-itis and the essay skeleton, B6 placeholders and template scaffolding, B7 typographic and link debris. Plus the whole of `references/francais.md`, which has no upstream equivalent.

**Dropped from upstream.** Nothing. All 35 patterns are present.

## Licence

Upstream `blader/humanizer` is MIT. This merge keeps the MIT licence and the attribution to Wikipedia's "Signs of AI writing" and WikiProject AI Cleanup, who are the source of both pattern sets.
