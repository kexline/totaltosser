-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor
-- Approach:

---------------------Laundry Item-------------------------------------------
local Trash = require("Trash");

local CollisionFilters = require ("CollisionFilters");

---------- Sprite Sheet--------
local sheetInfo = require("laundrySheet")
local laundryImages = graphics.newImageSheet("laundrySheet.png", sheetInfo:getSheet())

local image = 
{
	[1] = "A_Clothing01",
	[2] =  "A_Clothing02",
	[3] =  "A_Shoes07",
	[4] =  "A_Shoes01",
	[5] =  "C_Elm01"
}


local Laundry = Trash:new{};

function Laundry:spawn(xPos, yPos)
	r = math.random(1,5) -- Generate a random number for a random sprite
	self.shape = display.newImage (laundryImages, sheetInfo:getFrameIndex(image[r]));
	
	self.shape.x = xPos
	self.shape.y = yPos

	-- Sprite scale, we can increase or decrease as needed
	self.shape.xScale = 2.5
	self.shape.yScale = 2.5

	self.shape.pp = self;

	self.shape.tag = "laundry";
	physics.addBody(self.shape, "dynamic", {filter=CollisionFilters.laundry});

	function itemMove(event)
	    	local x = -(event.x - event.target.x);
	 		local y = -(event.y - event.target.y);

	    	event.target:applyForce(x, y, event.target.x, event.target.y);
	end

	self.shape:addEventListener("tap", itemMove);
end


return Laundry;