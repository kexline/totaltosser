-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor
-- Approach:

local CollisionFilters = require ("CollisionFilters");

local sheetInfo = require("trashSheet")
local trashImages = graphics.newImageSheet("trashSheet.png", sheetInfo:getSheet())

local image = 
{
	[1] = "I_FishTail",
	[2] =  "I_Bone",
	[3] =  "I_C_Fish",
	[4] =  "I_ScorpionClaw",
	[5] =  "I_WolfFur"
}
---------------------Trash Object -------------------------------------------

local Trash = {};

function Trash:new (o)    --Constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end


function Trash:spawn(xPos, yPos)
	r = math.random(1,5) -- Generate a random number for a random sprite
	self.shape = display.newImage (trashImages, sheetInfo:getFrameIndex(image[r]));
	--display.newImage(trashImages, sheetInfo:getFrameIndex("I_FishTail"))
	self.shape.x = xPos
	self.shape.y = yPos
	self.shape.xScale = 2.5
	self.shape.yScale = 2.5

	self.shape.pp = self;

	self.shape:setFillColor(1,1,1);
	self.shape.tag = "trash";
	-- physics.addBody(self.shape, "dynamic", {filter=CollisionFilters.trash});
	physics.addBody(self.shape, "dynamic"); 

	function itemMove(event)
	    	--local x = -(event.x - event.target.x);
	 		--local y = -(event.y - event.target.y);

	    	--event.target:applyForce(x, y, event.target.x, event.target.y);
   	
	    if event.phase == "began" then
			self.shape.markX = self.shape.x;
			self.shape.markY = self.shape.y;
			event.target:setLinearVelocity(0,0);
			print("began: markX=%d, markY=%d", markX, markY)



		elseif event.phase == "moved" then
			-- drag the item
			self.updated=true;

			-- markX = markX or self.shape.x;
			-- markY = markX or self.shape.y;

			local x = (event.x - event.xStart) + self.shape.markX;
			local y = (event.y - event.yStart) + self.shape.markY;

			self.shape.x = x;
			self.shape.y = y;
			print("Moved: x=%d, y=%d", x, y)


		elseif event.phase == "ended" then
		--  poke the item

		-- 	self.updated=true;
		--local vector={x=(event.x - self.shape.markX),y=(event.y - self.shape.markY)}
		local vector={x=(self.shape.x - self.shape.markX),y=(self.shape.y - self.shape.markY)}

		-- 	local x = (event.x - event.xStart) + self.shape.markX;
		-- 	local y = (event.y - event.yStart) + self.shape.markY;

		  -- event.target:applyForce(x, y, event.target.x-20, event.target.y-20);
		  print(string.format("applyforce %d %d %d %d", vector.x,vector.y, self.shape.x, self.shape.y))
		  event.target:applyForce(vector.x,vector.y, self.shape.x, self.shape.y)
		end
	end

	self.shape:addEventListener("touch", itemMove);
end


return Trash;