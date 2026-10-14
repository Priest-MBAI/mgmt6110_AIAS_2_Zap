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
