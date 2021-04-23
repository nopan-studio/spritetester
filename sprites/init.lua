local path = (...).."."
filenames = {}
sprites = {}
spriteconf = {}
function split(str, sep)
    if sep == nil then
        sep = '%s'
    end
    local res = {}
    local func = function(w)
        table.insert(res, w)
    end
    string.gsub(str, '[^'..sep..']+', func)
    return res 
end

function getsprites()
    for dir in io.popen("dir "..path.." /b"):lines() do
        local temp = split(dir,"'.'")
        if dir ~= "init.lua" and temp[#temp] == "png" then
            local t = false
            local image = love.graphics.newImage(path.."/"..dir)
            local options = {}
            pcall(function() 
                options = require(path.."/"..temp[1]) or require(path.."/defaults")
                t = true
            end)
            if t == false then
                options = require(path.."defaults")
            end
            table.insert(filenames,dir)
            table.insert(sprites,image) 
            table.insert(spriteconf,options)
        end
    end
end

return
