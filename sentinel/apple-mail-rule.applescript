-- School Mail Sentinel: Apple Mail rule that forwards school emails to your personal Gmail.
-- The forwarded emails are what the Zapier Gmail trigger and the Claude routines read.
--
-- Usage (Terminal, on your own Mac, with your school account already added to Apple Mail):
--   osascript apple-mail-rule.applescript you@gmail.com "Your Full Name" ["Extra keyword" ...]
--
-- Running it again replaces the rule. The rule runs only while your Mac is on and Mail is open.

on run argv
	if (count of argv) < 2 then error "Usage: osascript apple-mail-rule.applescript you@gmail.com \"Your Full Name\" [\"Extra keyword\" ...]"
	set personalEmail to item 1 of argv
	set fullName to item 2 of argv

	set keywords to {"MBAI", "Artificial Intelligence", "Sungjong Roh", "An-Ping Lin", "Osinga", "Lim Yun Fong", "MGMT 6110", "MGMT6110", "ACCT 689", "ACCT689", "MKTG 644", "MKTG644", "OPIM 639", "OPIM639", fullName}
	if (count of argv) > 2 then set keywords to keywords & (items 3 thru -1 of argv)
	set senders to {"Sungjong Roh", "An-Ping Lin", "Osinga", "Lim Yun Fong", "smu.edu.sg"}

	set ruleName to "School Mail Sentinel → Gmail"
	tell application "Mail"
		repeat while (exists (first rule whose name is ruleName))
			delete (first rule whose name is ruleName)
		end repeat
		set newRule to make new rule at end of rules with properties {name:ruleName, enabled:true, all conditions must be met:false, forward message:personalEmail, stop evaluating rules:false}
		tell newRule
			repeat with c in (rule conditions)
				delete c
			end repeat
			repeat with k in keywords
				make new rule condition at end of rule conditions with properties {rule type:subject header, qualifier:does contain value, expression:(k as text)}
				make new rule condition at end of rule conditions with properties {rule type:message content, qualifier:does contain value, expression:(k as text)}
			end repeat
			repeat with s in senders
				make new rule condition at end of rule conditions with properties {rule type:from header, qualifier:does contain value, expression:(s as text)}
			end repeat
		end tell
		set enabled of newRule to true
		return "Created rule \"" & ruleName & "\" with " & (count of rule conditions of newRule) & " conditions, forwarding to " & personalEmail
	end tell
end run
