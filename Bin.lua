-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor

-----------------Bin Object - Parent object of Basket and Box----------------------------

local CollisionFilters = require ("CollisionFilters");

----------------- Convenience variables -------------------------------------------------

local xx = display.contentCenterX; local ww=display.contentWidth;
local yy = display.contentCenterY; local hh=display.contentHeight;

----------------- Graphics for Targets --------------------------------------------------

binOpts = {
	frames = {
	{x=75,  y=5, width=145, height=300}, -- Bin 
	{x=255, y=5, width=235, height=300}, -- Basket
	{x=526, y=5, width=262, height=300} -- Box
	}}

binSheet = graphics.newImageSheet("./images/binSheet.png", binOpts); 
-------------------------------------------------------------------------------------------

local Bin = {score = 0, itemCntr = 10, binSize=150, xPos = 0, yPos = 0}
-- score: Used to update the player's accuracy
-- itemCntr: Tracks the number of items for this bin
-- binSize: Used for scaling the associated art
-- xPos: X coordinate used for positioning the bin
-- yPos: Y coordinate used for positioning the bin

function Bin:new (o)
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function Bin:spawn()
	self.shape = display.newImage(binSheet, 1, self.xPos, self.yPos)

	-- Scale the size of the graphic associated with this bin
	local a=math.min(self.binSize/250, 250/self.binSize);
	self.shape:scale(a,a);

	self.shape.pp = self
	self.shape.tag = "trash bin"

	physics.addBody(self.shape, "static", {filter=CollisionFilters.bin, 
					shape = {-43,-50, 42,-50, 42,62, -43,62 }})

	function removeItem(event)
		-- Remove any trash, laundry, or toy that collides with this bin
		if (event.phase == "began") then
			if (event.other.tag == "trash") then --Correct bin
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


return Bin;