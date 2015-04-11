-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor
-- Approach:

local CollisionFilters = require ("CollisionFilters");

---------------------Box Object - Inherits from Bin-------------------------------------------

local Bin = require("Bin")

local Box = Bin:new({itemCntr = 8}) -- Number of items generated for this bin.

function Box:spawn()
	self.shape = display.newRect(display.contentCenterX+200, 165, 125, 125)

	self.shape.pp = self
	self.shape.tag = "toy box"
	self.shape:setFillColor(1,1,0)
	physics.addBody(self.shape, "static", {filter=CollisionFilters.box})

		function removeItem(event)
			if (event.phase == "began") then
				if (event.other.tag == "toy") then --Correct bin
					self.score = self.score + 1 --Score increases
					self.itemCntr = self.itemCntr - 1 --One less item
					event.other:removeSelf() --Remove the item
					event.other = nil
				else --Wrong bin
					self.itemCntr = self.itemCntr - 1 --One less item
					event.other:removeSelf() --Remove the item
					event.other = nil
				end
			end

		end

		self.shape:addEventListener("collision", removeItem)

end




return Box