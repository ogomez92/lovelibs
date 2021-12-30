NotificationManager = {}
local tts = require("lib/love2talk")
NotificationManager.textToBeDisplayed = ""

function NotificationManager:notify(text)
    NotificationManager.textToBeDisplayed = text
    tts.say(text, true)
end
