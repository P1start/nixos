{ nvim }:
''
[include]
    path = ~/.gitconfig-local
[core]
    editor = ${nvim}/bin/nvim
[merge]
    tool = ${nvim}/bin/nvim -d
[push]
    default = simple
[credential]
    helper = cache
[alias]
    lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit
    co = checkout
    br = branch
    cm = commit
    ps = push
    cl = clone
    rb = rebase
    df = diff
    ad = add
    in = init
    st = status
    pl = pull
    gr = grep
    sm = submodule
    re = remote
    mg = merge
    plum = pull upstream master
''
