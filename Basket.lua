-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor
-- Approach:

---------------------Basket Object - Inherits from Bin----------------------------------

local Bin = require("Bin")

local CollisionFilters = require ("CollisionFilters");

local Basket = Bin:new({itemCntr = 12}) -- Number of items generated for this bin.

function Basket:spawn()
	self.shape = display.newRect(display.contentCenterX-210, 165, 165, 110)

	self.shape.pp = self
	self.shape.tag = "basket"
	self.shape:setFillColor(1,0,1)
	physics.addBody(self.shape, "static", {filter=CollisionFilters.basket})

		function removeItem(event)
			if (event.phase == "began") then
				if (event.other.tag == "laundry") then --Correct bin
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




return Basket