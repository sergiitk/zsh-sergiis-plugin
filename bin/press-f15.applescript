#!/usr/bin/env osascript

# https://eastmanreference.com/complete-list-of-applescript-key-codes
# https://developer.apple.com/documentation/uikit/uikeyboardhidusage/keyboardf1
# https://github.com/Zenexer/internet-reference/blob/main/Mac%20Keyboard%20Symbols.md
# https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide
# https://mybyways.com/blog/remapping-physical-function-keys-on-macbook-pros
# https://developer.apple.com/library/archive/technotes/tn2450/_index.html
delay 0.5
log "ready?"
delay 1
tell application "System Events"
	# shift+113 = shift+F15
	# will be used as a noop
	key code 113
	# using {shift down}
end tell
