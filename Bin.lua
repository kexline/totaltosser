-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor
-- Approach:

local CollisionFilters = require ("CollisionFilters");

-----------------Bin Object - Parent object of Basket and Box----------------------------

-- score: Variable used to update the player's accuracy
-- itemCntr: Variable that tracks the number of items/number of items for this bin

local Bin = {score = 0, itemCntr = 10}

function Bin:new (o)    --Constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end


function Bin:spawn()
	self.shape = display.newCircle(display.contentCenterX, 200, 65)

	self.shape.pp = self
	self.shape.tag = "trash bin"
	self.shape:setFillColor(1,1,1)
	physics.addBody(self.shape, "static", {filter=CollisionFilters.bin})

	function removeItem(event)
		if (event.phase == "began") then
			if (event.other.tag == "trash") then --Correct bin
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


return Bin