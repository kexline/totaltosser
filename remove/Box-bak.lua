-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor
-- Approach:

local CollisionFilters = require ("CollisionFilters");
local Bin = require("Bin")

----------------- Convenience variables -------------------------------------------------

local xx = display.contentCenterX; local ww=display.contentWidth;
local yy = display.contentCenterY; local hh=display.contentHeight;

----------------- Graphics for Targets --------------------------------------------------

binOpts = {
    frames = {
    {x=75,  y=5, width=145, height=300}, -- bin 
    {x=255, y=5, width=235, height=300}, -- basket
    {x=526, y=5, width=262, height=300} -- box
    }}

binSheet = graphics.newImageSheet("./images/binSheet.png", binOpts); 


---------------------Box Object - Inherits from Bin-------------------------------------------


local Box = Bin:new{score = 0,itemCntr = 10} -- Number of items generated for this bin.

function Box:spawn()
	self.shape = display.newImage(binSheet, 3)
	self.shape.x=xx; self.shape.y=210;
	physics.addBody(self.shape, "static", {filter=CollisionFilters.box, shape = {-82,-50, 72,-50, 72,62, -82,62 }})

	self.shape.pp = self
	self.shape.tag = "toy box"
	self.shape:setFillColor(1,1,0)

		function removeItem(event)
			if (event.phase == "began") then
				if (event.other.tag == "toy") then --Correct bin
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




return Box