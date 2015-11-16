# termit-lscommander
[Termit](https://github.com/nonstop/termit) plugin to navigate directories and open files with a mouse

![alt tag](https://raw.githubusercontent.com/jmz-b/termit-lscommander/master/demo.gif)

## Installation and Configuration
Download the script

    curl https://raw.githubusercontent.com/jmz-b/termit-lscommander/master/lscommander.lua >  $HOME/.config/termit/lscommander.lua

1 ) Add the following set up code the the beginning of your rc.lua

```
require('os')
require('termit/lscommander')

lscommanderMenu = {}
table.insert(lscommanderMenu, {
	name='home',
	action=function () Commander:openBrowserNewTab(os.getenv('HOME')) end 
})
addPopupMenu(lscommanderMenu, "lscommander")
```

You can add a new directory to the pop up menu by adding another action like this

```
table.insert(lscommanderMenu, {
	name='src',
	action=function () Commander:openBrowserNewTab(os.getenv('HOME') .. '/src') end 
})
```

You can make browser display in the current tab by replacing openBrowserNewTab with openBrowserCurrentTab

2) Add the following to your defaults.matches in rc.lua

    [Commander.pattern] = function(lsstr) Commander:run(lsstr) end

3) If you want to be able to access the browser from a shell, you can set an alias like this:

    alias lscommander="bash -c 'ls -ld  --group-directories-first --color $PWD/{*,.*} | sed \"s/^/== /\" | less -R && bash'"
