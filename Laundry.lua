-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor

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
	self.shape.score = 1;
	-- physics.addBody(self.shape, "dynamic", {filter=CollisionFilters.laundry});
	physics.addBody(self.shape, "dynamic", {bounce = 0.3, shape = {-32, 25,  20, -25,  30, 5,  -30, -10}, filter=CollisionFilters.laundry});
    self.shape:toBack();

	function itemMove(event)
	   if event.phase == "began" then
	   		-- cancel any previous movement
	   		self.shape:setLinearVelocity( 0, 0 );
	   		self.shape.angularVelocity=0;

	   		self.shape.score = 1;

			self.shape.markX = self.shape.x;
			self.shape.markY = self.shape.y;

			display.getCurrentStage():setFocus( event.target )

		elseif event.phase == "moved" then
			self.updated=true;

            if (self.shape.markX ~= nil) then

				local x = (event.x - event.xStart) + self.shape.markX;
				local y = (event.y - event.yStart) + self.shape.markY;

				self.shape.x = x;
				self.shape.y = y;
				
				if (event.y<midlineYPos) then
					self.shape.score=0;
				end
				
			end
			
		elseif event.phase == "ended" or event.phase =="canceled" then
			-- local x = (event.x - event.xStart);
			-- local y = (event.y - event.yStart);
			
			-- print(event.xStart,event.x,event.yStart,event.y,self.shape.markX,self.shape.markY)
			-- event.target:applyForce(x, y, event.target.x+20, event.target.y+20);

			-- display.getCurrentStage():setFocus(nil)

			local x = (event.x - event.xStart);
			local y = (event.y - event.yStart);

			-- allow player to reposition the item behind the line if it winds up in front of it.
			if self.shape.markY and (self.shape.markY < midlineYPos) then
					if self.shape.y > midlineYPos then
						self.shape.score=1;
					end
			else
				--object:applyForce( xForce, yForce, bodyX, bodyY )
			 	event.target:applyForce(x, y, event.target.x, event.target.y+1); 
			 	-- event.target:applyForce(x, y, event.target.x+20, event.target.y+20); 

			end

			display.getCurrentStage():setFocus(nil)

		end
	end

	self.shape:addEventListener("touch", itemMove);
end


return Laundry;