-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor
-- Approach:

---------------------Basket Object - Inherits from Bin----------------------------------

local Bin = require("Bin")
local CollisionFilters = require ("CollisionFilters");

----------------- Convenience variables -------------------------------------------------

local xx = display.contentCenterX; local ww=display.contentWidth;
local yy = display.contentCenterY; local hh=display.contentHeight;

----------- Basekt Object --------------------------------------------------------------

local Basket = Bin:new({itemCntr = 10, binSize=120}) -- Number of items generated for this bin.

function Basket:spawn()
	--self.shape = display.newRect(display.contentCenterX-210, 165, 165, 110)

	self.shape = display.newImage(binSheet, 2)
	self.shape.x=ww*.8; self.shape.y=210;
	local a=math.min(self.binSize/250, 250/self.binSize);
	self.shape:scale(a,a-.1);

	self.shape.pp = self
	self.shape.tag = "basket"
--	physics.addBody(self.shape, "static", {filter=CollisionFilters.basket})
	physics.addBody(self.shape, "static", {filter=CollisionFilters.basket,
        shape = {-50,-50, 48,-50, 48,56, -50,56 }})

		function removeItem(event)
			print(string.format("Remove Item:  Basket caught %s", event.other.tag))
			if (event.phase == "began") then

				if (event.other.tag == "laundry") then --Correct bin
					if (event.other.score ==1) then
						self.score = self.score + 1 --Score increases
						self.itemCntr = self.itemCntr - 1 --One less item
						event.other:removeSelf() --Remove the item
						event.other = nil
					else
						self.itemCntr = self.itemCntr - 1 --One less item
						event.other:removeSelf() --Remove the item
						event.other = nil
				end
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
