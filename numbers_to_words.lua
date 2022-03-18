local oneslist = {
    [0] = "",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine"
}
local teenlist = {
    [0] = "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen"
}
local tenslist = {
    [0] = "",
    "",
    "twenty",
    "thirty",
    "forty",
    "fifty",
    "sixty",
    "seventy",
    "eighty",
    "ninety"
}
local lionlist = {
    [0] = "",
    "thousand",
    "million",
    "billion",
    "trillion",
    "quadrillion",
    "quintillion",
    "sextillion",
    "septillion",
    "octillion",
    "nonillion",
    "decillion"
}
local abs, floor = math.abs, math.floor

local function convert(num, dashes, includeAnd)
    local includeDashes = dashes or true
    local includedAnd = includeAnd or false
    if (num == 0) then
        return "zero"
    end
    local absnum, lion, result = abs(num), 0, ""
    local function dashed(s)
        return s == "" and s or "-" .. s
    end
    local function spaced(s)
        return s == "" and s or " " .. s
    end
    while (absnum > 0) do
        local word, ones, tens, huns = "", absnum % 10, floor(absnum / 10) % 10, floor(absnum / 100) % 10
        if (tens == 0) then
            word = oneslist[ones]
        elseif (tens == 1) then
            word = teenlist[ones]
        else
            if includeDashes == true then
                word = tenslist[tens] .. dashed(oneslist[ones])
            else
                word = tenslist[tens] .. spaced(oneslist[ones])
            end
        end
        if (huns > 0) then
            if (tens > 0 or ones > 0) and includedAnd then
                word = oneslist[huns] .. " hundred and" .. spaced(word)
            else
                word = oneslist[huns] .. " hundred" .. spaced(word)
            end
        end
        if (word ~= "") then
            result = word .. spaced(lionlist[lion]) .. spaced(result)
        end
        absnum = floor(absnum / 1000)
        lion = lion + 1
    end
    if (num < 0) then
        result = "minus " .. result
    end
    return result
end
return convert
