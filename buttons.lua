button = {}
function button.load()
    gp = {}
    gp.gp1 = simp.new_group({
        name = "1",
        isVisible = false,
        x = 600,
        y = 20,
        w = 200,
        h = 200,
        style = "fill",
    })

    bt = {}
    bt.close = simp.new_button({
        name = "close",
        group = "1",
        isVisible = false,
        setVisibility = true,
        image = love.graphics.newImage("assets/bt_close.png"),
        x = 605,
        y = 25,
        w = 32,
        h = 32,
        pressed = function() 
            gp.gp1.isVisible = false
            bt.show.isVisible = true
        end,
    })

    bt.show = simp.new_button({
        name = "next",
        isVisible = true,
        setVisibility = false,
        image = love.graphics.newImage("assets/bt_show.png"),
        x = 763,
        y = 25,
        w = 32,
        h = 32,
        pressed = function() 
            gp.gp1.isVisible = true
            bt.close.isVisible = true
            bt.show.isVisible = false
        end,
    })


    bt.next = simp.new_button({
        name = "next",
        isVisible = true,
        setVisibility = false,
        image = love.graphics.newImage("assets/bt_right.png"),
        x = 500,
        y = 350,
        w = 32,
        h = 32,
        pressed = function() 
            if Current < #sprites then -- next sprite
                Current = Current + 1
                loadconf()
            end
        end,
    })
    --
    bt.prev = simp.new_button({
        name = "prev",
        isVisible = true,
        setVisibility = false,
        image = love.graphics.newImage("assets/bt_left.png"),
        x = 240,
        y = 350,
        w = 32,
        h = 32,
        pressed = function() 
            if Current > 1 then -- next sprite
                Current = Current - 1
                loadconf()
            end
        end,
    })
    --
    if isPlaying == true then
        bt.pause = simp.new_button({
            name = "pause",
            isVisible = true,
            setVisibility = false,
            image = love.graphics.newImage("assets/bt_pause.png"),
            x = 10,
            y = 100+50,
            w = 32,
            h = 32,
            pressed = function() 
                isPlaying = false
                simp.pop({button=true,group=false})
                button.load()
            end,
        })
        --
        bt.fpsup = simp.new_button({
            name = "fpsup",
            isVisible = true,
            setVisibility = false,
            image = love.graphics.newImage("assets/bt_right.png"),
            x = 10,
            y = 142+50,
            w = 32,
            h = 32,
            pressed = function() 
                Fps = Fps + 1
            end,
        })
        -- 
        bt.fpsdn = simp.new_button({
            name = "fpsdn",
            isVisible = true,
            setVisibility = false,
            image = love.graphics.newImage("assets/bt_left.png"),
            x = 10,
            y = 142 + 92,
            w = 32,
            h = 32,
            pressed = function() 
                if Fps > 1 then
                    Fps = Fps - 1
                end
            end,
        })
    else
        bt.play = simp.new_button({
            name = "play",
            isVisible = true,
            setVisibility = false,
            image = love.graphics.newImage("assets/bt_play.png"),
            x = 10,
            y = 100+50,
            w = 32,
            h = 32,
            pressed = function() 
                isPlaying = true
                simp.pop({button=true,group=false})
                button.load()
            end,
        })
        --
        bt.framenx = simp.new_button({
            name = "framenx",
            isVisible = true,
            setVisibility = false,
            image = love.graphics.newImage("assets/bt_right.png"),
            x = 10,
            y = 142+50,
            w = 32,
            h = 32,
            pressed = function() 
                Frame = Frame + 1
            end,
        })
        -- 
        bt.framepv = simp.new_button({
            name = "framepv",
            isVisible = true,
            setVisibility = false,
            image = love.graphics.newImage("assets/bt_left.png"),
            x = 10,
            y = 142 + 92,
            w = 32,
            h = 32,
            pressed = function() 
                if Frame > 0 then
                    Frame = Frame - 1
                end
            end,
        })
    end
end

function button.draw()
    if gp.gp1.isVisible == true then
        love.graphics.setColor(.1,.1,.1)
        love.graphics.print("controls",gp.gp1.x + 10,gp.gp1.y+50)
        love.graphics.print("a,d : walk",gp.gp1.x + 10,gp.gp1.y+65)
        love.graphics.print("w: jump",gp.gp1.x + 10,gp.gp1.y+80)
        love.graphics.print("space: play/Pause",gp.gp1.x + 10,gp.gp1.y+95)
        love.graphics.setColor(1,1,1)
    end
end