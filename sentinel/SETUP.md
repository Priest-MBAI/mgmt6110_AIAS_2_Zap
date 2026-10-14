# Set up your own School Mail Sentinel

Each teammate runs their own copy, because the agent reads *your* inbox and notifies *your* devices.

**Why there's a forwarding step:** SMU email is Microsoft 365. Connecting it directly to Zapier or Claude needs
school IT admin approval, which is pending. So a mail rule forwards school emails to your personal Gmail, and the
agent reads them there. Gmail needs no school approval.

```
School inbox (Outlook) ──rule──▶ personal Gmail ──▶ Zapier (instant)  ──▶ Slack / email
                                                └─▶ Claude routine (hourly + 7 pm) ──▶ phone push / email / Slack
```

## 1. Your values

| Placeholder | What to put | Example |
|---|---|---|
| `{{FULL_NAME}}` | Your full name as it appears in school emails | Jane Tan Mei Ling |
| `{{SCHOOL_EMAIL}}` | Your SMU address | jane.2026@mbai.smu.edu.sg |
| `{{PERSONAL_EMAIL}}` | Your personal Gmail | jane.personal@gmail.com |
| `{{PROFESSORS}}` | Professors of *your* modules, separated by `;` | Sungjong Roh; An-Ping Lin; Ernst Christian Osinga; Lim Yun Fong |
| `{{MODULE_CODES}}` | Your module codes, separated by `,` | MGMT 6110, ACCT 689, MKTG 644, OPIM 639 |

## 2. Forward school mail to your Gmail (pick one)

**A. Apple Mail on a Mac (if your school account is already in Apple Mail).** Run one command in Terminal from this folder:

```bash
osascript apple-mail-rule.applescript you@gmail.com "Your Full Name"
```

This creates the rule "School Mail Sentinel → Gmail". It forwards any email whose subject, body or sender mentions
MBAI, AI, the professors, the module codes, any smu.edu.sg sender, or your name. Add extra keywords as more quoted
arguments. Mail must be open and the Mac awake for the rule to run. The first time, macOS asks you to allow
Terminal to control Mail; click OK.

**B. Microsoft Outlook (web, new Outlook, classic Windows, or Mac).** Follow the step-by-step guide in
[OUTLOOK_SETUP.md](OUTLOOK_SETUP.md). The rule lives on the server, so it works even when your laptop is off.

Test it: send yourself (at the school address) an email with "MBAI test" in the subject. Within about a minute, a
"Fwd: MBAI test" email should land in your Gmail.

## 3a. Zapier (instant alert + 7 pm digest)

Gmail search string. Add one `OR "..."` per professor or module code:

```
from:{{SCHOOL_EMAIL}} {MBAI "Artificial Intelligence" "{{FULL_NAME}}" "Sungjong Roh" "MGMT 6110"}
```

- **Zap 1:** Gmail → *New Email Matching Search* (the string above) → AI by Zapier (one-line summary) →
  Slack *Send Direct Message* and/or Gmail *Send Email* to yourself with a 📬 subject.
- **Zap 2:** Schedule by Zapier (every day 19:00 Asia/Singapore) → Gmail *Find Email* with the same search plus `newer_than:1d`
  → Filter (stop if none) → AI by Zapier digest → Slack and/or Gmail.

## 3b. Claude routines (hourly alert + 7 pm digest)

1. Connect **Gmail** at https://claude.ai/customize/connectors (Slack is optional).
2. Copy `hourly-alert.prompt.md` and `daily-digest.prompt.md` and replace every `{{...}}` with your values.
3. Go to https://claude.ai/code/routines → **New routine**:
   - Hourly alert: paste the filled hourly prompt; schedule `0 0-15 * * *` (UTC = every hour 08:00–23:00 SGT).
   - Daily digest: paste the filled digest prompt; schedule `0 11 * * *` (UTC = 19:00 SGT).
   - Attach the Gmail connector (and Slack, if you have it) to both.
4. Install the Claude app on your phone and sign in. The routine's **PushNotification** step sends the alert there.
5. Click **Run now** on the digest to test it.

Or, from Claude Code, run `/schedule` and paste the filled prompt.

## 4. Customise freely

- Change the notification wording, emoji, or digest headings in the prompts.
- Narrow the hourly schedule (for example `0 1,5,9,13 * * *` = 9 am, 1 pm, 5 pm, 9 pm SGT).
- Keep the **Rules** block in each prompt as it is. It is the human gate: the agent can read and notify, never
  reply, forward, delete or change your email.
