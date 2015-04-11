-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor
-- Approach:

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
	local left = display.newRect(0,0,1, display.contentHeight);	--our left screen border
	local right = display.newRect(display.contentWidth,0,1,display.contentHeight);	--our right screen border
	local bottom = display.newRect(0,display.contentHeight-80, display.contentWidth, 1);	--our bottom screen border
	local top = display.newRect(0,80,display.contentWidth, 1);	--our top screen border

	left.anchorX = 0;left.anchorY = 0;	--anchor the left border
	right.anchorX = 0;right.anchorY = 0;	--anchor the right border
	bottom.anchorX = 0;bottom.anchorY = 0;	--anchor the bottom border
	top.anchorX = 0;top.anchorY = 0;	--anchor the top border

	physics.addBody( bottom, "static", {filter=CollisionFilters.walls});	--make the bottom border static
	physics.addBody( left, "static", {filter=CollisionFilters.walls});	--make the left border static
	physics.addBody( right, "static", {filter=CollisionFilters.walls});	--make the right border static
	physics.addBody( top, "static", {filter=CollisionFilters.walls});	--make the top border static
end


return Walls;