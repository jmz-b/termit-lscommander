# termit-lscommander

[Termit](https://github.com/nonstop/termit) plugin to navigate directories and open files with a mouse


## Installation and Configuration

Download the script

    curl https://raw.githubusercontent.com/jmz-b/termit-lscommander/master/lscommander.lua >  $HOME/.config/termit/lscommander.lua

1) Copy ./lsc into your $PATH. Alternately set this alias:

    alias lsc="ls -ld  --group-directories-first --color $PWD/{*,.*} | sed 's/^/== /'"

2) Add the following to your defaults.matches in rc.lua

    [Commander.pattern] = function(lsstr) Commander:run(lsstr) end
