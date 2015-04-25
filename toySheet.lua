--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:0d345cc4b2c8f2a91d49b60051df95b4:3d8537241be01d5e198320838eeb2425:a9ea16edf5a99a36ab2509c61292fecc$
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
            -- I_Key07
            x=37,
            y=2,
            width=32,
            height=33,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- I_Mirror
            x=71,
            y=2,
            width=32,
            height=32,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- S_Magic01
            x=139,
            y=2,
            width=27,
            height=31,

            sourceX = 3,
            sourceY = 1,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- S_Water07
            x=105,
            y=2,
            width=32,
            height=32,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- W_Mace014
            x=2,
            y=2,
            width=33,
            height=33,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
    },
    
    sheetContentWidth = 168,
    sheetContentHeight = 37
}

SheetInfo.frameIndex =
{

    ["I_Key07"] = 1,
    ["I_Mirror"] = 2,
    ["S_Magic01"] = 3,
    ["S_Water07"] = 4,
    ["W_Mace014"] = 5,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
