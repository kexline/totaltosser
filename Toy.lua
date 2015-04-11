-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor
-- Approach:

---------------------Toy Items-------------------------------------------
local Trash = require("Trash");

local CollisionFilters = require ("CollisionFilters");

---------- Sprite Sheet--------
local sheetInfo = require("toySheet")
local toyImages = graphics.newImageSheet("toySheet.png", sheetInfo:getSheet())

local image = 
{
	[1] = "W_Mace014",
	[2] =  "I_Key07",
	[3] =  "I_Mirror",
	[4] =  "S_Magic01",
	[5] =  "S_Water07"
}
----------------------------
local Toy = Trash:new{};

function Toy:spawn(xPos, yPos)
	r = math.random(1,5) -- Generate a random number for a random sprite
	self.shape = display.newImage (toyImages, sheetInfo:getFrameIndex(image[r]));
	
	self.shape.x = xPos
	self.shape.y = yPos

	-- Sprite scale, we can increase or decrease as needed
	self.shape.xScale = 2.5
	self.shape.yScale = 2.5


	self.shape.pp = self;

	self.shape.tag = "toy";
	physics.addBody(self.shape, "dynamic", {filter=CollisionFilters.toy});

	function itemMove(event)
	    	local x = -(event.x - event.target.x);
	 		local y = -(event.y - event.target.y);

	    	event.target:applyForce(x, y, event.target.x, event.target.y);
	end

	self.shape:addEventListener("tap", itemMove);
end


return Toy;