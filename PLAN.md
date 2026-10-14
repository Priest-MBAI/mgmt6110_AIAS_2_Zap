# Plan: Human-AI 2x2 quadrant front-end + Zap trigger + video (MGMT6110 group)

## Context
The group needs a deployable (Vercel) front-end that places tasks from 3 business functions on Prof. Roh's Week 7
2x2 "Map of Human-AI Collaboration", with each task able to fire a Zapier Zap, plus a step-by-step video.
Time budget is about 10 minutes, so this uses one static HTML file, no framework or build step.

## Framework (copied from the Week 7 slide)
| | Work with a right answer | Work with no single right answer |
|---|---|---|
| **People + AI must do it together** | A person leads, AI inside | Agents run it, a person judges |
| **Either can do it alone** | AI alone, with checks | A person decides, AI alongside |

## Task placements (12 tasks, 4 per business, one in each quadrant)
| Business | AI alone, with checks | A person leads, AI inside | Agents run it, a person judges | A person decides, AI alongside |
|---|---|---|---|---|
| Modern farm | Flag sensor readings outside thresholds | Diagnose crop disease from a leaf photo | Plan the daily task roster around weather | Decide to treat or cull a sick animal |
| AI strategist | Audit which teams use which tools | Calculate the ROI of an AI pilot | Scan departments and rank AI opportunities | Recommend which AI bet the CEO funds |
| Necklace jeweller | Answer "where is my order?" queries | Write product pages with exact metal and carat specs | Test ad and photo variants | Price a custom or new-collection necklace |

Each task gets a one-line reason in the UI, matching the reference slide's pattern.

## Files to create (in `group-quadrant/` in this repo)
1. `index.html`: whole app, inline CSS and JS
   - 2x2 grid, a business filter (All / Farm / Strategist / Jeweller), and clickable task chips that place a task into its quadrant and show the reason
   - "Run Zap" button on each placed task: `fetch(ZAPIER_HOOK_URL, {method:'POST', mode:'no-cors', body: JSON.stringify({business, task, quadrant, human_in_loop, ts})})`
   - "Tour" button: auto-steps through axes → quadrants → each business's tasks (about 3s per step) for the video recording
2. `vercel.json`: not needed. A static file deploys as-is.

## Zap (built in the Zapier UI by the group)
1. Trigger: **Webhooks by Zapier → Catch Hook**. Copy the URL into `ZAPIER_HOOK_URL` in `index.html`.
2. **Paths by Zapier** on `quadrant`:
   - "AI alone, with checks" → AI by Zapier step → log to Google Sheet
   - Every other path → AI by Zapier draft → **Human in the Loop** approval (or a Slack/Gmail message) → log to Sheet

## Steps and time
1. Write `index.html` (about 3 min, Claude)
2. Deploy: `npx vercel --prod` from `group-quadrant/` (about 2 min, needs the group's Vercel login)
3. Paste the Catch Hook URL, redeploy, click one Run Zap, and check that Zapier shows the test record (about 3 min)
4. Video: open the deployed URL, press Cmd+Shift+5 → record, click Tour (about 2 min of footage)

## Verification
- Open `index.html` locally in the browser pane. Check that all 12 tasks place correctly, Tour runs end-to-end, and no console errors appear.
- After deploy, a Run Zap click shows up in Zapier's Catch Hook "Test trigger".
