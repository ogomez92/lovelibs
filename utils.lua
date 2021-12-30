UtilityFunctions = {}

function UtilityFunctions:distance2d(jx, jy, kx, ky)
    return math.sqrt(((jx - kx) * (jx - kx)) + ((jy - ky)) * (jy - ky));
end

function UtilityFunctions.checkCollision1d(a, b)
    local a_left = a.x
    local a_right = a.x + a.width
    local b_left = b.x
    local b_right = b.x + b.width
    if a_right > b_left and a_left < b_right then
        return true
    else
        return false
    end
end

function UtilityFunctions.checkCollision(a, b)
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bottom = a.y + a.height
    local b_left = b.x
    local b_right = b.x + b.width
    local b_top = b.y
    local b_bottom = b.y + b.height

    if a_right > b_left and a_left < b_right and a_bottom > b_top and a_top < b_bottom then
        return true
    else
        return false
    end
end

function UtilityFunctions:realRandom(min, max)
    return love.math.random() * (max - min) + min
end

function UtilityFunctions:splitString(inputstr, sep, prepend)
    prep = prepend or ""
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, prep..str)
    end
    return t
end

function UtilityFunctions:appendToTable(tableToModify, tableToAppend)
    for i = 1, #tableToAppend do
        tableToModify[#tableToModify + 1] = tableToAppend[i]
    end
    return tableToModify
end