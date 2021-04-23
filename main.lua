_G.version = "0.0.1"
-- get sprite then set filter to nearest
love.graphics.setDefaultFilter("nearest","nearest")
Font = love.graphics.newFont("riskofrainsquare.ttf",13)
love.graphics.setFont(Font)
love.window.setTitle("SPRITE TESTER v".._G.version)
-- load libs
require "sprites"
require "libs"
-- files -- get files
function love.load()
    -- window size
    love.window.setMode(800,600,{resizable=false})
    -- load simply
    simp.load()
    -- scan sprite
    getsprites()
    -- take sprite
    Current = 1
    -- Sprite width
    SpriteWidth = spriteconf[Current].SpriteWidth
    SpriteHeight = spriteconf[Current].SpriteHeight
    -- Sprite Pos
    SpriteY = 390
    Ydef = SpriteY
    Quad = love.graphics.newQuad(0,0,SpriteWidth,SpriteHeight,sprites[Current]:getDimensions())
    -- sprite option 
    Frame = 0 -- current frame
    Fps = 12 -- animation speed
    Frametime = 1/Fps 
    Framecount = spriteconf[Current].Framecount -- number of your sprite frames
    Offset = 0 -- frame offset
    -- other sprite options
    SpriteOffset = spriteconf[Current].SpriteOffset -- sprite offset
    States = {"idle","walking","jumping"} -- all states
    State = nil -- current state
    SOC = 1 
    Facing = 1
    -- flags
    isPlaying = true
    require "buttons"
    button.load()
end

function loadconf()
    Quad = love.graphics.newQuad(0,0,SpriteWidth,SpriteHeight,sprites[Current]:getDimensions())
    Framecount = spriteconf[Current].Framecount
    SpriteWidth = spriteconf[Current].SpriteWidth
    SpriteHeight = spriteconf[Current].SpriteHeight
    SpriteOffset = spriteconf[Current].SpriteOffset
end

function love.keypressed(p)
    -- check keypresses for etc/opts
    if p == "r" then -- reset
        love.load()
    elseif p == "space" and isPlaying == true then
        isPlaying = false
        simp.pop({button=true})
        button.load()
    elseif p == "space" and isPlaying == false then
        isPlaying = true
        simp.pop({button=true})
        button.load()
    end
end

function love.mousepressed(m,x,y)
    simp.mousepressed(m,x,y)
end

function love.update(dt)
    -- update simply
    simp.update(dt)
    -- frame updates
    Frametime = Frametime - dt
    LKD = love.keyboard.isDown

    -- check for kb pushes then set states
    if LKD("a")  then
        State = States[2]
        Facing = -1
    elseif LKD("d") then
        State = States[2]
        Facing = 1
    elseif LKD("w") then
        State = States[3]
    else
        if State ~= States[3] and isPlaying == true then
            State = States[1]
            SOC = 1
        end
    end

    -- frame adjustments
    if Frametime <= 0 then
        Frametime = 1 / Fps
        if isPlaying == true then
            Frame = Frame + 1
        end
        -- reset frame 
        if Frame >= Framecount then
            Frame = 0
        end
        -- check for active states then change offset
        if State == States[2] then
            SOC = 2
        elseif State == States[3] then
            SOC = 3
        end
        -- update quad
        Offset = (spriteconf[Current].SpriteWidth * spriteconf[Current].SpriteOffset[SOC])+spriteconf[Current].SpriteWidth * Frame
        Quad:setViewport(Offset,0,spriteconf[Current].SpriteWidth,spriteconf[Current].SpriteHeight)
    end
end

function love.draw()
    -- background
    love.graphics.rectangle("fill",0,0,800,600)
    love.graphics.setColor(0.98,0.98,0.98)
    love.graphics.rectangle("fill",100,90,600,400)
    -- text
    love.graphics.setColor(.2,.2,.2)
    love.graphics.print("active state : "..States[SOC]..", facing:"..Facing,0,0)
    love.graphics.print("fps : "..Fps,0,15)
    love.graphics.print("frame : "..(Frame+1).."/"..Framecount,0,30)
    love.graphics.print("playing : "..tostring(isPlaying),0,45)
    love.graphics.print("sprite width : "..SpriteWidth,0,60)
    love.graphics.print("sprite height : "..SpriteHeight,0,75)
    love.graphics.print("sprite  :  "..filenames[Current],320,430)
    if isPlaying == true then
        love.graphics.print("pause",50,157)
        love.graphics.print("inc. fps",50,157+40)
        love.graphics.print("dec. fps",50,157+40+40)
    else
        love.graphics.print("play",50,157)
        love.graphics.print("next frame",50,157+40)
        love.graphics.print("prev frame",50,157+40+40)
    end


    love.graphics.setColor(1,1,1)
    -- sprite facing 
    if Facing == 1 then
        love.graphics.draw(sprites[Current],Quad,(800*.5) - 32*2,SpriteY,0,4,4,0,SpriteHeight)
    elseif Facing == -1 then
        love.graphics.draw(sprites[Current],Quad,(800*.5) + 32,SpriteY,0,-4,4,0,SpriteHeight)
    end
    -- draw simply on top
    simp.draw()
    button.draw()
end
