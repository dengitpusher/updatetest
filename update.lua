-- retrieve the content of a URL
--local http = require("socket.http")
local https = require("ssl.https")
local inicfg = require("inicfg")
local addon = require("addon")
encoding = require("encoding")
encoding.default = 'CP1251'
u8 = encoding.UTF8

local u8d = function(s) return encoding.UTF8:decode(s) end

update = false

local scrcommit = 4
local script_version = 1.1

local update_url = "https://raw.githubusercontent.com/dengitpusher/updatetest/main/update.ini" -- тут тоже свою ссылку
local update_path = getPath().."config//update.ini" -- и тут свою ссылку

local script_url = "https://raw.githubusercontent.com/dengitpusher/updatetest/main/update.lua" -- тут свою ссылку
local script_path = "scripts//update.lua"

function onLoad()
local body, code = https.request(update_url)
if not body then error(code) end
-- save the content to a file
local f = assert(io.open(update_path, 'w')) -- open in "binary" mode
f:write(body)
f:close()

updateIni = inicfg.load(nil, update_path)
	if tonumber(updateIni.update.commit) > tonumber(scrcommit) then
		print(u8d"Есть обновление! Версия: " .. updateIni.update.version)
		print(u8d"Есть обновление! Версия: " .. updateIni.update.version)
		print(u8d"Есть обновление! Версия: " .. updateIni.update.version)
		update = true
	end
os.remove(update_path)
end
	
newTask(function()
	while true do
		wait(500)
		if update then
			local body, code = https.request(script_url)
			if not body then error(code) end
			-- save the content to a file
			local f = assert(io.open(script_path, 'w')) -- open in "binary" mode
			f:write(body)
			f:close()
				if f then
					print(u8d"Скрипт успешно обновлен!") 
					update = false
				end
			break
		end
	end
end)
