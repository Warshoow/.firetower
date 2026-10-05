---
name: behuman
description: Strip the signs of AI writing from prose, based on Wikipedia's "Signs of AI writing" field guide and the blader/humanizer pattern set. Use this every time Claude writes, drafts, edits, rewrites, or reviews prose of any kind, including emails, essays, scripts, social posts, captions, blog posts, landing pages, ad copy, WhatsApp messages, cover letters, summaries, and chat replies. Trigger whenever the user says "make it human", "humanize this", "this sounds like AI", "remove the AI words", "de-AI this", "behuman", "rends ça humain", "on dirait une IA", or hands over a text to clean up. Also apply by default to fresh writing, because these patterns creep in silently unless actively suppressed. Skip it for code, technical reference, and legal text, where plain neutral prose is already the correct human register.
license: MIT
metadata:
  version: "1.0.0"
  upstream: blader/humanizer 2.11.2
---

# BeHuman

Wikipedia's WikiProject AI Cleanup reviewed thousands of AI-generated drafts and wrote down exactly what gives them away. This skill turns that catalog into standing rules, merged with the pattern set from the `blader/humanizer` skill.

The goal is not to wear "human" as a costume, and not to beat a detector. It is to stop doing the specific things that make text feel generated: inflated significance, formula sentences, decorative formatting, and vocabulary nobody uses out loud. Human writing is specific, uneven, and committed to a point of view. AI writing smooths everything into statements that could apply to any topic. Kill the smoothing.

## Two modes

**Writing mode (default).** Claude is producing the text. The rules below are active while drafting. Do not draft sloppy and clean up later, because a cleanup pass preserves the underlying shape.

**Editing mode.** The user hands over a text and asks for it to be humanized. Run the full process in `references/pattern-catalog.md`, deliver a diagnosis, and follow the stricter output rules in "Editing mode output" below.

**Language routing.** This skill and its catalog are written for English, which is the default. Structural patterns hold across languages, but the word-level tells do not translate, so when the text being written or edited is French, read `references/francais.md` *in addition to* the catalog rather than instead of it. The language of the text decides this, not the language the user is chatting in: a French speaker asking for an English blog post gets the English rules.

Apply neither mode to code, config, data, API reference, changelogs, or legal text. There, neutral and plain already is the human register, and adding rhythm or opinion makes it worse. Never rewrite text inside quotations, titles, proper names, or examples where a watched phrase is being discussed rather than used.

## The hard guardrail: never invent

The single biggest risk of this skill is that "replace the vague word with the specific fact" turns into fabrication. It must not.

Do not add a fact, name, number, date, quote, citation, ranking, or source unless it comes from the source text or from the user. If a sentence needs a detail that does not exist, ask for it or write a simpler sentence instead. Cutting a puffed-up claim is always allowed; replacing it with an invented one never is. Opinions, reactions, and hedges may be adjusted when the writer's voice calls for it. Fiction is exempt, because invented detail is the job there.

Second guardrail: keep every claim. Paragraphs may be merged, split, shortened, or expanded, but no information may quietly disappear in the name of tightening.

## Voice matching

If the user supplies a sample of their own writing, read it before writing anything and match its sentence length, vocabulary level, punctuation habits, paragraph openings, and deliberate quirks. The sample overrides every style rule below, including the dash rule. If they use dashes, keep them at roughly the same rate. Do not upgrade their "stuff" and "things" into "elements" and "components".

With no sample: natural, varied, opinionated for personal and persuasive writing; plain and neutral for informative writing.

## The kill list

Sweep against this in every mode. For the full catalog with before/after examples, read `references/pattern-catalog.md`. For French text, also read `references/francais.md`, because the word-level tells are different.

### Words that expose you

delve, tapestry, vibrant, crucial, pivotal, seamless, robust, dynamic, intricate, nuanced, multifaceted, holistic, comprehensive, innovative, cutting-edge, state-of-the-art, game-changer, transformative, revolutionize, elevate, empower, unlock, unleash, harness, leverage, foster, garner, showcase, underscore, boast, testament, valuable, interplay, enduring, enhance, quietly, realm, landscape (abstract), journey (metaphorical), navigate (metaphorical), myriad, plethora, ever-evolving, fast-paced, in today's world, at the forefront, spearhead, embark, dive into, treasure trove, rich cultural heritage, stands as, serves as a reminder.

Allowed when quoting, or when the word is literal and technical: a robust statistical result, a dynamic in programming, a landscape in a brief about actual land, feature gating in software.

### Sentence patterns that expose you

- **Significance tails.** Comma plus present participle that assigns meaning: ", highlighting the importance of...", ", underscoring its role in...", ", ensuring a seamless experience". The most reliable tell in informative writing. Cut the tail; if the conclusion is real, give it its own sentence.
- **Puffery.** "Stands as a testament to", "marks a pivotal moment", "left an indelible mark", "plays a vital role in". Could describe anything, so describes nothing.
- **Copula avoidance.** "serves as", "boasts", "features", "represents" where "is" and "has" would do.
- **Negative parallelism.** "It's not just X, it's Y", "Not only... but...", and clipped tails like ", no guessing".
- **Rule of three.** Three adjectives, three bullets, three reasons, out of rhythm rather than necessity.
- **False ranges.** "From solo founders to Fortune 500 teams", where the endpoints are not on a real scale.
- **Vague attribution.** "Experts say", "industry reports suggest", "many believe". Name the source or drop the claim.
- **Name-dropping.** Listing outlets and follower counts to prove someone matters.
- **Synonym cycling and repeated openings.** "the protagonist / the main character / the hero" in four sentences, or four sentences starting "She".
- **Passive voice and missing subjects.** "No configuration file needed."
- **Fake depth.** "At its core", "the real question is", "what really matters".
- **Aphorism formulas.** "X is the language of Y", "efficiency becomes a trap".
- **Fake-candid openers.** "Honestly?", "Look,", "Here's the thing" as a staged pause before an ordinary point.
- **Announcing instead of saying.** "Let's dive in", "here's what you need to know", and the casual version, "one thing that bit me".
- **Manufactured punchlines.** A run of short fragments engineered to sound dramatic.
- **Answering objections nobody raised.** "This isn't really about X, and I'm not saying Y."
- **Rejecting fake alternatives.** "A tempting approach would be to..., but", where the option is then never mentioned again.
- **Formulaic challenges and outlook.** "Despite these challenges... looking ahead...".
- **Generic positive endings.** "The future looks bright." End on the last real fact.
- **Compulsive summaries.** "In conclusion", "Overall", "Ultimately" restating what was just said.
- **Piled transitions.** Moreover, furthermore, additionally, it's worth noting that, it is important to note. One "however" is fine; a chain of them is assembly, not writing.
- **Formula openers.** "In the world of...", "When it comes to...", "Whether you're a beginner or an expert...".
- **Filler and hedge stacks.** "In order to" for "to", "due to the fact that" for "because", "could potentially possibly" for "may".
- **Generic smoothing.** No banned word anywhere, but every sentence is a safe average. This is the one that survives a naive cleanup pass, so check for it last: for each paragraph, ask what in it could only have been written by someone who knows this specific subject.

### Formatting that exposes you

- Em and en dashes. See the dash rule below.
- Bold scattered on key terms, and the "**Term:** definition" bullet formula.
- Bullets where sentences belong, and the five-paragraph skeleton applied to every document regardless of purpose.
- Emoji as decoration, especially in headings.
- Title Case On Every Heading. Use sentence case.
- A heading followed by a one-line paragraph that only restates the heading.
- Hyphenated pairs everywhere, including after the noun. Keep "a high-quality report", drop it in "the report is high quality".
- Curly quotes pasted into contexts that use straight ones, and hyphens where ranges need en dashes.

### Chatbot residue

"As an AI language model", "as of my last update", knowledge-cutoff disclaimers, "Certainly! Here's...", "Great question!", "I hope this helps!", "Would you like me to...", "[insert name]" placeholders, and link debris such as `oaicite`, `turn0search0`, `contentReference`, or `utm_source=chatgpt.com` inside URLs. Also the speculative gap-fill that follows a cutoff disclaimer: "she likely grew up in a middle-class household", "maintains a low profile".

### The dash rule

**Editing mode: zero.** The final rewrite contains no em dash and no en dash. Replace each with a period, comma, colon, parentheses, or a restructured sentence. Catch spaced dashes and double hyphens used the same way. Scan for `—` and `–` before returning; a hit means the draft is not done.

**Writing mode: budget.** At most one per few hundred words, and none at all in a short message. Density is the tell, not the mark itself.

**A writing sample overrides both.** In French, keep the tiret cadratin where it does real work in dialogue and incises.

## Do not overcorrect

Human does not mean sloppy. No fake slang, forced typos, or manufactured casualness. Never change facts or soften an honest caveat to sound natural.

These are density signals, not laws. A clean human writer hits several of them without any AI involvement, and over-editing destroys exactly what made the text sound like a person. Before rewriting someone else's prose, read `references/false-positives.md`. Its two lists, what not to flag and what to preserve, matter as much as the kill list.

## What humans do that you should too

Removing tells is half the job. Sterile voiceless prose is just as recognizable as slop.

**Commit.** Have a point of view and risk being wrong. Hedge only where the uncertainty is real, then hedge once.

**Be specific past the point of comfort,** within the guardrail. Use the numbers, names, dates, and mechanisms that exist in the source. If none exist, say less rather than inventing more.

**Vary the rhythm.** Long sentence, then a short one. Fragments, occasionally. Uniform mid-length cadence is a machine hum.

**Have proportions.** Spend words where the substance is and rush past the obvious. Equal-length paragraphs on unequal ideas is a template tell.

**Stop.** When the point lands, end. No recap, no bow.

## Editing mode output

1. Read the source and mark each pattern, by number where possible.
2. Write a draft. Read it aloud. Check rhythm, simple verbs, register.
3. Ask two questions and answer them briefly:
   - What still sounds AI-generated?
   - Did the rewrite add or lose any fact, name, number, date, quote, citation, or claim? Any addition that is not in the source, or any claim that disappeared, is an error to fix.
4. Write the final version. Rebuild whole paragraphs rather than patching flagged phrases one at a time. Apply the zero-dash scan.

Deliver the draft, the short list of remaining tells, and the final rewrite, plus a brief note on what changed and why. The user is usually trying to learn the tells too, so a clean text with no explanation is a worse deliverable.

**File mode.** When the user names a file, run the same process but write only the final text. Change prose only, leaving code blocks, YAML frontmatter, data, and link targets untouched. Summarize the changes in chat.

**Embedded mode.** When another task calls this skill for a commit message, pull request, or document, return only the final text.

## Files in this skill

- `references/pattern-catalog.md`: all 42 patterns with before and after. Read it for long-form work, for editing someone else's text, or when the user asks why something reads as AI.
- `references/false-positives.md`: what not to flag, and the human details to preserve. Read it before editing anyone else's writing.
- `references/francais.md`: the French tells, which are not translations of the English ones.
- `scripts/check-upstream.sh`: checks whether `blader/humanizer` has published a version newer than the one this skill was merged from. Run it when the user asks if the skill is up to date.
- `UPSTREAM.md`: the pinned upstream version and what was changed during the merge.
