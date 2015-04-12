-- welcome.lua :  Main menu

-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor

-- References:  
-- buttons created using http://dabuttonfactory.com/ and sheeted in Inkscape 

-- includes and physics
local composer = require("composer")
local scene = composer.newScene()
local physics = require("physics")
local widget = require("widget")
-- physics.start()
-- physics.setGravity(0,0)

-- Custom objects
-- local Trash = require("Trash");
-- local Laundry = require("Laundry");
-- local Toys = require("Toys");
-- local Walls = require("Walls");

-- Convenience variables
local xx = display.contentCenterX; local ww=display.contentWidth;
local yy = display.contentCenterY; local hh=display.contentHeight;
local fs=hh/20;  local ff=native.systemFont;

-- scene variables
local function shuffleTable( t )
    assert( t, "shuffleTable() expected a table, got nil" )
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = math.random(1,i)
        t[i], t[j] = t[j], t[i]
    end
end

local authors={"Karen Exline", "James Taylor", "Cozette Napoles"};
shuffleTable(authors);

local creditsBlurb=string.format("Created for UAH by %s, %s, and %s. \n This should appear on a new line.", authors[1], authors[2], authors[3]);
-- Graphics
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

	if phase=="will" then
		--== background image and title ===========================

		--display.newImage( [parent,] filename [,baseDir] [,x,y] [,isFullResolution])
		local bg = display.newImage ("./images/bamboo-white-plain.png", ".",xx,yy, 1);
		bg:rotate(-90);
		bg:scale(math.max(ww/1080,1080/ww), math.max(hh/1920, 1920/hh));

		--display.newImage( [parent,] imageSheet, frameIndex )
		title=display.newImage(titleSheet,4);
		title.x=xx; title.y=yy*.33;
		

		sceneGroup:insert(bg); sceneGroup:insert(title);

		-- Content frame box ====================================

		bxwidth=math.max(ww/400, 400/ww)*.75; 
		bxheight=math.max(hh/450, 450/hh)*.5;
		local bx1=display.newImage(titleSheet,1);
		bx1.x=xx; bx1.y=yy*1.2;
		bx1:scale(bxwidth, bxheight); 

		-- display.newRoundedRect( parent, x, y, width, height, cornerRadius )
		local bx2=display.newRoundedRect(xx, yy*1.2, bxwidth*.82*400, bxheight*.82*450, 35);
		bx2:setFillColor(1,1,1)
		bx2:setStrokeColor(0.39, 0.23, 0, 0.4); bx2.strokeWidth=10;
		bx2:toFront();	

		sceneGroup:insert(bx1);

		-- Main Menu button =====================================

		btn1=widget.newButton({
			x=xx, y=yy+20,
			id="mainmenu", onPress=btnMain, 
			sheet = btnSheet,
			defaultFrame = 1,
			overFrame = 2,
			strokeWidth=2,
		}) 

		sceneGroup:insert(btn1);

	elseif phase=="did" then

		creditText=display.newText(creditsBlurb, xx, yy, ff, fs*.4);
		creditText:setFillColor( 0.39, 0.23, 0 )

		-- local scrollView = widget.newScrollView{
    --     top = myTop, left = myLeft,
    --     width = someWidth, height = someHeight,
    --     bgColor = { 255, 255, 255, 210 },   --set the RGBA background color.
    -- }

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