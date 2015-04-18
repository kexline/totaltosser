-- welcome.lua :  Main menu

-- CS 371
-- Final Project: Total Tosser
-- Group members: Karen Exline, Cozette Napoles, and James Taylor

-- References:  
-- buttons created using http://dabuttonfactory.com/ and sheeted in Inkscape 
-- Block text solution:  https://coronalabs.com/blog/2014/06/17/tutorial-working-with-large-blocks-of-text/

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

local scrollView; -- have to make this a scene global because it is not working in scenegroup

local function shakeShortTable( t )
	-- shuffleTable function from previous homework does not work for this very short case.
    assert( t, "jumbleTable() expected a table, got nil" )
    local items=#t 
    local j 
    j = math.random(1,#t)
    t[1], t[j] = t[j], t[1];

    for i = items, 1, 1 do
        j = math.random(1,#t)
        t[i], t[j] = t[j], t[i]
    end
    return t;
end

-- randomize order of credits!
local authors={"Cozette Napoles", "James Taylor", "Karen Exline"};
authors=shakeShortTable(authors);

local blurb=string.format("%s, %s, \n and %s", authors[1], authors[2], authors[3]);	

blurb=[[Created for UAH by 
]]..blurb.."\n\n"..[[ with help from

Sun-il Kim
William Edmonds
Corona Labs
Da Button Factory 

Rooms inspired by 
Flash Point Fire Rescue

Other art provided by 
spritersresource.com

]]

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
	{ x = 0, y =236, width = 138, height = 65}, -- Home
	{ x = 322, y = 239, width = 138, height = 65}, -- Home light
	{ x = 0, y =85, width = 183, height = 68},  -- continue huge
	{ x = 322, y =85, width = 183, height = 68},  -- continue huge light

}}

local btnSheet = graphics.newImageSheet( "./images/btnSheet_l.png", btnOptions );

local sbOptions = { frames = {
	{ x = 7, y =3, width = 17, height = 17}, -- top
	{ x = 7, y =23, width = 17, height = 6}, -- mid
	{ x = 7, y =49, width = 17, height = 12}, -- bot
}}

local sbSheet = graphics.newImageSheet( "./images/scrollBarSheet.png", sbOptions );


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
		bx1.x=xx; bx1.y=yy*1.1;
		bx1:scale(bxwidth, bxheight); 

		-- display.newRoundedRect( parent, x, y, width, height, cornerRadius )
		local bx2=display.newRoundedRect(xx, yy*1.1, bxwidth*.82*400, bxheight*.82*450, 35);
		bx2:setFillColor(1,1,1)
		bx2:setStrokeColor(0.39, 0.23, 0, 0.4); bx2.strokeWidth=10;
		bx2:toFront();	

		sceneGroup:insert(bx1);
		sceneGroup:insert(bx2);


		local paragraphs = {}
		local paragraph
		local tmpString = blurb

		local scrollw=bxwidth*.82*400*.9;
		local scrollh=bxheight*.82*400*.9;

		scrollView = widget.newScrollView
		{
		    top = yy*1.1-scrollh*.5,
		    left = xx-scrollw*.5-15,
		    width = scrollw,
		    height = scrollh,
		    scrollWidth = scrollw-10,
		    scrollHeight = 8000,

		    hideScrollBar = false,
			scrollBarOptions = {
			    sheet = sbSheet, 		 --reference to the image sheet
			    topFrame = 1,            --number of the "top" frame
			    middleFrame = 2,         --number of the "middle" frame
			    bottomFrame = 3          --number of the "bottom" frame
			}

		}

		-- Why does inserting scrollview into scenegroup make it disappear?
		-- sceneGroup:insert(scrollView);
		-- scrollView:toFront();

		local options = {
		    text = "",
		    width = scrollh,
		    font = ff,
		    fontSize = fs*.45,
		    align = "center"

		}

		local yOffset = 10

		repeat
		    paragraph, tmpString = string.match( tmpString, "([^\n]*)\n(.*)" )
		    options.text = paragraph
		    paragraphs[#paragraphs+1] = display.newText( options )
		    paragraphs[#paragraphs].anchorX = 0
		    paragraphs[#paragraphs].anchorY = 0
		    paragraphs[#paragraphs].x = 10
		    paragraphs[#paragraphs].y = yOffset
		    paragraphs[#paragraphs]:setFillColor( 0.39, 0.23, 0  )
		    scrollView:insert( paragraphs[#paragraphs] )
		    yOffset = yOffset + paragraphs[#paragraphs].height
		    print( #paragraphs, paragraph )
		until tmpString == nil or string.len( tmpString ) == 0


	elseif phase=="did" then

		-- Main Menu button =====================================

		local function btnMain(event)
			composer.gotoScene("welcome");
		end

		btn1=widget.newButton({
			x=xx, y=hh*.9,
			id="mainmenu", onPress=btnMain, 
			sheet = btnSheet,
			defaultFrame = 7,	
			overFrame = 8,
			strokeWidth=2,
		}) 
		sceneGroup:insert(btn1);


	end
end

function scene:hide(event)
	local phase=event.phase;
	local sceneGroup = self.view;

	if phase=="will" then
		scrollView:removeSelf();

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