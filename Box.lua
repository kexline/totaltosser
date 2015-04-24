-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor
-- Approach:
---------------------Box Object - Inherits from Bin-----------------------------------------

local Bin = require("Bin")
local CollisionFilters = require ("CollisionFilters");

----------------- Convenience variables ---------------------------------------------------

local xx = display.contentCenterX; local ww=display.contentWidth;
local yy = display.contentCenterY; local hh=display.contentHeight;

---------------------Box Object - Inherits from Bin-------------------------------------------

local Box = Bin:new({score = 0, itemCntr = 10, binSize = 160, xPos = 0, yPos = 0})
-- score: Used to update the player's accuracy
-- itemCntr: Tracks the number of items for this box
-- binSize: Used for scaling the associated art
-- xPos: X coordinate used for positioning the box
-- yPos: Y coordinate used for positioning the box

function Box:spawn()
	self.shape = display.newImage(binSheet, 3, self.xPos, self.yPos)

	-- Scale the size of the graphic associated with this box
	local a=math.min(self.binSize/250, 250/self.binSize);
	self.shape:scale(a,a-.1);

	self.shape.pp = self
	self.shape.tag = "toy box"

	physics.addBody(self.shape, "static", {filter=CollisionFilters.box,
				    shape = {-82,-50, 72,-50, 72,62, -82,62 }})

		function removeItem(event)
			-- Remove any trash, laundry, or toy that collides with this box
			if (event.phase == "began") then
				if (event.other.tag == "toy") then --Correct bin
					if (event.other.score == 1) then -- Item is not over the midline
						self.score = self.score + 1 --Score increases
						self.itemCntr = self.itemCntr - 1 --One less item
						event.other:removeSelf() --Remove the item
						event.other = nil

					else -- Item was over the midline, score does NOT increase
						self.itemCntr = self.itemCntr - 1 --One less item
						event.other:removeSelf() --Remove the item
						event.other = nil
					end
				else -- Wrong bin
					self.itemCntr = self.itemCntr - 1 --One less item
					event.other:removeSelf() --Remove the item
					event.other = nil
				end
			end

		end

		self.shape:addEventListener("collision", removeItem)

end

return Box;