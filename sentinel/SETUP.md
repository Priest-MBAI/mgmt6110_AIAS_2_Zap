# Set up your own School Mail Sentinel

Each teammate runs their own copy, because the agent reads *your* inbox and notifies *your* devices.
Fill in the values below once, then use them in Zapier, Claude routines, or both.

## 1. Your values

| Placeholder | What to put | Example |
|---|---|---|
| `{{FULL_NAME}}` | Your full name as it appears in school emails | Jane Tan Mei Ling |
| `{{SCHOOL_EMAIL}}` | Your SMU address (Microsoft 365 / Outlook) | jane.2026@mbai.smu.edu.sg |
| `{{PERSONAL_EMAIL}}` | Where the email notification goes | jane.personal@gmail.com |
| `{{PROFESSORS}}` | Professors of *your* modules, separated by `;` | Sungjong Roh; An-Ping Lin; Ernst Christian Osinga; Lim Yun Fong |
| `{{MODULE_CODES}}` | Your module codes, separated by `;` | MGMT 6110; ACCT 689; MKTG 644; OPIM 639 |

Keywords every copy should keep: `MBAI`, `"Artificial Intelligence"`.

## 2a. Zapier (instant alert + 7 pm digest)

Outlook search string (KQL syntax, `OR` in capitals). Add one `OR "..."` per professor and module code:

```
MBAI OR "Artificial Intelligence" OR "{{FULL_NAME}}" OR "Sungjong Roh" OR "MGMT 6110"
```

Zap 1: Microsoft Outlook → *New Email Matching Search* → Filter → AI by Zapier (one-line summary)
→ Slack *Send Direct Message* → Microsoft Outlook *Send Email* to `{{PERSONAL_EMAIL}}`.

Zap 2: Schedule by Zapier (every day 19:00 Asia/Singapore) → Microsoft Outlook *Bulk Find Emails*
→ Filter (stop if none) → AI by Zapier digest → Slack + Outlook *Send Email*.

If Outlook sign-in says "Need admin approval", see the Power Automate fallback in `../PLAN.md`.

## 2b. Claude routines (hourly alert + 7 pm digest)

1. Connect **Microsoft 365** (school account), **Slack** and **Gmail** at https://claude.ai/customize/connectors.
2. Open `hourly-alert.prompt.md` and `daily-digest.prompt.md`, copy them, and replace every `{{...}}`.
3. Go to https://claude.ai/code/routines → **New routine**:
   - Hourly alert: paste the filled hourly prompt; schedule `0 0-15 * * *` (UTC = every hour 08:00–23:00 SGT).
   - Daily digest: paste the filled digest prompt; schedule `0 11 * * *` (UTC = 19:00 SGT).
   - Attach the Microsoft 365, Slack and Gmail connectors to both.
4. Click **Run now** on the digest to test. You should get a Slack DM and an email.

Or, from Claude Code, run `/schedule` and paste the filled prompt.

## 3. Customise freely

- Change the Slack line format, emoji, or grouping headings in the prompts.
- Narrow the hourly schedule (for example `0 1,5,9,13 * * *` = 9 am, 1 pm, 5 pm, 9 pm SGT).
- Keep the **Rules** block in each prompt as it is. It is the human gate: the agent can read and notify, never reply, forward or delete.
