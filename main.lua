-- get sprite then set filter to nearest
love.graphics.setDefaultFilter("nearest","nearest")
Assets = require "sprites"
Font = love.graphics.newFont(15)
love.graphics.setFont(Font)
love.window.setTitle("SPRITE TESTER")

function love.load()
    -- Sprite width
    SpriteWidth = 32
    SpriteHeight = 16
    -- Sprite Pos
    SpriteY = (600/2) - 32
    Ydef = SpriteY
    -- take sprite
    Current = Assets.player
    Quad = love.graphics.newQuad(0,0,SpriteWidth,SpriteHeight,Current:getDimensions())
    -- sprite option 
    Frame = 0 -- current frame
    Fps = 12 -- animation speed
    Frametime = 1/Fps 
    Framecount = 4 -- number of your sprite frames
    Offset = 0 -- frame offset
    -- other sprite options
    SpriteOffset = {0,4,8} -- sprite offset
    States = {"idle","walking","jumping"} -- all states
    State = "walking" -- current state
    SOC = 1 
    Facing = 1
    -- flags
    isPlaying = true
end

function love.keypressed(p)
    -- check keypresses for etc/opts
    if p == "r" then -- reset
        love.load()
    elseif p == "s" and isPlaying == true then -- stop
        isPlaying = false
    elseif p == "s" and isPlaying == false then -- play
        isPlaying = true
    elseif p == "left" and isPlaying == true and Fps > 1 then -- lower fps
        Fps = Fps - 1
    elseif p == "right" and isPlaying == true then -- up fps
        Fps = Fps + 1
    elseif p == "left" and Frame > 0 then -- change frame decreasing
        Frame = Frame - 1
    elseif p == "right" then -- change frame increasing 
        Frame = Frame + 1
    end
end

function love.update(dt)
    -- frame updates
    Frametime = Frametime - dt
    LKD = love.keyboard.isDown

    -- check for kb pushes then set states
    if LKD("a")  then
        State = "walking"
        Facing = -1
    elseif LKD("d") then
        State = "walking"
        Facing = 1
    elseif LKD("space") then
        State = "jumping"
    else
        if State ~= "jumping" and isPlaying == true then
            State = "idle"
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
        if Frame == Framecount then
            Frame = 0
        end
        -- check for active states then change offset
        if State == States[2] then
            SOC = 2
        elseif State == States[3] then
            SOC = 3
        end
        -- update quad
        Offset = (32 * SpriteOffset[SOC])+32 * Frame
        Quad:setViewport(Offset,0,SpriteWidth,SpriteHeight)
    end

end

function love.draw()
    -- background
    love.graphics.rectangle("fill",0,0,800,600)
    love.graphics.setColor(0.98,0.98,0.98)
    love.graphics.rectangle("fill",100,90,600,400)
    love.graphics.setColor(.1,.1,.1)
    love.graphics.print("Active State : "..States[SOC],0,0)
    love.graphics.print("Fps : "..Fps,0,15)
    love.graphics.print("Frame : "..Frame,0,30)
    love.graphics.print("Playing : "..tostring(isPlaying),0,45)
    love.graphics.print("Controls",0,500)
    love.graphics.print("A,D : walk",0,515)
    love.graphics.print("SPACE: jump",0,530)
    love.graphics.print("S: Play/Pause",0,545)
    love.graphics.print("Left: Decrease Fps/ Change Frame[when paused]",0,560)
    love.graphics.print("Right: Increase Fps/ Change Frame[when paused]",0,575)
    love.graphics.setColor(1,1,1)
    -- sprite facing 
    if Facing == 1 then
        love.graphics.draw(Current,Quad,(800/2)-78,SpriteY,0,4,4)
    elseif Facing == -1 then
        love.graphics.draw(Current,Quad,(800/2)+32,SpriteY,0,-4,4)
    end
end
