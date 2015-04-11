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
	-- physics.addBody(self.shape, "dynamic", {filter=CollisionFilters.laundry});
	physics.addBody(self.shape, "dynamic", {bounce = 0.3, shape = {-32, 25,  20, -25,  30, 5,  -30, -10}, filter=CollisionFilters.laundry});
    self.shape:toBack();

	function itemMove(event)
	   if event.phase == "began" then
	   		-- cancel any previous movement
	   		self.shape:setLinearVelocity( 0, 0 );
	   		self.shape.angularVelocity=0;

			self.shape.markX = self.shape.x;
			self.shape.markY = self.shape.y;
			print("BEGAN: ",event.xStart,event.yStart) -- checking to make sure xStart and yStart don't change

		elseif event.phase == "moved" then
			self.updated=true;

			local x = (event.x - event.xStart) + self.shape.markX;
			local y = (event.y - event.yStart) + self.shape.markY;

			self.shape.x = x;
			self.shape.y = y;
			
		elseif event.phase == "ended" then
			local x = (event.x - event.xStart);
			local y = (event.y - event.yStart);
			
			print(event.xStart,event.x,event.yStart,event.y,self.shape.markX,self.shape.markY)
			event.target:applyForce(x, y, event.target.x+20, event.target.y+20);
		end
	end

	self.shape:addEventListener("touch", itemMove);
end


return Laundry;