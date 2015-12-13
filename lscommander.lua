require('os')

Commander = {
	pattern = '^== [drwx-]{10}+.*',
}

Commander.run = function (self, lsstr)
	local line = {}
	for col in lsstr:gmatch("%S+") do table.insert(line, col) end

	local perms = line[2]
	local path = line[10]

	if perms:sub(1, 1) == 'd' then
		feedChild('\rcd ' .. path .. ' && lsc\r')
	else
		os.execute('xdg-open ' ..  path)
	end	
end
