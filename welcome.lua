-- welcome.lua :  Main menu

-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor

-- References:  
-- buttons created using http://dabuttonfactory.com/ and sheeted in Inkscape 
-- basic scene template from class notes

-- includes and physics
local composer = require("composer")
local scene = composer.newScene()
local physics = require("physics")
local widget = require("widget")
physics.start()
physics.setGravity(0,0)

-- Custom objects
local Trash = require("Trash");
local Walls = require("Walls");

-- Convenience variables
local DEBUG=true;
local xx = display.contentCenterX; local ww=display.contentWidth;
local yy = display.contentCenterY; local hh=display.contentHeight;
local fs=hh/20;  local ff=native.systemFont;

-- scene variables
local timerRef;

-- Graphics
local titleOpts = 
{ frames = {
	{ x = 0, y =0, width = 400, height = 450 }, -- scatter1
	{ x = 0, y =0, width = 326, height = 320 }, -- scatter2
	{ x = 30, y =855, width = 326, height = 206 }, -- title glow
	{ x = 0, y =1048, width = 326, height = 206 }, -- title plain
}}

local titleSheet = graphics.newImageSheet( "./images/titleSheet.png", titleOpts );

local btnOptions = { frames = {	
 	{ x = 0, y =15, width = 322, height = 65},  -- clean huge
 	{ x = 322, y =15, width = 314, height = 65},  -- clean huge light
 	{ x = 0, y =535, width = 179, height = 65},  -- tutorial huge
	{ x = 322, y =532, width = 179, height = 65},  -- tutorial huge light
	{ x = 0, y =756, width = 179, height = 65},  -- credits huge
	{ x = 322, y =756, width = 179, height = 65},  -- credits huge light
}}

local btnSheet = graphics.newImageSheet( "./images/btnSheet_l.png", btnOptions );

function scene:create(event)
	local phase=event.phase;
	local sceneGroup = self.view;

	if phase=="will" then

	elseif phase=="did" then

	end
end

function scene:show (event)
	local phase=event.phase;
	local sceneGroup = self.view;

	local strewTrash=function(event)
		if table.getn(sceneGroup) < 400 then 
			local xPos=math.random(50,ww); local yPos=math.random(50,hh);
			local t=Trash:new(); 

			-- spawnStatic has no listener or physics
			t:spawnStatic(xPos,yPos);

			-- keep play buttons at front
			btn1:toFront();  btn2:toFront(); 

			sceneGroup:insert(t.shape);
		end
	end

	--== after strewTrash, bring title and all buttons to front =======
	local function raiseText(event)
		btn1:toFront(); btn2:toFront(); btnc:toFront(); title:toFront();
	end

	--== button listeners ===========================

	local function btnStart1(event)
		print("In welcome:  gotoScene scene1"); 
		if timerRef then timer.cancel(timerRef); end
		composer.gotoScene("scene1");
	end

	local function btnTut(event)
		print("In welcome:  gotoScene tutorial"); 
		if timerRef then timer.cancel(timerRef); end
		composer.gotoScene("tutorial");
	end

	local function btnCredits(event)
		print("In welcome:  gotoScene credits"); 
		if timerRef then timer.cancel(timerRef); end
		composer.gotoScene("credits");
	end

	if phase=="will" then

		--== background image and title ===========================

		--display.newImage( [parent,] filename [,baseDir] [,x,y] [,isFullResolution])
		local bg = display.newImage ("./images/bamboo-white-plain.png", ".",xx,yy, 1);
		bg:rotate(-90);
		bg:scale(math.max(1,ww/1080,1080/ww), math.max(1,hh/1920, 1920/hh));

		--display.newImage( [parent,] imageSheet, frameIndex )
		title=display.newImage(titleSheet,3);
		title.x=xx; title.y=yy*.55;
		title:scale(1.2,1.2)

		sceneGroup:insert(bg); sceneGroup:insert(title);

		-- == add buttons ===========================
		btn1=widget.newButton({
			x=xx, y=yy+20,
			id="level1", onPress=btnStart1, 
			sheet = btnSheet,
			defaultFrame = 1,
			overFrame = 2,
			strokeWidth=2,
		}) 

		btn2=widget.newButton({
			x=xx, y=yy+120,
			id="tutorial", onPress=btnTut, 
			sheet = btnSheet,
			defaultFrame = 3,
			overFrame = 4,
			strokeWidth=3,
		}) 

		btnc=widget.newButton({
			x=ww*.9, y=hh*.95,
			id="credits", onPress=btnCredits, 
			sheet = btnSheet,
			defaultFrame = 5,
			overFrame = 6,
			strokeWidth=3,
		}) 

		btnc.alpha=0.5

		sceneGroup:insert(btn1);
		sceneGroup:insert(btn2);
		sceneGroup:insert(btnc);

	elseif phase=="did" then
	-- == start throwing trash onto the screen =======================

		--timer.performWithDelay( delay, listener [, iterations] )
		timerRef=timer.performWithDelay(200,strewTrash,500)
		timerRef2=timer.performWithDelay(215*500,raiseText,1)
	end
end

function scene:hide(event)
	local phase=event.phase;
	local sceneGroup = self.view;

	if phase=="will" then
		title:toFront();
		if timerRef then timer.cancel(timerRef); end
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
