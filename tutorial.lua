-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor

-- References:  
-- buttons created using http://dabuttonfactory.com/ and sheeted in Inkscape 

-- includes and physics
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

-- Convenience variables
local xx = display.contentCenterX; local ww=display.contentWidth;
local yy = display.contentCenterY; local hh=display.contentHeight;
local fs=hh/20;  local ff=native.systemFont;

-- scene variables

-- Graphics

local btnOptions = { 
	frames = {	
 	{ x = 0, y =15, width = 322, height = 65},  -- clean huge
 	{ x = 322, y =15, width = 314, height = 65},  -- clean huge light
 	{ x = 0, y =535, width = 179, height = 65},  -- tutorial huge
	{ x = 322, y =532, width = 179, height = 65},  -- tutorial huge light
	{ x = 0, y =756, width = 179, height = 65},  -- credits huge
	{ x = 322, y =756, width = 179, height = 65},  -- credits huge light
	{ x = 0, y =239, width = 138, height = 65}, -- Home
	{ x = 322, y = 239, width = 138, height = 65}, -- Home light
	{ x = 0, y =85, width = 183, height = 68},  -- continue huge
	{ x = 322, y =85, width = 183, height = 68},  -- continue huge light
}}

local btnSheet = graphics.newImageSheet( "./images/btnSheet_l.png", btnOptions );

function scene:create(event)
	local phase=event.phase;
	local sceneGroup = self.view;

	local bg = display.newImage ("./images/tutorial.png", xx, yy, 1);
	bg:scale(math.max(1,ww/1465,1465/ww), math.max(1,hh/2581, 2581/hh));

	sceneGroup:insert(bg)

end

function scene:show (event)
	local phase=event.phase;
	local sceneGroup = self.view;

	if phase=="will" then


	elseif phase=="did" then
		local function goBack(event)
			composer.gotoScene("welcome");
		end

		 btnBack = widget.newButton(
		 {
		 	x = xx,
		 	y = yy+520,
		 	id = "back",
		 	sheet = btnSheet,
		 	defaultFrame = 7,
		 	overFrame = 8,
		 	onPress = goBack,
		 	}
		 	)

		 sceneGroup:insert(btnBack)

	end
end

-- function scene:hide(event)
-- 	local phase=event.phase;
-- 	local sceneGroup = self.view;

-- 	if phase=="will" then

-- 	elseif phase=="did" then

-- 	end
-- end

function scene:destroy(event)
	local phase=event.phase;
	local sceneGroup = self.view;
	sceneGroup:removeSelf();
	sceneGroup=nil;
end


scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
-- scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene

