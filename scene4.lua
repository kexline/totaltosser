-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor

----------------------------------- Scene 4 -----------------------------------
local composer = require("composer")
local scene = composer.newScene()
local physics = require("physics")
local widget = require("widget")


-- Convenience variables --
local xx = display.contentCenterX; local ww=display.contentWidth;
local yy = display.contentCenterY; local hh=display.contentHeight;
local fs=hh/20;  local ff=native.systemFont;

---------- Graphics ---------------------------------------------------------
local titleOpts = 
{ frames = {
	{ x = 35, y =35, width = 400, height = 450 }, -- scatter1
	{ x = 0, y =0, width = 326, height = 320 }, -- scatter2
	{ x = 30, y =855, width = 326, height = 206 }, -- title glow
	{ x = 30, y =1052, width = 326, height = 206 }, -- title plain
}}

local titleSheet = graphics.newImageSheet( "./images/titleSheet.png", titleOpts );

local btnOptions = { frames = {	
 	{ x = 0, y =15, width = 322, height = 65},  -- clean huge
 	{ x = 322, y =15, width = 314, height = 65},  -- clean huge light
 	{ x = 0, y =535, width = 179, height = 65},  -- tutorial huge
	{ x = 322, y =532, width = 179, height = 65},  -- tutorial huge light
	{ x = 0, y =756, width = 179, height = 65},  -- credits huge
	{ x = 322, y =756, width = 179, height = 65},  -- credits huge light
	{ x = 0, y =236, width = 138, height = 65}, -- Home
	{ x = 322, y = 239, width = 138, height = 65}, -- Home light
	{ x = 0, y =85, width = 183, height = 68},  -- continue huge
	{ x = 322, y =85, width = 183, height = 68},  -- continue huge light

}}

local btnSheet = graphics.newImageSheet( "./images/btnSheet_l.png", btnOptions );

--------------------------------------------------------------------------------

function scene:create(event)
	local phase=event.phase;
	local sceneGroup = self.view;

end

function scene:show (event)
	local phase=event.phase;
	local sceneGroup = self.view;

	if phase=="will" then
		--== background image and title ===========================

		local bg = display.newImage ("./images/bamboo-white-plain.png", ".",xx,yy, 1);
		bg:rotate(-90);
		bg:scale(math.max(ww/1080,1080/ww), math.max(hh/1920, 1920/hh));

		title=display.newImage(titleSheet,4);
		title.x=xx; title.y=yy*.33;

		sceneGroup:insert(bg); sceneGroup:insert(title);

		-- Content frame box ====================================

		bxwidth=math.max(ww/400, 400/ww)*.75; 
		bxheight=math.max(hh/450, 450/hh)*.5;
		local bx1=display.newImage(titleSheet,1);
		bx1.x=xx; bx1.y=yy*1.1;
		bx1:scale(bxwidth, bxheight); 


		local bx2=display.newRoundedRect(xx, yy*1.1, bxwidth*.82*400, bxheight*.82*450, 35);
		bx2:setFillColor(1,1,1)
		bx2:setStrokeColor(0.39, 0.23, 0, 0.4); bx2.strokeWidth=10;
		bx2:toFront();	

		sceneGroup:insert(bx1);
		sceneGroup:insert(bx2);

		-- Win text
		local msg = display.newText("Congratulations,", xx, yy-75, ff, fs*.7)
		msg:setFillColor(0.39, 0.23, 0)

		local msg1 = display.newText("you won!", xx, yy, ff, fs*.7)
		msg1:setFillColor(0.39, 0.23, 0)

		local msg2 = display.newText("Thanks for playing!", xx, yy+120, ff, fs*.6)
		msg2:setFillColor(0.39, 0.23, 0)

		sceneGroup:insert(msg)
		sceneGroup:insert(msg1)
		sceneGroup:insert(msg2)


	elseif phase=="did" then

		-- Main Menu button =====================================

		local function btnMain(event)
			composer.gotoScene("welcome");
		end

		btn1=widget.newButton({
			x=xx, y=hh*.87,
			id="mainmenu", onPress=btnMain, 
			sheet = btnSheet,
			defaultFrame = 7,	
			overFrame = 8,
			strokeWidth=2,
		}) 

		sceneGroup:insert(btn1);

	   -- Credits button =====================================
		local function btnCredits(event)
			composer.gotoScene("credit");
		end

		btnc=widget.newButton({
			x=ww*.9, y=hh*.95,
			id="credits", onPress=btnCredits, 
			sheet = btnSheet,
			defaultFrame = 5,
			overFrame = 6,
			strokeWidth=3,
		}) 

		btnc.alpha=0.5;
		
		sceneGroup:insert(btnc)
	end
end

function scene:hide(event)
	local phase=event.phase;
	local sceneGroup = self.view;

	if phase=="will" then

	elseif phase=="did" then

	end
end

function scene:destroy(event)
	local phase=event.phase;
	local sceneGroup = self.view;
	sceneGroup:removeSelf();
	sceneGroup=nil;
end


scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene;