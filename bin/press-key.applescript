#!/usr/bin/env osascript

# https://eastmanreference.com/complete-list-of-applescript-key-codes
# https://developer.apple.com/documentation/uikit/uikeyboardhidusage/keyboardf1
# https://github.com/Zenexer/internet-reference/blob/main/Mac%20Keyboard%20Symbols.md
# https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide
# https://mybyways.com/blog/remapping-physical-function-keys-on-macbook-pros
# https://developer.apple.com/library/archive/technotes/tn2450/_index.html

# https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/EventOverview/HandlingKeyEvents/HandlingKeyEvents.html
# plutil -p /System/Library/Frameworks/AppKit.framework/Resources/StandardKeyBinding.dict | less
# https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/EventOverview/TextDefaultsBindings/TextDefaultsBindings.html

# “^” for Control
# “~” for Option
# “$” for Shift
# “#” for numeric keypad

# -----------

# Hex key codes: https://github.com/pqrs-org/cpp-osx-iokit_hid_system/blob/main/include/pqrs/osx/iokit_hid_system/key_code.hpp
# keyboard_f15(0x71)
#
# Unicode key codes: https://docs.rs/cocoa/latest/cocoa/appkit/index.html
# NSF15FunctionKey = 0xF712

# Key Down
#   Characters: 
#   Unicode:    63250 / 0xf712
#   Keys:   ⇧F15
#   Key Code: 113 / 0x71
#   Modifiers:  8519682 / 0x820002

# ❯ defaults write app.bundle.id NSUserKeyEquivalents -dict-add "abc" -string $'\$\uf712'
# ❯ defaults write uk.co.menial.Base NSUserKeyEquivalents -dict-add "abc" -string $'\$\uf712'
# ❯ killall cfprefsd

# -----------

# NSF19FunctionKey: c_ushort = 0xF716; keyboard_f19(0x50); dec=80 - the last recognized by apps
# NSF20FunctionKey: c_ushort = 0xF717; keyboard_f20(0x5a); dec=90
# NSF21FunctionKey: c_ushort = 0xF718; keyboard_f21(unassigned)

# f19:
# ❯ defaults write net.shinyfrog.bear NSUserKeyEquivalents -dict-add "\033View\033Show Trash" -string $'\uf716'
# ❯ defaults write net.shinyfrog.bear NSUserKeyEquivalents -dict-add "\033View\033Show Archive" -string $'\uf716'

# can I just set it to \026? I think osx corrected it like that
# "\033View\033Show Archive" = "\026";
# "\033View\033Show Trash" = "\\Uf716";

on run argv
  try
    set kcode to item 1 of argv
    on error
        log "need the key code argument"
        return
    end try

  try
      set kcode to kcode as number
  on error
      log "Not a number"
      return
  end try

  log "Will send key code " & kcode

  delay 0.5
  log "Pressing in 1 sec..."
  delay 1
  tell application "System Events"
    key code kcode
    # using {shift down}
  end tell
end run
