require('os')

Commander = {
	pattern = '^== [drwx-]{10}+.*',
	-- open a new shell and display long ls output in less
	spawnbrowser = "bash -c 'ls -ld  --group-directories-first --color $PWD/{*,.*} | sed \"s/^/== /\" | less -R && bash'",
	spawnviewer = "gvim"
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

Commander.openBrowser = function (self, path)
	local tabInfo = {
		command = self.spawnbrowser,
		workingDir = path
	}

	self.openTab(tabInfo)
	self.prevTab()
	self.closeTab()
end

Commander.openHomeBrowser = function (self)
	self.openBrowser(os.getenv('HOME'))
end

Commander.run = function (self, lsstr)
	local line = Commander.loadLine(lsstr)
	local perms = Commander.getPerms(line)
	local path = Commander.getPath(line)
	
	if Commander.isDir(perms) then
		Commander:openBrowser(path)
	else
		os.execute(self.spawnviewer .. ' ' ..  path) 
	end
end
