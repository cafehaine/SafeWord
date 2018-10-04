local sw = {}

local settings = {color=true, prefix=true, output="console", level=3}
local channel = love.thread.getChannel("safeword")

function sw.init(args)
	for k,v in pairs(args) do
		if k == "color" and type(v) ~= "boolean" then
			error("Invalid argument for color of type " .. type(v)
				.. ". Expected value of type boolean.")

		elseif k == "prefix" and type(v) ~= "boolean" then
			error("Invalid argument for prefix of type " .. type(v)
				.. ". Expected value of type boolean.")
		elseif k == "output" and type(v) ~= "string" then
			error("Invalid argument for output of type " .. type(v)
				.. ". Expected value of type string.")
		elseif k == "level" and type(v) ~= "number" then
			error("Invalid argument for level of type " .. type(v)
				.. ". Expected value of type number.")
		end
		settings[k] = v
	end

	-- register an handler to display popups if output is set to popup
	function love.handlers.safewordpopup(text,type)
		love.window.showMessageBox("SafeWörd", text, type)
	end

	-- start the thread that handles all of the inputs
	thread = love.thread.newThread("safeword/output.lua")
	thread:start(settings)
end

function sw.error(src, text) channel:push({0, src, text}) end

function sw.warn(src, text) channel:push({1, src, text}) end

function sw.info(src, text) channel:push({2, src, text}) end

function sw.debug(src, text) channel:push({3, src, text}) end

return sw
