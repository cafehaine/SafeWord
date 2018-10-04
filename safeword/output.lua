local channel = love.thread.getChannel("safeword")

love.event = require("love.event")

local settings = ...

local prefix = {
	[0]="E",
	[1]="W",
	[2]="I",
	[3]="D"
}

local colors = {
	[0]="\27[1;91m",
	[1]="\27[93m",
	[2]="\27[36m",
	[3]="\27[37m"
}

local popup_types = {
	[0] = "error",
	[1] = "warning",
	[2] = "info"
}

while true do
	local message = channel:demand()
	local level, source, text = unpack(message)

	if level > settings.level then
		goto endloop
	end

	local line = source .. "\t" .. os.date("%H:%M:%S") .. " − " .. text

	if settings.prefix then
		line = "[" .. prefix[level] .. "]\t" .. line
	end

	if settings.color and settings.output == "console" then
		line = colors[level] .. line .. "\27[0m"
	end

	if settings.output == "console" then
		print(line)
	elseif settings.output == "popup" and level < 3 then
		love.event.push("safewordpopup", line, popup_types[level])
	end
	::endloop::
end
