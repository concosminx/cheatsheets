# How to define and use aliases

- list your configuration with `git config --global -l`
- define a Git alias `git config --global alias.p 'push'` and use it `git p`

## useful Git aliases
- Git status: `git config --global alias.st 'status -sb'` (less verbose status with branch information)
- Git log `--oneline`: `git config --global alias.ll 'log --oneline'` (commits as single lines for more compact output)
- Git last commit: `git config --global alias.last 'log -1 HEAD --stat'`
- Git commit: `git config --global alias.cm 'commit -m'` and use it `git cm "Some message"`
- Git remote: `git config --global alias.rv 'remote -v'`
- Git diff: `git config --global alias.d 'diff'`
- Git config list: `git config --global alias.gl 'config --global -l'`
- Git search commit: `git config --global alias.se '!git rev-list --all | xargs git grep -F'` and use it `git se testText`

## enable autocorrect 
- `git config --global help.autocorrect 20`

## use WinMerge as git difftool on Windows
- open `c:\users\username\.gitconfig`
```
[diff]
    tool = winmerge
[difftool "winmerge"]
    cmd = "'C:/Program Files (x86)/WinMerge/WinMergeU.exe'" -e "$LOCAL" "$REMOTE"
```
or 
```
[difftool "WinMerge"]
    cmd = \"C:\\Program Files\\WinMerge\\WinMergeU.exe\" -e -u -dl \"Old $BASE\" -dr \"New $BASE\" \"$LOCAL\" \"$REMOTE\"
    trustExitCode = true

[mergetool "WinMerge"]
    cmd = \"C:\\Program Files\\WinMerge\\WinMergeU.exe\" -e -u -dl \"Local\" -dm \"Base\" -dr \"Remote\" \"$LOCAL\" \"$BASE\" \"$REMOTE\" -o \"$MERGED\"
    trustExitCode = true
    keepBackup = false
```
- `git difftool HEAD HEAD~1`
- see [discussion](https://stackoverflow.com/questions/2468230/how-to-use-winmerge-with-git-extensions)

## git add and commit
- `git config --global alias.add-commit '!git add -A && git commit'`
- `git add-commit -m 'Some message'`

