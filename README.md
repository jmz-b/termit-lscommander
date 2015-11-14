# termit-lsCommander
[termit](https://github.com/nonstop/termit) plugin to navigate directories and open files with a mouse

## Installation and Configuration
Download the script

    curl https://raw.githubusercontent.com/jmz-b/termit-lsCommander/master/lsCommander.lua >  $HOME/.config/termit/lsCommander.lua

1 ) Add the following set up code the the beginning of your rc.lua

```
package.path = os.getenv('HOME') .. '/.config/termit/lsCommander.lua;' .. package.path
require('lsCommander')

Commander.openTab = openTab
Commander.prevTab = prevTab
Commander.closeTab = closeTab

lsCommanderMenu = {}
table.insert(lsCommanderMenu, {
	name='home',
	action=function () Commander:openBrowserNewTab(os.getenv('HOME')) end 
})

addPopupMenu(lsCommanderMenu, "lsCommander")
```

You can add a new directory to the pop up menu by adding another action like this

```
table.insert(lsCommanderMenu, {
	name='src',
	action=function () Commander:openBrowserNewTab(os.getenv('HOME') .. '/src') end 
})
```

You can make browser display in the current tab by replacing openBrowserNewTab with openBrowserCurrentTab`

2) Add the following to your defaults.matches in rc.lua

    [Commander.pattern] = function(lsstr) Commander:run(lsstr) end

3) If you want to be able to access the browser from a shell, you can set an alias like this:

    alias lscommander="bash -c 'ls -ld  --group-directories-first --color $PWD/{*,.*} | sed \"s/^/== /\" | less -R && bash'"
