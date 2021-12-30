# Introduction

This project contains a few libraries to make audiogame creation with love2d easier.

These have been tested using love2d but you might be able to get it to work in other similar Lua environments

Most of the libraries will require [Lua Classic](https://github.com/rxi/classic)
By default it looks for classic in the folder "lib" inside your project so if you use a different structure you might want to change any includes to your own folder structure if it causes errors.

Here are the libraries currently available.

## Say

Say is a snumber and string speaker. It will speak numbers, either positive or negative, as well as strings.

### Usage

```lua
local Say = require("lib/say") -- require the library

-- in main.load, create a new instance:
local say = Say:new() -- create new instance of say
say.prepend = "sounds/english/"
say.append=".ogg" --or any extension supported by love2d
say.includeAnd=true --this tells lua whether to include the word "and" when processing numbers
```

Anywhere in your game just add numbers or strings:

```lua
say:addString("your_score") -- this will load sounds/english/your_score.ogg
say:adNumber(player.score)
say:addString("points")
say:addString("level")
say:addNumber(player.level)
```

In order for the library to work you need to hook it to the update function,  like love.update or any screen manager or state machine you might be using, simply do:

```lua
function love.update()
say:update() --pass it update function from the instance, doesn't need dt.
```

You may also interrupt the speech, such as when processing keypresses, make it speak your score and stop whatever its doing:

```lua
function love.keypressed(key)
    if key == "a" then
        say:addString("points", true) -- true as in interrupt true
    end

end
```

## Utility Functions

Currently the following utility functions have been included in this package, just requrie it and it should be a global variable for use anywhere in your project

```lua
require("lib/utils")

UtilityFunctions:distance2d(player.x, player.y, enemy.x, enemy.y) -- returns the distance between 2 2d objects

UtilityFunctions:checkCollision(player, enemy) --returns true if 2 objects collide, assumes both objects have x, y, height, width

UtilityFunctions:checkCollision1d(a, b) -- returns true if x position between 2 objects matches

UtilityFunctions:realRandom(min, max) -- helper function to return a random floating point number between 2 values

UtilityFunctions:splitString(input, separator) -- function to split a string into a table, not available in the lua standard library

UtilityFunctions:apendToTable(tableToModify, tableToAppend) -- apends the second table to the first table
```

## Notification Manager

Notification Manager uses love2talk and love.graphics to both speak and draw text. By default it is exported as a global var, for convenience but you can always choose to make it local

### Usage

```lua
require("notification_manager")
-- in your game
NotificationManager:notify("Your score is 10000 points")

-- You also need to add this to love.draw, like this:
function love.draw()
    local dimX, dimY = love.graphics.getDimensions()

    love.graphics.push()
    love.graphics.scale(dimX / defaultGameResolution.x, dimY / defaultGameResolution.y)
    love.graphics.pop()
    love.graphics.printf(NotificationManager.textToBeDisplayed, 100, 100, 150, "center")
end

```