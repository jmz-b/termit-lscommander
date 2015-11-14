# termit-lsCommander
[termit](https://github.com/nonstop/termit) plugin to navigate directories and open files with a mouse

## Installation
Download the script

    curl https://raw.githubusercontent.com/jmz-b/termit-lsCommander/master/lsCommander.lua >  $HOME/.config/termit/lsCommander.lua

Add the following set up code the the beginning of your rc.lua
```
Commander.openTab = openTab
Commander.prevTab = prevTab
Commander.closeTab = closeTab
lsCommanderMenu = {}

table.insert(lsCommanderMenu, {
	name='Home',
	action=function () Commander:openBrowser(os.getenv('HOME')) end 
})
addPopupMenu(lsCommanderMenu, "lsCommander")
```

Add the following to your defaults.matches in rc.lua

    [Commander.pattern] = function(lsstr) Commander:run(lsstr) end
