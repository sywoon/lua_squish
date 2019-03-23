local CameraMgr = {}

local CAMERA_TYPE = 
{
	"DEFAULT", 
	"MAP", 
	"MAP_UI", 
	"ENTITY", 
	"UI",
}

local CAMERA_FLAGS = 
{
	["DEFAULT"] 	= cc.CameraFlag.DEFAULT, -- depth 5
    ["MAP"] 		= cc.CameraFlag.USER1,   -- depth 1
    ["MAP_UI"] 		= cc.CameraFlag.USER2,   -- depth 2 
    ["ENTITY"] 		= cc.CameraFlag.USER3,   -- depth 3
    ["UI"] 			= cc.CameraFlag.USER4,   -- depth 4
}

function CameraMgr:init(node)
    local winSize = cc.Director:getInstance():getWinSize()

	local cameras = {}
	for idx = 2, #CAMERA_TYPE do
		local name = CAMERA_TYPE[idx]
    	local camera
    	if name == "MAP" then
			camera = cc.Camera:createPerspective(60, winSize.width / winSize.height, 1, 20000)
		else
			camera = cc.Camera:create()
    	end

		camera:setCameraFlag(CAMERA_FLAGS[name])
		camera:setDepth(idx)
		cameras[name] = camera
		node:addChild(camera)
    end

    cc.Camera:getDefaultCamera():setDepth(#CAMERA_TYPE+1)
	self._cameras = cameras
end

function CameraMgr:getCamera(name)
	return name and self._cameras[name] or self._cameras
end

function CameraMgr:setMask(node, name)
	assert(name and node)
	if name == "MAP" then
		self:setMapMask(node)
	elseif name == "MAP_UI" then
		self:setMapUIMask(node)
	elseif name == "ENTITY" then
		self:setEntityMask(node)
	elseif name == "UI" then
		self:setUIMask(node)
	end
end

function CameraMgr:setMapMask(node)
	assert(node, "warning!!! node is not exsit!")
    node:setCameraMask(CAMERA_FLAGS["MAP"])
end

function CameraMgr:setMapUIMask(node)
	assert(node, "warning!!! node is not exsit!")
    node:setCameraMask(CAMERA_FLAGS["MAP_UI"])
end

function CameraMgr:setEntityMask(node)
	assert(node, "warning!!! node is not exsit!")
    node:setCameraMask(CAMERA_FLAGS["ENTITY"])
end

function CameraMgr:setUIMask(node)
	assert(node, "warning!!! node is not exsit!")
	--@todo  先用default代替ui   后面考虑保留还是删除
    -- node:setCameraMask(CAMERA_FLAGS["UI"])
end


return CameraMgr