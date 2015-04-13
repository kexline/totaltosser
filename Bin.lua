-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor
-- Approach:

local CollisionFilters = require ("CollisionFilters");

local Bin = {score = 0, itemCntr = 10}

----------------- Convenience variables -------------------------------------------------

local xx = display.contentCenterX; local ww=display.contentWidth;
local yy = display.contentCenterY; local hh=display.contentHeight;

----------------- Graphics for Targets --------------------------------------------------

binSize=150;

binOpts = {
	frames = {
	{x=75,  y=5, width=145, height=300}, -- bin 
	{x=250, y=5, width=250, height=300}, -- basket
	{x=450, y=5, width=100, height=200} -- basket
	}}

binSheet = graphics.newImageSheet("./images/binSheet.png", binOpts); 

-----------------Bin Object - Parent object of Basket and Box----------------------------

-- score: Variable used to update the player's accuracy
-- itemCntr: Variable that tracks the number of items/number of items for this bin

function Bin:new (o)    --Constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function Bin:spawn()

	-- self.shape = display.newCircle(display.contentCenterX, 200, 65)
	self.shape = display.newImage(binSheet, 1)
	self.shape.x=ww*.3; self.shape.y=200;
	local a=math.min(binSize/250, 250/binSize);
	self.shape:scale(a,a);

	self.shape.pp = self
	self.shape.tag = "trash bin"
	self.shape:setFillColor(1,1,1)
	physics.addBody(self.shape, "static", {filter=CollisionFilters.bin})

	function removeItem(event)
		if (event.phase == "began") then
			if (event.other.tag == "trash") then --Correct bin
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


return Bin;
