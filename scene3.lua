-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor
-- Approach:

-----------------------------------Scene 3-----------------------------------
local CollisionFilters = require ("CollisionFilters");
local composer = require("composer")
local scene = composer.newScene()
local physics = require("physics")
local widget = require("widget")

physics.start()
physics.setGravity(0,0)

-----------------------Objects----------------------------------------------
local Bin = require("Bin")
local Basket = require("Basket")
local Box = require("Box")

local Trash = require("Trash");
local Laundry = require("Laundry");
local Toy = require("Toy");

local Walls = require("Walls");

---------- Graphics ---------------------------------------------------------
local btnOptions = { 
    frames = {    
     { x = 0, y =15, width = 322, height = 65},  -- 1 clean huge
     { x = 322, y =15, width = 314, height = 65},  -- clean huge light
     { x = 0, y =535, width = 179, height = 65},  -- 3 tutorial huge
    { x = 322, y =532, width = 179, height = 65},  -- tutorial huge light
    { x = 0, y =756, width = 179, height = 65},  -- 5 credits huge
    { x = 322, y =756, width = 179, height = 65},  -- credits huge light
    { x = 0, y = 238, width = 139, height = 67}, -- 7 Home
    { x = 322, y = 239, width = 139, height = 67}, -- Home light
    { x = 0, y =85, width = 183, height = 68},  -- 9 continue huge
    { x = 322, y =85, width = 183, height = 68},  -- continue huge light
    { x = 0, y =156, width = 138, height = 70},  -- 11 Retry huge
    { x = 322, y =156, width = 138, height = 70},  -- Retry huge light

}}

local btnSheet = graphics.newImageSheet( "./images/btnSheet_l.png", btnOptions );

-------------------Global Variables-----------------------------------------
 local items = {} -- Holds the trash objects
 local laundryitems={} -- Holds the laundry objects
 local toyitems={} -- Holds the toy objects

local numChildren = 10 -- Total number of children for the trash, laundry, & toys
local tItems = 30 -- Total items generated
local accuracy = 0 -- Player's accuracy (used in arithmetic, default is 0)
local accuracyN -- Display version of the player's accuracy
local timeLeft = 65000 -- Amount of time left for this level
local timeN -- Display version of the time left
local t1 -- System time when the game begins

-- Convenience variables--
local xx = display.contentCenterX; local ww=display.contentWidth;
local yy = display.contentCenterY; local hh=display.contentHeight;

local trashBin -- Bin object
local basket -- Basket object
local toyBox -- Box object

-----------------------------------------------------------------------------

function scene:create(event)
    local sceneGroup = self.view

    -- Create the containers
    trashBin = Bin:new({xPos=100, yPos=200})
    trashBin:spawn()

    basket = Basket:new({xPos=ww*.85, yPos=210})
    basket:spawn()

    toyBox = Box:new()
    toyBox:spawn()

    ------ Background
    -- local bg = display.newImage ("./images/bedroom_v.png", ".",0,0, 1);
    -- bg.anchorX=0; bg.anchorY=0;
    -- bg:scale(.72,.72);
    -- bg:toBack();
    -- sceneGroup:insert(bg);


    -- Score bar on top
    local topBar = display.newRect(0, 80, display.contentWidth,100)
    topBar:setFillColor(0.65, 0.65, 0.65)
    topBar:toBack()
    topBar.anchorX = 0; topBar.anchorY = 70

    -- Label for the player's accuracy
    local accuracyT = display.newText("Accuracy: ", 200, 43, native.systemFont, 30)
    accuracyT:setFillColor(0,0,0)

    -- Displayed accuracy number
    accuracyN = display.newText(accuracy, 300, 43, native.systemFont, 30)
    accuracyN:setFillColor(0,0,0)

    -- Display percent sign
    local percent = display.newText("%", 354, 43, native.systemFont, 30)
    percent:setFillColor(0,0,0)

    -- Label for the number of items remaining
    local remaining = display.newText("Remaining: ", 500, 43, native.systemFont, 30)
    remaining:setFillColor(0,0,0)

    -- Number of items remaining
    remainingN = display.newText(trashBin.itemCntr, 590, 43, native.systemFont, 30)
    remainingN:setFillColor(0,0,0)

    -- Score bar on bottom
    local botBar = display.newRect(0, 1300, display.contentWidth, 100)
    botBar:setFillColor(0.65, 0.65, 0.65)
    botBar:toBack()
    botBar.anchorX = 0; botBar.anchorY = 1300

    -- Label for the time left
    local timeT = display.newText("Time left: ", xx, 1245, native.systemFont, 30)
    timeT:setFillColor(0,0,0)

    -- Displayed time left
    timeN = display.newText(timeLeft, xx+100, 1245, native.systemFont, 30)
    timeN:setFillColor(0,0,0)

    -- Create the walls
    walls = Walls:new();
    walls:spawn();

    -- Add the display objects to sceneGroup
    sceneGroup:insert(topBar)
    sceneGroup:insert(botBar)
    sceneGroup:insert(accuracyT)
    sceneGroup:insert(accuracyN)
    sceneGroup:insert(percent)
    sceneGroup:insert(remaining)
    sceneGroup:insert(remainingN)
    sceneGroup:insert(timeT)
    sceneGroup:insert(timeN)

end

function scene:show (event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

    -- Create the items, randomly position them, and insert them into their respective
    -- tables
    function createTrash(i)
        local trash = Trash:new();
        local a = math.random(50, 670)
        local b = math.random (midlineYPos+20, 1150)
        trash:spawn(a, b);
        trash.shape:toFront();
        items[i]=trash;
        sceneGroup:insert(trash.shape);
    end

    function createLaundry(i)
        local laundry = Laundry:new();
        local a = math.random(50, 670)
        local b = math.random (midlineYPos+20, 1150)
        laundry:spawn(a, b);
        laundry.shape:toFront();
        laundryitems[i]=laundry;
        sceneGroup:insert(laundry.shape);

    end

    function createToy(i)
        local toy = Toy:new();
        local a = math.random(50, 670)
        local b = math.random (midlineYPos+20, 1150)
        toy:spawn(a,b);
        items[20+i]=toy;
        toy.shape:toFront();
        toyitems[i]=toy;
        sceneGroup:insert(toy.shape);
    end

    elseif (phase == "did") then

        -- Create containers again if they were deleted.
        if (trashBin == nil) then
            trashBin = Bin:new({xPos=100, yPos=200})
            trashBin:spawn()
        end

        if (basket == nil) then
            basket = Basket:new({xPos=ww*.85, yPos=210})
            basket:spawn()
        end

        if (toyBox == nil) then
            toyBox = Box:new()
            toyBox:spawn()
        end

        -- Create ten of each item (trash, laundry, and toys)
        for i=0, 9 do
             createTrash(i)
             createLaundry(i)
             createToy(i)
        end

        t1 = system.getTimer() -- Save the current time

        -- nextScene: Called when the player wins the game. Provides the option to re-try the
        -- current level or restart the game.
        local function nextScene()
            local winBox = display.newRoundedRect(xx, yy, 450, 500,7)
            winBox:setFillColor(0.65,0.65,0.65)
            winBox.alpha = 0.75

            local winText1 = display.newText("You won!", xx, yy-185, native.systemFont, 35)
            winText1:setFillColor(0,0,0)

            local winText2 = display.newText("Congratulations!", xx, yy-100, native.systemFont, 30)
            winText2:setFillColor(0,0,0)

            local winText3 = display.newText("Would you like to play again?", xx, yy-60, native.systemFont, 30)
            winText3:setFillColor(0,0,0)

            local function restart(event) -- Restarts the current scene

                -- Remove display objects, text, and buttons
                display.remove(winBox)
                winBox = nil
                display.remove(winText1)
                winText1 = nil
                display.remove(winText2)
                winText2 = nil
                display.remove(winText3)
                winText3 = nil
                display.remove(btnAgain)
                btnAgain = nil
                display.remove(btnNew)
                btnNew=nil
                display.remove(btnNext)
                btnNext=nil

                -- Remove the containers
                display.remove(trashBin.shape)
                trashBin = nil
                display.remove(basket.shape)
                basket = nil
                display.remove(toyBox.shape)
                toyBox = nil

                -- Call the scene again
                composer.gotoScene("scene3")

            end

            local function newGame() -- Goes back to welcome screen
                -- Remove the walls
                walls:rmv()
                walls = nil

                -- Remove display objects, text, and buttons
                display.remove(winBox)
                winBox = nil
                display.remove(winText1)
                winText1 = nil
                display.remove(winText2)
                winText2 = nil
                display.remove(winText3)
                winText3 = nil
                display.remove(btnAgain)
                btnAgain = nil
                display.remove(btnNew)
                btnNew=nil
                display.remove(btnNext)
                btnNext=nil

                -- Remove the containers
                display.remove(trashBin.shape)
                trashBin = nil
                display.remove(basket.shape)
                basket = nil
                display.remove(toyBox.shape)
                toyBox = nil

                -- If scene1 already exists, destroy it
                if (scene1 ~= nil) then
                    composer.removeScene("scene1")
                end

                -- If scene2 already exists, destroy it
                if (scene2 ~= nil) then
                    composer.removeScene("scene2")
                end

                composer.gotoScene("welcome")
            end

            local function nextLevel()
                -- Remove display objects, text, and buttons
                display.remove(winBox)
                winBox = nil
                display.remove(winText1)
                winText1 = nil
                display.remove(winText2)
                winText2 = nil
                display.remove(winText3)
                winText3 = nil
                display.remove(btnAgain)
                btnAgain = nil
                display.remove(btnNew)
                btnNew=nil
                display.remove(btnNext)
                btnNext=nil

                -- Remove the containers
                display.remove(trashBin.shape)
                trashBin = nil
                display.remove(basket.shape)
                basket = nil
                display.remove(toyBox.shape)
                toyBox = nil

                --composer.gotoScene("scene4")
            end

            ----------- Button to restart the level-------------
             btnAgain = widget.newButton(
             {
                 x = xx,
                 y = yy,
                 id = "restart",
                 sheet = btnSheet,
                 defaultFrame = 11,
                 overFrame = 12,
                 onEvent = restart,
                 }
                 )

            ----------- Button to start the game over -------------
             btnNew = widget.newButton(
             {
                 x = xx,
                 y = yy+80,
                 id = "home",
                 sheet = btnSheet,
                 defaultFrame = 7,
                 overFrame = 8,
                 onEvent = newGame,
                 }
                 )

             ----------- Button to go to next level-------------
             btnNext = widget.newButton(
             {
                 x = xx,
                 y = yy+160,
                 id = "level 3",
                 sheet = btnSheet,
                 defaultFrame = 9,
                 overFrame = 10,
                 onEvent = nextLevel,
                 }
                 )
        end

        -- gameOver: Called when the player runs out of time. Displays a message and
        -- provides a button to try again. Contains a nested function (restart), which 
        -- will remove display objects and reset variables where applicable.
        local function gameOver()

            local overBox = display.newRoundedRect(xx, yy, 465, 500,7)
            overBox:setFillColor(0.65,0.65,0.65)
            overBox.alpha = 0.75

            local overText1 = display.newText("Game over!", xx, yy-185, native.systemFont, 35)
            overText1:setFillColor(0,0,0)

            local overText2 = display.newText(reason, xx, yy-100, native.systemFont, 30)
            overText2:setFillColor(0,0,0)

            local overText3 = display.newText("Would you like to play again?", xx, yy-60, native.systemFont, 30)
            overText3:setFillColor(0,0,0)

            local function restart(event)

                -- Remove display objects, text, and buttons
                display.remove(overBox)
                overBox = nil
                display.remove(overText1)
                overText1 = nil
                display.remove(overText2)
                overText2 = nil
                display.remove(overText3)
                overText3 = nil
                display.remove(btnAgain)
                btnAgain = nil

                -- Remove any items that are still on screen
                for i=0, numChildren-1 do
                    display.remove(items[i].shape)
                    items[i] = nil

                    display.remove(laundryitems[i].shape)
                    laundryitems[i] = nil

                    display.remove(toyitems[i].shape)
                    toyitems[i] = nil
                end

                -- Remove the containers
                display.remove(trashBin.shape)
                trashBin = nil
                display.remove(basket.shape)
                basket = nil
                display.remove(toyBox.shape)
                toyBox = nil

                --Call this scene again
                composer.gotoScene("scene3")
            end

            ----------- Button to restart the level-------------
            btnAgain = widget.newButton(
            {
                 x = xx,
                 y = yy+45,
                 id = "try again",
                 sheet = btnSheet,
                 defaultFrame = 11,
                 overFrame = 12,
                 onEvent = restart,
                 }
                )
        end

        -- updateAccuracy: Continuously updates values cooresponding to the score bar and
        -- calls gameOver() or nextScene() if appropriate.
        local function updateAccuracy(event)
            -- Calculate accuracy
            local tScore = trashBin.score + basket.score + toyBox.score
            accuracy = (tScore/tItems)*100

            -- Format accuracy to one decimal place
            accuracyN.text = string.format("%.1f", accuracy)

            -- Update remaining items
            local itemsLeft = trashBin.itemCntr + basket.itemCntr + toyBox.itemCntr
            remainingN.text = itemsLeft

            -- Determine the time left and convert it to seconds
            timeLeft = (65000 + t1 - system.getTimer())/1000

            -- Format timeLeft to one decimal place
            timeN.text = string.format("%.1f", timeLeft)

            -- Player is out of time
            if (timeN.text == "0.0") then
                reason = "You ran out of time."
                gameOver()
                Runtime:removeEventListener("enterFrame", updateAccuracy)
            end

            -- No items are left
            if (itemsLeft == 0) then
                if (accuracy >=50) then
                    nextScene() -- High enough accuracy to continue
                else 
                    reason = "Your accuracy was less than 50%."
                    gameOver() -- Accuracy wasn't high enough; try again!
                end
                Runtime:removeEventListener("enterFrame", updateAccuracy)
            end

        end

        Runtime:addEventListener("enterFrame", updateAccuracy)
    end

end

function scene:hide(event)
    local phase=event.phase;
    local sceneGroup = self.view;

    if phase=="will" then
    
    elseif phase=="did" then

    end
end

function scene:destroy(event)
    local phase=event.phase;
    local sceneGroup = self.view;
    sceneGroup:removeSelf();
    sceneGroup=nil;
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)


return scene
