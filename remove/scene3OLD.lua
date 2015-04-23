-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor
-- Approach:

-----------------------------------Scene 3-----------------------------------

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
----------------------------------------------------------------------------

-------------------Global Variables-----------------------------------------
 local item = {} -- Used for testing purposes
 local itemMove -- Used for testing purposes

local tItems = 30 -- Total items generated
local accuracy = 0 -- Player's accuracy (used in arithmetic, default is 0)
local accuracyN -- Display version of the player's accuracy
local timeLeft = 100000 -- Amount of time left for this level (number is for
					   -- testing purposes)
local timeN -- Display version of the time left
local t1 -- System time when the game begins

local xx = display.contentCenterX
local yy = display.contentCenterY

local trashBin -- Bin object
local basket -- Basket object
local toyBox -- Box object

-----------------------------------------------------------------------------

function scene:create(event)
	local sceneGroup = self.view

	trashBin = Bin:new()
	trashBin:spawn()

	basket = Basket:new()
	basket:spawn()

	toyBox = Box:new()
	toyBox:spawn()

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

	-- Display percent sign (I'm sure there's a better way to do this,
	-- but I'm not sure how. Any ideas?)
	percent = display.newText("%", 354, 43, native.systemFont, 30)
	percent:setFillColor(0,0,0)

	-- Label for the number of items remaining
	remaining = display.newText("Remaining: ", 500, 43, native.systemFont, 30)
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


	---------------Testing purposes only-----------------------------------------------
	---- Generates movable prototype items
	--
	--[[ 	function itemMove(event)
	 	if (event.phase == "began") then		
	 		event.target.markX = event.target.x
	 		event.target.markY = event.target.y 
	 	elseif (event.phase == "moved") then	 	
	 			 local x = (event.x - event.xStart) + event.target.markX
	 			 local y = (event.y - event.yStart) + event.target.markY
	
	    		 event.target.x = x;
	    		 event.target.y = y	
	 	end
	 end

	 for i=0, 9 do
	 	e = display.newCircle(30+i*52, i*5+380, 20)
	 	e:setFillColor(0,0,1)
	 	e.tag = "trash"
	 	physics.addBody(e, "dynamic")
	 	e:addEventListener("touch", itemMove)
	 	item[i] = e
	 end

	 for j=0, 7 do
	 	e1 = display.newCircle(70*j+32, j*6+300, 20)
	 	e1:setFillColor(1,1,0)
	 	e1.tag = "toy"
	 	physics.addBody(e1, "dynamic")
	 	e1:addEventListener("touch", itemMove)
	 end

	 	for j=0, 11 do
	 	e2 = display.newCircle(50*j+45, j*7+325, 20)
	 	e2:setFillColor(1,0,1)
	 	e2.tag = "laundry"
	 	physics.addBody(e2, "dynamic")
	 	e2:addEventListener("touch", itemMove)
	 end
	------------------------------------------------------------------------------------
	]]

end

function scene:show (event)
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then

	elseif (phase == "did") then

		t1 = system.getTimer() -- Save the current time

		-- nextScene: Called when the player wins the game. Provides the option to re-try the
		-- current level or restart from level 1.
		local function nextScene()
			print("You won!")

			local winBox = display.newRoundedRect(xx, yy, 450, 500,7)
			winBox:setFillColor(0.65,0.65,0.65)
			winBox.alpha = 0.7 -- Transparency

			local winText1 = display.newText("You won!", xx, yy-185, native.systemFont, 35)
			winText1:setFillColor(0,0,0)

			local winText2 = display.newText("Congratulations!", xx, yy-100, native.systemFont, 30)
			winText2:setFillColor(0,0,0)

			local winText3 = display.newText("Would you like to play again?", xx, yy-60, native.systemFont, 30)
			winText3:setFillColor(0,0,0)

			--composer.gotoScene("scene4")

			----------- Button to restart the level-------------
			-- btnAgain = widget.newButton(
			-- {
			-- 	x = xx,
			-- 	y = yy,
			-- 	id = "try again",
			-- 	label = "Level 3",
			-- 	labelColor = {default={0,0,0}, over={1,1,1}},
			-- 	sheet = buttonSheet,
			-- 	defaultFrame = 1,
			-- 	overFrame = 2,
			-- 	onEvent = restart,
			-- 	}
			-- 	)

			----------- Button to start the game over from Level 1-------------
			-- btnNew = widget.newButton(
			-- {
			-- 	x = xx,
			-- 	y = yy,
			-- 	id = "new game",
			-- 	label = "New Game",
			-- 	labelColor = {default={0,0,0}, over={1,1,1}},
			-- 	sheet = buttonSheet,
			-- 	defaultFrame = 1,
			-- 	overFrame = 2,
			-- 	onEvent = newGame,
			-- 	}
			-- 	)
		end

		-- gameOver: Called when the player runs out of time. Displays a message and
		-- provides a button to try again. Contains a nested function (restart), which 
		-- will remove display objects and reset variables where applicable.
		local function gameOver()
			print("You ran out of time!")

			local overBox = display.newRoundedRect(xx, yy, 450, 500,7)
			overBox:setFillColor(0.65,0.65,0.65)
			overBox.alpha = 0.7 -- Transparency

			local overText1 = display.newText("Game over!", xx, yy-185, native.systemFont, 35)
			overText1:setFillColor(0,0,0)

			local overText2 = display.newText("You ran out of time.", xx, yy-100, native.systemFont, 30)
			overText2:setFillColor(0,0,0)

			local overText3 = display.newText("Would you like to play again?", xx, yy-60, native.systemFont, 30)
			overText3:setFillColor(0,0,0)

			-- btnAgain = widget.newButton(
			-- {
			-- 	x = xx,
			-- 	y = yy,
			-- 	id = "try again",
			-- 	label = "Try again",
			-- 	labelColor = {default={0,0,0}, over={1,1,1}},
			-- 	sheet = buttonSheet,
			-- 	defaultFrame = 1,
			-- 	overFrame = 2,
			-- 	onEvent = restart,
			-- 	}
			-- 	)

			local function restart(event)
				-- Reset variables to default values

				-- Remove display objects/text
				display.remove(overBox)
				overBox = nil
				display.remove(overText1)
				overText1 = nil
				display.remove(overText2)
				overText2 = nil
				display.remove(overText3)
				overText3 = nil
				-- display.remove(btnAgain)
				-- btnAgain = nil

				--Call this scene again

			end
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
			timeLeft = (100000 + t1 - system.getTimer())/1000

			-- Format timeLeft to one decimal place
			timeN.text = string.format("%.1f", timeLeft)

			-- No time left
			if (timeLeft <= 0.0) then
				gameOver()
				Runtime:removeEventListener("enterFrame", updateAccuracy)
			end

			-- No items left
			if (itemsLeft <= 0) then
				nextScene()
				Runtime:removeEventListener("enterFrame", updateAccuracy)
			end

		end

		Runtime:addEventListener("enterFrame", updateAccuracy)
	end

end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)

return scene
