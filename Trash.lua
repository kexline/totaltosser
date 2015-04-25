-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor

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

	local j=1;
	if math.random(0,1)==0 then j=-1; end
	self.shape.xScale = j*2.5;  
	self.shape.yScale = 2.5
	self.shape:rotate(math.random(-45,45));

	self.shape.pp = self;

	self.shape:setFillColor(1,1,1);
	self.shape.tag = "trash";
	self.shape.score = 1;
	physics.addBody(self.shape, "dynamic", {bounce = 0.3, shape = {-32, 25,  20, -25,  30, 5,  -30, -10}, filter=CollisionFilters.trash});
    self.shape:toBack()

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

function Trash:spawnStatic(xPos, yPos)
	r = math.random(1,5) -- Generate a random number for a random sprite
	self.shape = display.newImage (trashImages, sheetInfo:getFrameIndex(image[r]));
	--display.newImage(trashImages, sheetInfo:getFrameIndex("I_FishTail"))
	self.shape.x = xPos; self.shape.y = yPos; 
	local j=1;

	if math.random(0,1)==0 then j=-1; end
	self.shape.xScale = j*2.5;  
	self.shape.yScale = 2.5
	self.shape:rotate(math.random(-45,45));

	self.shape.pp = self;

	self.shape:setFillColor(1,1,1);
    self.shape:toBack()
end


return Trash;