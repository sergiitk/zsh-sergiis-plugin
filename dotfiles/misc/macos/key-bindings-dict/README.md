# ~/Library/KeyBindings/DefaultKeyBinding.dict

~/Library/KeyBindings/DefaultKeyBinding.dict is a per-user property list file on macOS that customizes text-editing and navigation key bindings in Cocoa/AppKit applications. It does not exist by default.

```sh
mkdir -p ~/Library/KeyBindings
touch ~/Library/KeyBindings/DefaultKeyBinding.dict
```

## Syntax

`DefaultKeyBinding.dict` controls global low-level text-editing actions, `NSUserKeyEquivalents` controls menu bar items for a specific app. However, they share similar modifier semantics.

### Modifiers
`^` (Control), `$` (Shift), `~` (Option), `@` (Command), `#` (Numeric Keypad) [0.6.1].

### Common Unicode key codes
- Up / Down / Left / Right Arrow: `\UF700`, `\UF701`, `\UF702`, `\UF703` [0.6.1]
- Home / End: `\UF729`, `\UF72B` [0.6.1]
- Page Up / Page Down: `\UF72C`, `\UF72D` [0.6.1]
- Backspace / Delete: `\U0008`, `\UF728` [0.6.1]

## DefaultKeyBinding.dict

Plist format. Comments can be added with `//` and `/* */`

Example:

```plist
{
    // Prevent beeps
    // Ctrl + Cmd + down (in vscode and other electron-based apps)
    "^@\UF701" = "noop:";
}
```

### Verifying

```shell-session
$ plutil -lint ./DefaultKeyBinding.dict
./DefaultKeyBinding.dict: OK

$ plutil -p ./DefaultKeyBinding.dict
{
  "^@" => "noop:"
}
```

### Hexdumps

```console
$ plutil -p ./DefaultKeyBinding.dict | sed -n '2p' | ud1
0000000        32      32      34      94      64   63233      34      32
             0020    0020    0022    005e    0040    f701    0022    0020
0000020        61      62      32      34     110     111     111     112
             003d    003e    0020    0022    006e    006f    006f    0070
0000040        58      34      10
             003a    0022    000a
0000046

$ plutil -p ./DefaultKeyBinding.dict | sed -n '2p' | udx
00000000: 0020 0020 0022 005e 0040 f701 0022 0020  . . .".^.@...".
00000010: 003d 003e 0020 0022 006e 006f 006f 0070  .=.>. .".n.o.o.p
00000020: 003a 0022 000a                           .:."..
```

### Deploying

```sh
cp -i -v "$ZSH_SERGII/dotfiles/misc/macos/key-bindings-dict/DefaultKeyBinding.dict" ~/Library/KeyBindings/DefaultKeyBinding.dict
```
