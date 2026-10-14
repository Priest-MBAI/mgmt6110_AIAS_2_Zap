# Plan: Task 2 — "School Mail Sentinel" looping Zap + add it to the quadrant map

## Context
Task 1 (the quadrant map at https://mgmt6110zapgroup7.vercel.app, repo `Priest-MBAI/mgmt6110_AIAS_2_Zap`) is live.
Task 2: build an automated looping workflow that watches the school mailbox, fires a notification when an email
concerns the MBAI programme, and then place that agent on the map with a justification. Group decided: **both**
timings (immediate alert + 7pm digest) and **Slack + personal email** as channels.

## Part A0 — describe the agent in Prof. Roh's loop vocabulary (Week 7 slide 10: Observe → Think → Act, tool menu, trajectory, human gate)

| Loop element | School Mail Sentinel |
|---|---|
| **Observe** | New email lands in the school mailbox (Gmail trigger) — or, for the digest, the 7pm clock tick. |
| **Think** (model) | AI by Zapier reads subject + body and answers: *does this concern MBAI, a named professor, or the student?* Then writes a one-line summary and picks the matched keyword. |
| **Act** (tool menu, checked and run by Zapier) | `search_mailbox(query)` · `summarise(email)` · `send_slack_dm(text)` · `send_personal_email(text)`. |
| **Human gate built into the tool menu** | The menu has **no** `reply`, `forward`, `delete` or `mark_read`. The agent can only tell the student; the student reads the original and decides whether to act. (Same principle as the slide's `draft_email` that "cannot send".) |
| **Trajectory** (the run's record) | Zapier *Zap History* logs every step with inputs and outputs for each run — this is what the group screenshots as evidence. |
| **Why a second turn?** | The 7pm digest is the second pass over the same observations: anything the immediate loop missed (or a keyword list gap) is caught once a day. |

## Part A — the two Zaps (built in the Zapier UI; nothing to code)

School mail is **Microsoft 365 / Outlook** (`mbai.smu.edu.sg` MX → `mail.protection.outlook.com`), so the
observe step uses Zapier's **Microsoft Outlook** app. Sign in with the school account when Zapier asks.

Search string (Outlook/KQL syntax; `OR` must be uppercase; add each member's full name and their other module profs):
`MBAI OR "Artificial Intelligence" OR "Sungjong Roh" OR "An-Ping Lin" OR "Ernst Christian Osinga" OR "Lim Yun Fong" OR "Alan Asman"`

### Zap 1 · Immediate alert (the loop: every matching email → one alert)
1. **Trigger:** Microsoft Outlook → *New Email Matching Search*, with the search string above.
2. **Filter by Zapier** (belt and braces): continue only if Subject or Body Preview *contains* one of the keywords.
3. **AI by Zapier** (optional, 1 step): "Summarise this email in one line and say which keyword matched." Output `summary`.
4. **Slack → Send Direct Message** to each member: `📬 {{summary}} · from {{from}} · {{subject}}` + the email's web link.
5. **Microsoft Outlook → Send Email** (from the school account) to each member's personal address, same text.

### Zap 2 · 7pm digest (the loop: every day → one summary)
1. **Trigger:** Schedule by Zapier → *Every Day*, 19:00 Asia/Singapore.
2. **Microsoft Outlook → Bulk Find Emails** with the same search string (returns several matches; use *Find Emails* if Bulk is unavailable on the plan).
3. **Filter by Zapier**: stop if nothing was found. Then **AI by Zapier**: "Bullet digest of today's emails, grouped by professor/module."
4. **Slack → Send Channel Message** to a group channel + **Microsoft Outlook → Send Email** to personal addresses.

### If SMU blocks Zapier at the sign-in step
University Microsoft 365 tenants often require IT admin approval for third-party apps. If Zapier's Outlook sign-in shows
"Need admin approval": build the observe step in **Power Automate** (included with SMU Microsoft 365, already approved).
Flow: *Office 365 Outlook → When a new email arrives (V3)* with the keyword condition → *HTTP POST* to a Zapier
**Webhooks → Catch Hook** URL. Zapier then runs steps 3–5 unchanged. (The Power Automate HTTP action may need a premium
licence; if so, use the free *Slack → Post message* connector in Power Automate directly.)

### Test evidence to capture for the submission
- Zapier *Zap History* showing one run of each Zap.
- Screenshot of the Slack DM and the personal-inbox email.

## Part B — add the agent to the quadrant map

**Placement: 03 · AI alone, with checks** (one right answer; either can do it alone).

Why (and sources to cite in the write-up):
- *One right answer:* "Does this email mention MBAI / a named professor / my name?" is a classification with a
  verifiable ground truth — the keyword is either in the text or it isn't. Per the Week 7 map, right-answer work
  sits in the left column (Roh, MGMT 6110 Week 7, *The Map of Human-AI Collaboration*).
- *Either can do it alone:* a student could scan the inbox by hand; the Zap does the identical check faster and
  never forgets. Nothing about the task needs a human *in the moment*. This is prediction, not judgment —
  Agrawal, Gans & Goldfarb, *Prediction Machines* (2018): automate when the prediction is cheap and the
  decision rule is fixed.
- *With checks:* false positives cost one extra notification; false negatives are caught by the 7pm digest
  (the second loop is the check on the first). A weekly review of Zap History is the human audit. Low-stakes,
  reversible, high-volume work is the canonical automation zone (Davenport & Kirby, *Only Humans Need Apply*, 2016).
- *Why not 02 "Agents run it, a person judges":* no output needs approval before it ships — a notification is
  not a decision. *Why not 01:* a person does not lead; they are just the recipient.

### File changes (`index.html`, both copies: Desktop repo + `group-quadrant/`)
1. Add a 4th business `sentinel: "School mail sentinel"` to `BIZ`, a colour token `--sentinel`, a filter button and swatch.
2. Add one task to `TASKS`:
   `{ b:"sentinel", q:"bl", t:"Alert me when school email mentions MBAI or my professors",
      why:"Keyword match has a right answer and a student could do it by hand; the Zap does it alone, and the 7pm digest plus a weekly Zap-History review are the checks." }`
3. Header count becomes "of 13 placed" automatically (`TASKS.length`).
3b. Add a small "Agent loop" card under the map (shown when the sentinel filter is active): three pills **Observe → Think → Act**, the four-item tool menu, and the line "no reply/forward/delete tool: the student decides". Uses the same paper/serif styling; no new libraries.
4. Add a short **Sources** list in the footer: Roh Week 7; Agrawal/Gans/Goldfarb 2018; Davenport & Kirby 2016.
5. Walkthrough: the new business is picked up automatically by the `Object.keys(BIZ)` loop.
6. `git commit` + `git push` → Vercel redeploys.

## Verification
- Open the live URL: "Place all" shows 13 placed, bl quadrant has 4 tasks; filter "School mail sentinel" shows one chip.
- Walkthrough runs through the 4th business without error; console clean.
- Zapier: send a test email with "MBAI" in the subject to the school address → Slack DM + personal email arrive within ~2 min; Zap 2 "Run now" produces a digest.
