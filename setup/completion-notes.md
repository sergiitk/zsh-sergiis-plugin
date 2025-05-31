# Completion

If you're looking for the compdef stuff, see
https://zsh.sourceforge.io/Doc/Release/Completion-System.html
https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org
https://wikimatze.de/writing-zsh-completion-for-padrino/

Local docs from macports:

```sh
port contents zsh | rg Completion
o /opt/local/share/doc/zsh/html/Completion.html
```

Useful: press "ctrl+x, h" after the command to see completion context.

don't forget to remove .zcompdump files when using compdef ???

```
print -N $fpath | find -files0-from - -type f -name '_arguments'
```

my tool:

```console
$ ? ls-comp
ls-comp () {
  print -aC2 ${(kv)_comps}
}
```

regular zsh compltions:
https://github.com/zsh-users/zsh/tree/master/Completion/

more completions, including better `_port`
https://github.com/zsh-users/zsh-completions/tree/master/src


```console
$ pi zsh-completions
$ port contents zsh-completions
```

## reload

```sh
unfunction _find_in_dirs && autoload -U _find_in_dirs
# or
rl _find_in_dirs
```

## zstyle

`:completion:function:completer:command:argument:tag`
`:completion::complete:find-in-dirs:argument-rest:`

```sh
zstyle ':completion:*:complete:find-in-dirs:argument-rest:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

```
