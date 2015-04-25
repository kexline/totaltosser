--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a1e40776bd9472091ee0799e45e7d46a:2901b87d521ee8c57d1cf40da3a809d4:9ce13e14a340f043de5d245d4324eb29$
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
            -- A_Clothing01
            x=36,
            y=2,
            width=30,
            height=30,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- A_Clothing02
            x=2,
            y=2,
            width=32,
            height=30,

            sourceX = 1,
            sourceY = 2,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- A_Shoes01
            x=68,
            y=2,
            width=32,
            height=26,

            sourceX = 1,
            sourceY = 4,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- A_Shoes07
            x=68,
            y=30,
            width=32,
            height=26,

            sourceX = 1,
            sourceY = 4,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- C_Elm01
            x=2,
            y=34,
            width=27,
            height=22,

            sourceX = 3,
            sourceY = 6,
            sourceWidth = 34,
            sourceHeight = 34
        },
    },
    
    sheetContentWidth = 102,
    sheetContentHeight = 58
}

SheetInfo.frameIndex =
{

    ["A_Clothing01"] = 1,
    ["A_Clothing02"] = 2,
    ["A_Shoes01"] = 3,
    ["A_Shoes07"] = 4,
    ["C_Elm01"] = 5,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
