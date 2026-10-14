# Who Holds the Pen: Human-AI task map (MGMT 6110 group project)

A 2x2 map placing 12 tasks from 3 businesses (modern farm, AI strategist, necklace jeweller).
Each placed task has a **Run Zap** button that POSTs to a Zapier Catch Hook.

## 1. Deploy to Vercel
```bash
cd ~/Desktop/MGMT6110_Human_AI_Quadrant_Map && npx vercel --prod
```

## 2. Connect the Zap
1. Zapier: create a Zap with the trigger **Webhooks by Zapier → Catch Hook** and copy the URL.
2. Paste it into `ZAPIER_HOOK_URL` near the top of the `<script>` in `index.html`, then deploy again.
3. Payload fields: `business`, `task`, `quadrant`, `human_in_loop`, `reason`, `ts`.
4. Optional: add **Paths** on `quadrant`. "AI alone, with checks" goes AI → Sheet; the others go AI draft → Human in the Loop approval → Sheet.

## 3. Record the video
Open the deployed URL, press Cmd+Shift+5 and record, then click **Play walkthrough** (about 90 seconds).

## The School Mail Sentinel, built two ways

| | Zapier | Claude routines (claude.ai/code/routines) |
|---|---|---|
| Observe | School inbox → mail rule forwards to personal Gmail → Gmail "New Email Matching Search" (instant) | Same forwarded emails, read through the Gmail connector |
| Schedule | Instant alert + Schedule by Zapier at 7 pm | Hourly 08:00–23:00 SGT (`0 0-15 * * *` UTC) + daily 19:00 SGT (`0 11 * * *` UTC) |
| Think | Filter + AI by Zapier summary | Claude Sonnet 5.5 matches keywords, summarises, groups by module, flags deadlines |
| Act | Slack DM and/or Gmail notification | Push notification to the Claude phone app + Gmail (Slack optional) |
| Human gate | No reply/forward/delete steps in the Zap | Prompt forbids reply/forward/delete/move/mark-read; email text treated as data |
| Trajectory | Zap History | Each run is a session log under the routine |

**Teammates: set up your own copy with [`sentinel/SETUP.md`](sentinel/SETUP.md).** Outlook users: start with [`sentinel/OUTLOOK_SETUP.md`](sentinel/OUTLOOK_SETUP.md).
Routines are per account: each person creates their own from the prompt templates in `sentinel/`.
