# termit-lscommander

[Termit](https://github.com/nonstop/termit) plugin to navigate directories and open files with a mouse


## Installation and Configuration

1) Copy `lscommander.lua` to your termit config directory, eg:

    cp lscommander.lua $HOME/.config/termit/lscommander.lua

2) copy `bin/lsc` into your $PATH. Alternatively set this alias:

    alias lsc="ls -ld  --group-directories-first --color $PWD/{*,.*} | sed 's/^/== /'"

3) Add the following to your defaults.matches in rc.lua

    [Commander.pattern] = function(lsstr) Commander:run(lsstr) end
