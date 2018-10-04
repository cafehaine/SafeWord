function love.load()
	sw = require("safeword")
	sw.init({color=true, prefix=true, output="console", level=3})
	sw.error("main", "Hi this is an error")
	sw.warn("main", "Hey this si a warning")
	sw.info("main", "Woo an info")
	sw.debug("main", "Shh, it's a debug message")

	thread_code = [[sw = require("safeword")
sw.info("thread", "Hey, I'm talking from anothe thread !")]]
	love.thread.newThread(thread_code):start()
end

function love.update()

end
