# The BeHuman pattern catalog

42 patterns. Numbers 1 to 35 are aligned with `blader/humanizer` 2.11.2 so that upstream changes map onto this file one for one. Numbers B1 to B7 are BeHuman additions that upstream does not cover.

Both sets descend from [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing), maintained by WikiProject AI Cleanup after reviewing thousands of AI-generated drafts. Their framing matters: these are density signals, not proof. Humans do every one of these occasionally. AI does them constantly, together, by default. Remove the defaults.

Wikipedia's core observation: LLMs guess what comes next statistically, so the output drifts toward whatever is most likely across the widest range of cases. That drift is what every pattern below is a symptom of.

**Read before applying any of this:** the anti-invention guardrail in `SKILL.md`, and `false-positives.md`.

## Contents

- Content patterns: 1 to 6, B1
- Language and grammar: 7 to 13, B2, B3, B4
- Style and formatting: 14 to 19, B5, B7
- Chatbot residue: 20 to 22, B6
- Filler, hedging, and rhetoric: 23 to 35

---

## Content patterns

### 1. Inflated claims about importance and legacy

**Words to watch:** stands as, serves as, is a testament, a vital / crucial / pivotal / key role or moment, underscores its significance, reflects broader, symbolizing its enduring, setting the stage for, marks a shift, key turning point, evolving landscape, indelible mark, deeply rooted.

**Why it reads as AI:** models puff up whatever subject they are given, because agreeable importance is the statistically safe output. The same sentence could be pasted onto a bakery, a battery factory, or a Baroque composer.

**Fix:** replace the claim of importance with the evidence of importance that the source actually contains. If there is no evidence in the source, the sentence had no job. Delete it rather than inventing one.

Before: The Statistical Institute of Catalonia was officially established in 1989, marking a pivotal moment in the evolution of regional statistics in Spain.
After: The Statistical Institute of Catalonia was established in 1989, part of a wider decentralization of administrative functions in Spain.

### 2. Name-dropping to prove importance

**Words to watch:** independent coverage, national media outlets, written by a leading expert, active social media presence.

**Why it reads as AI:** the model lists prestigious outlets and follower counts as a substitute for saying what the person actually did or said.

**Fix:** keep the citation that carries information and cut the rest. Do not invent context to justify a shorter version.

Before: Her views have been cited in The New York Times, BBC, Financial Times, and The Hindu. She maintains an active social media presence with over 500,000 followers.
After: Her views have been cited in The New York Times and the BBC.

### 3. Shallow analysis with -ing phrases

**Words to watch:** highlighting, underscoring, emphasizing, ensuring, reflecting, symbolizing, contributing to, fostering, encompassing, showcasing, solidifying, cementing.

**Why it reads as AI:** it welds an unverified conclusion onto a verified fact so the two travel together. This is the single most reliable tell in informative writing.

**Fix:** cut the tail. If the conclusion is real and matters, give it its own sentence with its own support. Usually it evaporates on contact.

Before: The temple's palette of blue, green, and gold resonates with the region's natural beauty, symbolizing Texas bluebonnets, the Gulf of Mexico, and the diverse Texan landscapes, reflecting the community's deep connection to the land.
After: The temple is painted blue, green, and gold, colors meant to evoke Texas bluebonnets and the Gulf of Mexico.

### 4. Sales language

**Words to watch:** boasts a, vibrant, rich (figurative), profound, nestled, in the heart of, groundbreaking, renowned, breathtaking, must-visit, stunning, commitment to, natural beauty.

**Why it reads as AI:** travel-brochure varnish applied indiscriminately, even to topics where nobody asked for enthusiasm. It signals that no writer stood behind the words.

**Fix:** report, do not advertise. If this genuinely is marketing copy, sell with specifics and proof rather than varnish.

Before: Nestled within the breathtaking region of Gonder in Ethiopia, Alamata Raya Kobo stands as a vibrant town with a rich cultural heritage and stunning natural beauty.
After: Alamata Raya Kobo is a town in the Gonder region of Ethiopia.

### 5. Vague sources

**Words to watch:** industry reports, observers have cited, experts argue, some critics argue, several publications, it is widely regarded as.

**Why it reads as AI:** models generate the shape of a citation without the substance of one.

**Fix:** name the source when the source text provides one. Otherwise remove the claim. Never invent a source.

Before: Experts believe the Haolai River plays a crucial role in the regional ecosystem.
After: Researchers and conservationists study the Haolai River for its unusual characteristics.

### 6. Formulaic challenges and outlook sections

**Words to watch:** despite its success it faces several challenges, despite these challenges, Challenges and Legacy, Future Outlook, looking ahead.

**Why it reads as AI:** it is the default essay skeleton for any topic: intro, praise, obligatory balance, optimistic exit.

**Fix:** keep only the challenges the source names. Cut the horoscope-grade future talk.

Before: Despite its industrial prosperity, Korattur faces challenges typical of urban areas. Despite these challenges, Korattur continues to thrive as an integral part of Chennai's growth.
After: Korattur has recurring traffic congestion and water shortages.

### B1. Generic smoothing

**Looks like:** no banned word anywhere, but every sentence is a safe average. Specific facts round into general statements: "utilizes advanced technology to improve outcomes" instead of what the machine does, "received positive feedback" instead of who said what.

**Why it reads as AI:** statistical text regresses to the mean. Numbers, names, dates, mechanisms, and sensory observation are exactly what gets smoothed away, and they are also what makes writing trustworthy.

**Why it is listed separately:** it is the one pattern that survives a naive cleanup pass, because there is no phrase to search for. Check for it last, after the word-level fixes.

**Fix:** for every paragraph ask what in it could only have been written by someone who knows this specific subject. If the answer is nothing, go get details from the source or the user, or cut the paragraph. Do not manufacture the details.

---

## Language and grammar

### 7. Overused AI words

**High-frequency list:** actually, additionally, align with, crucial, delve, emphasizing, enduring, enhance, fostering, garner, gate / gated / gating (figurative only, keep real technical usage such as feature gating and CI quality gates), highlight (verb), interplay, intricate, key (adjective), landscape (abstract), pivotal, quietly, showcase, tapestry (abstract), testament, underscore (verb), valuable, vibrant.

**Why it reads as AI:** these words appear far above human baseline in post-2023 text, and they co-occur.

**Replacements:** delve becomes look at or examine, or just do it. Leverage, harness, unlock, unleash, and empower become use. Foster and cultivate become the real verb: build, run, teach, fund. Garner becomes get, win, earn. Showcase and boast become has or shows. Underscore and highlight are usually deletions. Testament becomes evidence, or the sentence goes. Elevate and revolutionize become a statement of what changed and by how much. Comprehensive, holistic, and multifaceted become a list of what it actually covers. Intricate and nuanced become one actual nuance, explained. Myriad and plethora become many, or the number.

Before: An enduring testament to Italian colonial influence is the widespread adoption of pasta in the local culinary landscape, showcasing how these dishes have integrated into the traditional diet.
After: Pasta dishes, introduced during Italian colonization, remain common, especially in the south.

### 8. Avoiding is and are

**Words to watch:** serves as, stands as, marks, represents, boasts, features, offers.

**Why it reads as AI:** models substitute elaborate constructions for simple copulas, which inflates length without adding information.

Before: Gallery 825 serves as LAAA's exhibition space and boasts over 3,000 square feet.
After: Gallery 825 is LAAA's exhibition space. It has 3,000 square feet.

### 9. Not X but Y, and clipped negative endings

**Why it reads as AI:** manufactured profundity. The construction fakes a reveal without revealing anything. The clipped variant tacks a fragment onto a sentence instead of writing a real clause.

Before: It's not merely a song, it's a statement.
After: The heavy beat adds to the aggressive tone.

Before: The options come from the selected item, no guessing.
After: The options come from the selected item without forcing the user to guess.

### 10. Forced groups of three

**Why it reads as AI:** three is the rhythm of least resistance, so models pad thin content or trim rich content to hit it. Once you notice the drumbeat you cannot unhear it.

**Fix:** match the count to reality. Two items, five items, one item. An adjective added for rhythm rather than truth goes.

Before: Attendees can expect innovation, inspiration, and industry insights.
After: The event includes talks and panels, with time for informal networking between sessions.

### 11. Changing names and repeating sentence openings

**Why it reads as AI:** the model handles repetition by rule rather than by ear. It renames the same subject to avoid repeating a word, or starts several consecutive sentences with the same subject.

**Fix:** use one clear name throughout. For repeated openings, merge the sentences or start with the action. Do not ban the repeated word itself, and do not touch repetition that is deliberate rhythm.

Before: The protagonist faces many challenges. The main character must overcome obstacles. The hero returns home.
After: The protagonist faces many challenges but eventually triumphs and returns home.

Before: She noted the door. She noted the lock on it. She filed both away.
After: She noted the door and its lock, then filed both away.

### 12. False from X to Y ranges

**Why it reads as AI:** the structure implies a measured spectrum, but the endpoints are two loosely related things dressed up to sound comprehensive.

Before: Our journey has taken us from the singularity of the Big Bang to the enigmatic dance of dark matter.
After: The book covers the Big Bang, star formation, and current theories about dark matter.

### 13. Passive voice and missing subjects

**Why it reads as AI:** the actor gets hidden or the subject dropped entirely. Rewrite when active voice makes the sentence clearer, not as a blanket rule, since the passive is correct when the actor is unknown or irrelevant.

Before: No configuration file needed. The results are preserved automatically.
After: You do not need a configuration file. The system preserves the results automatically.

### B2. Formula openers and fake audience awareness

**Looks like:** "In the world of...", "In today's fast-paced digital landscape...", "When it comes to...", "Whether you're a seasoned professional or just starting out...", "Have you ever wondered...?"

**Why it reads as AI:** throat-clearing templates that delay the subject. The "whether you're X or Y" move also fakes an audience knowledge the writer does not have, and it is usually a false range (12) in disguise.

**Fix:** the first sentence states the subject or the claim. Start where the interesting part starts.

### B3. Compulsive summaries

**Looks like:** "In conclusion", "In summary", "Overall", "Ultimately", followed by a restatement of the preceding paragraphs. Often appears even in a five-sentence answer.

**Why it reads as AI:** chat models were trained to wrap up. Human writers stop when the point lands. Distinct from 25, which is about vague optimism rather than repetition.

**Fix:** end on the strongest concrete point. If a piece is genuinely long enough to need a recap, summarize with new compression rather than repetition.

### B4. Piled transitions

**Looks like:** moreover, furthermore, additionally, consequently, notably, in addition, that being said, at the end of the day, deployed at the head of most sentences.

**Why it reads as AI:** joints installed where none were needed. Prose whose every sentence opens with a connective reads as assembled rather than written.

**Fix:** delete the transition and read the two sentences. Nine times in ten they connect fine. Order the ideas so they flow instead of caulking the gaps. One "however" in two pages is not a tell, so treat this as a density check.

---

## Style and formatting

### 14. Em and en dashes

**Rule in editing mode:** the final rewrite contains no em dash and no en dash. Replace each, in rough order of preference, with a period, a comma, a colon, parentheses, or a restructured sentence. Catch spaced dashes and double hyphens used the same way. Scan for the characters before returning.

**Rule in writing mode:** a density budget instead. At most one per few hundred words, none in a short message.

**A writing sample overrides both.** If the writer uses dashes, match their rate. In French, keep the tiret cadratin where it does real work in dialogue and incises.

**Why it reads as AI:** the most infamous tell. Not because dashes are wrong, writers have loved them for centuries, but because models deploy them at a density and uniformity no human sustains.

Before: The term is promoted by Dutch institutions—not by the people themselves—yet this mislabeling continues—even in official documents.
After: The term is promoted by Dutch institutions, not by the people themselves, yet the mislabeling continues in official documents.

### 15. Too much bold text

**Why it reads as AI:** formatting used as a costume for organization. The uniformity functions as a watermark.

**Fix:** bold almost nothing in prose.

Before: It blends **OKRs**, **KPIs**, and tools such as the **Business Model Canvas**.
After: It blends OKRs, KPIs, and tools like the Business Model Canvas.

### 16. Lists with bold mini-headings

**Looks like:** every bullet is "**Concept:** one sentence about the concept."

Before:
- **Performance:** Performance has been enhanced through optimized algorithms.
- **Security:** Security has been strengthened with end-to-end encryption.

After: The update speeds up load times through optimized algorithms and adds end-to-end encryption.

### 17. Title case in headings

**Fix:** sentence case, unless the destination's style guide says otherwise.

Before: ## Strategic Negotiations And Global Partnerships
After: ## Strategic negotiations and global partnerships

### 18. Emojis

**Looks like:** a rocket in the heading, a checkmark prefixing every list item, a lightbulb marking every tip.

**Fix:** default to zero. In casual channels where emoji are native, use them the way that audience does, which is sparingly and specifically.

### 19. Curly quotation marks

**Why it reads as AI:** chatbot output ships with typographic punctuation, and pasting it unedited into code, wikis, or plain-text contexts leaves fingerprints. On its own this proves nothing, since Word, Google Docs, and macOS auto-curl by default. It counts only stacked with other tells.

**Fix:** match the destination, one style applied consistently.

### B5. List-itis and the rigid essay skeleton

**Looks like:** bullets where flowing sentences belong, three-item groups nested under bolded headers, entire answers with no connected prose. At document scale: every piece arrives as intro defining the topic, three balanced body sections with parallel headers, conclusion restating the intro.

**Why it reads as AI:** lists are cheap structure. They let a model skip the work of connecting ideas, which is where actual thinking shows. The five-paragraph essay is the comfort shape for the same reason.

**Fix:** if it reads fine as a sentence, it is a sentence. Save lists for genuinely enumerable content: steps, specs, inventories. For structure, ask what the reader needs first and build around that. A memo front-loads the decision, a tutorial follows the task, a story follows the tension. Delete any section that exists to complete a pattern rather than to inform.

### B7. Typographic and link debris

**Looks like:** hyphens where a range needs an en dash (2019-2024 rather than 2019–2024), inconsistent quote styles inside one document, spaced hyphens standing in for dashes. In URLs: `oaicite`, `turn0search0`, `contentReference`, `utm_source=chatgpt.com`. In citations: DOIs and ISBNs that resolve to nothing, or sources that do not say what is claimed.

**Fix:** verify every reference or remove it. An unverified citation is worse than none. Note the interaction with 14: the dash rule removes em and en dashes from prose, but a numeric range still needs its en dash, so strip ranges from that scan.

---

## Chatbot residue

Any one of these in a deliverable means it was pasted without a read-through.

### 20. Chatbot text left in the answer

**Words to watch:** I hope this helps, Of course!, Certainly!, You're absolutely right, Would you like..., Want me to...?, Should I continue?, let me know, here is a...

These belong to the conversation layer, never to the document.

### 21. Knowledge-limit disclaimers and speculative gap-filling

**Words to watch:** as of my last training update, while specific details are limited, based on available information, not publicly available, maintains a low profile, keeps personal details private, likely grew up, it is believed that.

Two related tells. The model leaves a hard cutoff disclaimer in the text, or, unable to find a source, writes a paragraph about not finding one and then invents plausible filler to cover the gap. For a private person the guess lands on the same stock phrases every time.

**Fix:** state what the source does not show, or cut the sentence. Never dress a guess as a fact.

Before: Information about her early life is not publicly available, suggesting she maintains a low profile. She likely grew up in a middle-class household, which shaped her later interest in education reform.
After: Her early life is not documented in the available sources. Or omit the section.

### 22. Overly agreeable tone

Before: Great question! You're absolutely right that this is a complex topic.
After: The economic factors you mentioned are relevant here.

In the conversation layer as well as the document, drop the flattery. Answer, do not applaud.

### B6. Placeholders and template scaffolding

**Looks like:** "[Insert company name]", "[Your Name]", "[mention specific achievement]", "Note: this is a fictional example", visible remnants of the prompt, or a leftover refusal.

**Fix:** fill it or ask for it. Fill-in-the-blank scaffolding shipped as a finished product is the clearest possible sign nobody read the output.

---

## Filler, hedging, and rhetoric

### 23. Filler phrases

- "In order to achieve this goal" becomes "To achieve this"
- "Due to the fact that it was raining" becomes "Because it was raining"
- "At this point in time" becomes "Now"
- "In the event that you need help" becomes "If you need help"
- "The system has the ability to process" becomes "The system can process"
- "It is important to note that the data shows" becomes "The data shows"

### 24. Too many qualifiers

**Phrases to watch:** to be fair, it's also possible, could potentially, might arguably, in some cases it may.

Repeated editing stacks one qualifier on another until every claim sounds uncertain. Keep a qualifier when the source supports it and the meaning needs it. Remove caveats that only repair an earlier overstatement.

Before: It could potentially possibly be argued that the policy might have some effect on outcomes.
After: The policy may affect outcomes.

### 25. Generic positive endings

Before: The future looks bright. Exciting times lie ahead as they continue their journey toward excellence.
After: cut the paragraph and end on the last concrete fact. If the source states real plans, use those.

### 26. Too many hyphenated word pairs

**Words to watch:** third-party, cross-functional, client-facing, data-driven, decision-making, well-known, high-quality, real-time, long-term, end-to-end.

Models hyphenate these uniformly, including in predicate position. Humans hyphenate attributively and often drop it after the noun.

Before: The team is cross-functional, the report is high-quality, and the methodology is data-driven.
After: The team is cross functional, the report is high quality, and the methodology is data driven.

Keep "a high-quality report". This is the weakest signal in the catalog, so apply it only alongside others, and never against a house style that mandates the hyphen.

### 27. Pretending to reveal a deeper truth

**Phrases to watch:** the real question is, at its core, in reality, what really matters, fundamentally, the deeper issue, the heart of the matter.

The sentence that follows usually restates an ordinary point with extra ceremony.

Before: At its core, what really matters is organizational readiness.
After: That mostly depends on whether the organization is ready to change its habits.

### 28. Announcing the next point

**Phrases to watch:** let's dive in, let's explore, let's break this down, here's what you need to know, without further ado, heads up, quick note.

The casual register does this too, with lines like "one thing that bit me hard, so pay attention to this part". Remove the announcement, not just its formal tone.

Before: Let's dive into how caching works in Next.js. Here's what you need to know.
After: Next.js caches data at multiple layers, including request memoization, the data cache, and the router cache.

### 29. A heading repeated in the first sentence

A heading followed by a one-line paragraph that only restates the heading, as a rhetorical warm-up before the real content. Delete the restatement.

### 30. Writing about the previous version

Documentation and comments should describe current behavior. Mention the previous version only in changelogs, release notes, and migration guides.

Before: This function was added to replace the previous approach of iterating through all items, which caused O(n²) performance.
After: This function uses a hash map for O(1) lookups, avoiding the O(n²) cost of naive iteration.

### 31. Forced punchlines and dramatic fragments

Every sentence engineered to land like a quotable closer, then short declarative fragments stacked to manufacture drama. One short sentence for emphasis is fine. A run of them sounds engineered.

Before: Then AlphaEvolve arrived. It had no preference for symmetry. No aesthetic prior. No nostalgia for human taste.
After: AlphaEvolve changed the search because it did not favor symmetry or human-looking designs.

### 32. Formulaic sayings

**Patterns to watch:** X is the Y of Z, X becomes a trap, X is not a tool but a mirror, the language of, the currency of, the architecture of.

Ordinary claims turned into reusable aphorisms that sound profound without adding precision.

Before: Symmetry is the language of trust.
After: Symmetric layouts often feel more predictable to users.

### 33. Fake-candid openings

**Phrases to watch:** Honestly?, Look, Here's the thing, The thing is, Let's be honest, Real talk, used as standalone hooks.

The tell is the theatrical pause and reveal: a one-word question or aside, then the "real" answer. A person being honest usually just says the thing. Mid-sentence "honestly" and "look" are ordinary and not a tell.

Before: Is it worth the price? Honestly? It depends on how often you'll use it.
After: Whether it's worth the price depends on how often you'll use it.

### 34. Answering objections no one raised

**Phrases to watch:** this isn't really about, I'm not saying, to be clear, don't get me wrong, this is not to say, you could argue this differently but, some might say... but.

Watch for an unattributed statement about what the writer does not mean, especially when the topic appears nowhere else in the text. A direct claim such as "the API is not thread-safe" is not this pattern.

**Fix:** remove only the unsupported defense. Keep an objection when the text names its source or answers it in full.

Before: This isn't mainly about prompt length, and I'm not arguing that documentation doesn't matter. The issue is whether the agent can use the instruction when it acts.
After: The issue is whether the agent can use the instruction when it acts.

### 35. Rejecting fake alternatives

**Phrases to watch:** a tempting approach would be, one might be tempted to, an obvious approach would be, you might think... but, it would be easy to just.

An option no reader would consider, rejected in a clause and never mentioned again. Usually an old drafting idea left in the final text.

Before: Session tokens rotate every 24 hours. A tempting approach would be to rotate them by restarting the auth service on a cron job, but that would drop every active session. Rotation happens in place.
After: Session tokens rotate every 24 hours, in place, and clients refresh transparently.

One rejected option may be legitimate. Several short unrelated rejections are the stronger signal. Keep real alternatives in a design document or tutorial.

---

## Rewrite drills

Every "after" below only removes or reorganizes. None adds a fact that was not in the "before". That constraint is the drill.

**Puffery plus significance tail**
Before: The annual hackathon stands as a testament to the community's innovative spirit, fostering collaboration and underscoring the institute's pivotal role in the tech landscape.
After: The institute runs a hackathon every year.
If the source also says 300 students entered and four teams got incubator offers, use those numbers. If it does not, the short version is the honest one.

**Negative parallelism plus vocabulary**
Before: This isn't just another course. It's a transformative journey that empowers you to unlock your potential in the ever-evolving world of AI.
After: The course runs twelve weeks and you build four AI products.
The twelve weeks and four products must come from the course description. Without them: "It's a twelve-week course" or, with nothing at all, "It's an AI course."

**False range plus vague attribution**
Before: From startups to Fortune 500s, experts agree the platform is a game-changer.
After: cut the sentence. There is no verifiable claim left once the range and the unnamed experts go. Replace it only with named customers the source actually lists.

**List-itis plus bold overuse**
Before: **Speed:** The tool is fast. **Flexibility:** The tool is flexible. **Reliability:** The tool is reliable.
After: It's fast, takes plugins, and has been stable in daily use.
Note what did not happen: no invented render time, no invented uptime figure.

**Compulsive summary plus sycophancy**
Before: In conclusion, these strategies will help you elevate your content. I hope this helps! Let me know if you'd like me to delve deeper.
After: delete all of it. The piece ends on its last real point.

---

## Honest caveats

None of these signs proves authorship. Models trained on human writing echo human habits, and heavy AI users are drifting toward AI phrasing in their own speech. Wikipedia's guidance is explicitly descriptive rather than a set of laws, and even expert readers misjudge a meaningful share of texts.

So when editing someone's writing, flag patterns without accusing the person. And when writing, remember the standard is not "undetectable". It is that every sentence earns its place, says something specific, and sounds like a person who means it.
