--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:b3097524454363e7b2b083c1e1987155:dbc44e42541d7e84adb11a14e10cc4ee:65959f1d1e2d3c68b8be878571cee938$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- I_Bone
            x=37,
            y=36,
            width=31,
            height=22,

            sourceX = 1,
            sourceY = 6,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- I_C_Fish
            x=2,
            y=36,
            width=33,
            height=23,

            sourceX = 0,
            sourceY = 5,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- I_FishTail
            x=2,
            y=2,
            width=34,
            height=32,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- I_ScorpionClaw
            x=71,
            y=2,
            width=27,
            height=29,

            sourceX = 3,
            sourceY = 2,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- I_WolfFur
            x=38,
            y=2,
            width=31,
            height=32,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 34,
            sourceHeight = 34
        },
    },
    
    sheetContentWidth = 100,
    sheetContentHeight = 61
}

SheetInfo.frameIndex =
{

    ["I_Bone"] = 1,
    ["I_C_Fish"] = 2,
    ["I_FishTail"] = 3,
    ["I_ScorpionClaw"] = 4,
    ["I_WolfFur"] = 5,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
