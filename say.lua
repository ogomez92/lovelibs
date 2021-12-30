local Object = require("lib/classic")
local numbersToWords = require("lib/numbers_to_words")
local Say = Object:extend()

function Say:new()
    self.isPlaying = false
    self.currentIndex = 1
    self.prepend = "sounds/speech/en/"
    self.append = ".ogg"
    self.includeAnd = false
    self.wordList = {}
    self.sound = nil
    self.lastIndex = 1
end

function Say:stop()
    if self.sound ~= nil then
        self.sound:stop()
    end
    self.isPlaying = false
    self.currentIndex = 1
    self.wordList = {}
    self.sound = nil
    self.lastIndex = 1
end

function Say:addNumber(number, interrupt)
    local interruptNow = interrupt or false
    if interruptNow then
        self:stop()
    end

    local words = numbersToWords(number, false, self.includeAnd)
    words = string.gsub(words, "%-", " ")
    local numberTable = UtilityFunctions:splitString(words)
    self.wordList = UtilityFunctions:appendToTable(self.wordList, numberTable)
    if not self.isPlaying then
        self.currentIndex = 1
    end

end

function Say:addString(str, interrupt)
    local interruptNow = interrupt or false
    if interruptNow then
        self:stop()
    end

    local words = UtilityFunctions:splitString(str)
    self.wordList = UtilityFunctions:appendToTable(self.wordList, words)
    if not self.isPlaying then
        self.currentIndex = 1
    end
end

function Say:update()
    local temporaryFilename, filename = "", ""
    if #self.wordList < 1 then
        return
    end
    if self.sound ~= nil then
        if not self.sound:isPlaying() then
            self.isPlaying = false
            self.sound = nil
        else
            self.isPlaying = true
            return
        end
    else
        self.isPlaying = false
    end
    local wordsToCheck = ""
    self.lastIndex = #self.wordList
    local continueProcessing = true
    while (continueProcessing) do
        wordsToCheck = table.concat(self.wordList, "_", self.currentIndex, self.lastIndex)
        temporaryFilename = self.prepend .. wordsToCheck .. self.append
        if love.filesystem.getInfo(temporaryFilename) then
            filename = temporaryFilename
            continueProcessing = false
            self.currentIndex = self.lastIndex + 1
        else
            self.lastIndex = self.lastIndex - 1
        end
        if self.lastIndex < 1 then
            continueProcessing = false
        end
    end
    if filename ~= "" then
        self.sound = love.audio.newSource(filename, "stream")
        self.sound:play()
    else
        -- Nothing was found
        self.wordList = {}
    end
end -- function update

return Say
