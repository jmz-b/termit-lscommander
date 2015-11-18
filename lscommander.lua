require('os')

Commander = {
	-- open a new shell and display long ls output in less
	spawnBrowser = "bash -c 'ls -ld  --group-directories-first --color $PWD/{*,.*} | sed \"s/^/== /\" | less -R && bash'",
	spawnViewer = 'xdg-open',
	
	pattern = '^== [drwx-]{10}+.*',
	newTab = false,
	popupDirs = {
		home = os.getenv('HOME')
	},
}

-- serialize a line of ls output into a table
Commander.loadLine = function (lsstr)
	local cols = {}
	for c in lsstr:gmatch("%S+") do table.insert(cols, c) end
	return cols
end

-- return the permission string from a line table
Commander.getPerms = function (line)
	return line[2]
end

-- return the path in a line table
Commander.getPath = function (line)
	return line[10]
end

-- return True if path is a directory
-- return False path is a file
Commander.isDir = function (perms)
	if perms:sub(1, 1) == 'd' then
		return true
	else
		return false
	end
end

-- factory to generate parameters for openTab
Commander.getTabInfo = function (self, path)
	return {
		command = self.spawnBrowser,
		title = path,
		workingDir = path,
	}
end

-- produce a string to use as a seperator in the popup menu
-- based on the length of another string
Commander.getSeperator = function (initialSeperator, str)
	local seperator = initialSeperator
	for i = 1, string.len(str) do
		if string.len(seperator) >= string.len(str) then
			return seperator
		end
		seperator = seperator .. '-'
	end
end

-- open lscommander tab 
Commander.openBrowser = function (self, path)
	openTab(self:getTabInfo(path))

	if not self.newTab then
		prevTab()
		closeTab()
	end
end

-- populate the popup menu
Commander.init = function (self)
	local lscommanderMenu = {}
	local newTabText = 'Open in new tab'
	local currentTabText = 'Open in current tab'
	local initialSeperator = self.getSeperator('-', currentTabText)
	local longestTitle= initialSeperator
	
	for title, path in pairs(self.popupDirs) do
		if string.len(title) > string.len(longestTitle) then
			longestTitle = title
		end
		
		table.insert(lscommanderMenu, {
			name=title,
    			action=function () self:openBrowser(path) end,
		})
	end

	table.insert(lscommanderMenu, {
		name=self.getSeperator(initialSeperator, longestTitle)
	})
	table.insert(lscommanderMenu, {
		name=newTabText,
		action=function() self.newTab = true end,
	})
	table.insert(lscommanderMenu, {
		name=currentTabText,
		action=function() self.newTab = false end,
	})

	addPopupMenu(lscommanderMenu, "lscommander")
end

Commander.run = function (self, lsstr)
	local line = Commander.loadLine(lsstr)
	local perms = Commander.getPerms(line)
	local path = Commander.getPath(line)
	
	if Commander.isDir(perms) then
		Commander:openBrowser(path)
	else
		os.execute(self.spawnViewer .. ' ' ..  path) 
	end
end
