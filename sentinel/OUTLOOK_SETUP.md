# Outlook users: forward school mail to your Gmail

For teammates who read SMU email in **Microsoft Outlook** (Outlook on the web, new Outlook, classic Outlook for
Windows, or Outlook for Mac). Total time: about 10 minutes.

**Make the rule in Outlook on the web, whichever Outlook app you normally use.** A rule made there is saved
in your school mailbox on Microsoft's servers. It works in every Outlook app and keeps running when your
laptop is off.

---

## Step 1 · Have your keyword list ready

Copy this list and add your own full name at the end:

```
MBAI
Artificial Intelligence
Sungjong Roh
An-Ping Lin
Osinga
Lim Yun Fong
MGMT 6110
MGMT6110
ACCT 689
ACCT689
MKTG 644
MKTG644
OPIM 639
OPIM639
Your Full Name
```

Swap in the professors and module codes for *your* modules if they differ.

## Step 2 · Open the rules page

1. Go to **https://outlook.office.com** and sign in with your SMU account (`you.2026@mbai.smu.edu.sg`).
2. Click the **gear icon** (Settings) at the top right.
3. Go to **Mail → Rules**.
4. Click **+ Add new rule**.

## Step 3 · Build the rule

1. **Name your rule:** `School Mail Sentinel → Gmail`
2. **Add a condition:** choose **Subject or body includes**.
3. Type the first keyword (`MBAI`) and press **Enter**. Repeat for every keyword in your list.
   All keywords go into this **one** condition, which matches *any* of them.
   Don't click "Add another condition": a second condition means an email must match **both** conditions.
4. **Add an action:** choose **Forward to**, then type your personal Gmail address and press **Enter**.
   - Use **Forward to**, not "Redirect to". With Forward to, emails arrive in Gmail from your school address
     with "FW:" in the subject, which is what the agent's Gmail search looks for.
5. Leave **Stop processing more rules** unticked.
6. Click **Save**.

The rule now appears in the list with its toggle switched **on**.

## Step 4 · Test it (about 2 minutes)

1. From your phone or personal Gmail, send an email to your **school** address with the subject `MBAI test`.
2. Wait a minute, then check your **personal Gmail**. You should see `FW: MBAI test` from your school address.

**If you see it:** you're done. Go to [SETUP.md](SETUP.md) step 3 to connect Zapier and/or the Claude routines.

**If your school inbox instead gets a bounce** saying *"Your organization does not allow external
forwarding"* or *"550 5.7.520 Access denied"*: SMU blocks automatic forwarding on the server. Use one of these:

| Your setup | Fallback |
|---|---|
| Mac with Apple Mail | Add your school account to Apple Mail and run `osascript apple-mail-rule.applescript you@gmail.com "Your Full Name"` (see [SETUP.md](SETUP.md) option A). |
| Classic Outlook for Windows | Make the rule in the desktop app (steps below) and tick **on this computer only**. The rule then runs inside Outlook on your PC, and the PC must be on with Outlook open. |
| Neither | Wait for the IT admin approval, then connect Microsoft 365 to Zapier or Claude directly. |

---

## Classic Outlook for Windows (desktop app), only if you need the fallback

1. **Home** tab → **Rules** → **Manage Rules & Alerts** → **New Rule…**
2. Under *Start from a blank rule*, choose **Apply rule on messages I receive** → **Next**.
3. Tick **with specific words in the subject or body**. In the box below, click **specific words**, add each
   keyword from Step 1 (click **Add** after each), then **OK** → **Next**.
4. Tick **forward it to people or public group**. In the box below, click **people or public group**, type
   your Gmail address in **To ->**, then **OK** → **Next**.
5. Skip exceptions → **Next**.
6. Name it `School Mail Sentinel → Gmail`. Tick **Turn on this rule**. If the server rule bounced, also tick
   **on this computer only**. Click **Finish** → **OK**.
7. Repeat the test in Step 4.

## Outlook for Mac (desktop app)

Use the web steps above (Step 2 onwards). The rule shows up in Outlook for Mac automatically, because it's stored
on the server.

---

**What happens next:** forwarded emails land in your Gmail. The Zapier Gmail trigger and the Claude routines
read them there, filter by keyword again, and send the alert to your phone, email or Slack. The agent never
replies to, deletes or changes your school email.
