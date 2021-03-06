-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor

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
	self.shape.score = 1;
	--  physics.addBody(self.shape, "dynamic", {filter=CollisionFilters.toy});
	physics.addBody(self.shape, "dynamic", {bounce = 0.3, shape = {-32, 25,  20, -25,  30, 5,  -30, -10}, filter=CollisionFilters.toy});
    self.shape:toBack()

	function itemMove(event)
	   if event.phase == "began" then
	   		 -- cancel any previous movement
	   		self.shape:setLinearVelocity( 0, 0 );
	   		self.shape.angularVelocity=0;

	   		self.shape.score = 1;

			self.shape.markX = self.shape.x;
			self.shape.markY = self.shape.y;
			print("BEGAN: ",event.xStart,event.yStart) -- checking to make sure xStart and yStart don't change

			display.getCurrentStage():setFocus( event.target )

		elseif event.phase == "moved" then
			self.updated=true;

			if (self.shape.markX ~= nil) then

			local x = (event.x - event.xStart) + self.shape.markX;
				local y = (event.y - event.yStart) + self.shape.markY;

				self.shape.x = x;
				self.shape.y = y;

				if (event.y < midlineYPos) then
					self.shape.score=0;
				end
			end
			
		elseif event.phase == "ended" or event.phase =="canceled" then
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


return Toy;