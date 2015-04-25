-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor


local CollisionFilters = require ("CollisionFilters");

---------------------Wall Object -------------------------------------------

local Walls = {};

function Walls:new (o)    --Constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end


function Walls:spawn(xPos, yPos)
	left = display.newRect(0,0,5, display.contentHeight);	--our left screen border
	right = display.newRect(display.contentWidth,5,5,display.contentHeight);	--our right screen border
	bottom = display.newRect(0,display.contentHeight-80, display.contentWidth, 5);	--our bottom screen border
	top = display.newRect(0,80,display.contentWidth, 5);	--our top screen border

	midline = display.newRect(0, midlineYPos, display.contentWidth*2, 10);
	midline:setFillColor(1,1,0);

	left.anchorX = 0;left.anchorY = 0;	--anchor the left border
	right.anchorX = 0;right.anchorY = 0;	--anchor the right border
	bottom.anchorX = 0;bottom.anchorY = 0;	--anchor the bottom border
	top.anchorX = 0;top.anchorY = 0;	--anchor the top border

	physics.addBody( bottom, "static", {filter=CollisionFilters.walls});	--make the bottom border static
	physics.addBody( left, "static", {filter=CollisionFilters.walls});	--make the left border static
	physics.addBody( right, "static", {filter=CollisionFilters.walls});	--make the right border static
	physics.addBody( top, "static", {filter=CollisionFilters.walls});	--make the top border static
end

function Walls:rmv()
    display.remove(left)
    left = nil
    display.remove(right)
    right = nil
    display.remove(bottom)
    bottom = nil
    display.remove(top)
    top = nil
    display.remove(midline)
    midline = nil
end

return Walls;