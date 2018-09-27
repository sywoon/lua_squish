--[[
	动画管理类
	1、缓存对动画节点的部分调用操作，因对spine动画做异步处理，部分操作需要做延迟调用
]]
local AnimMgr = class("AnimMgr")

local EVENT_AFTER_UPDATE = "director_after_update"
local dispatcher = cc.Director:getInstance():getEventDispatcher()

function AnimMgr:ctor()
	self._calls = {}

	local listener = cc.EventListenerCustom:create(EVENT_AFTER_UPDATE, handler(self, self._doCalls))
	dispatcher:addEventListenerWithFixedPriority(listener, -1000)
end

function AnimMgr:addCall(obj, ...)
	local call = {...}
	local objCalls = self._calls[obj]
	if not objCalls then
		objCalls = {}
		self._calls[obj] = objCalls
	end
	objCalls[#objCalls + 1] = call
end

function AnimMgr:removeCall(obj)
	self._calls[obj] = nil
end

function AnimMgr:_doCalls()
	for obj, objCalls in pairs(self._calls) do
		if not tolua.isnull(obj) or obj == animationCache then
			for _, call in ipairs(objCalls) do
				local func = table.remove(call, 1)
				if func then
					func(obj, unpack(call))
				end
			end
		end
		self._calls[obj] = nil
	end
end

return AnimMgr.new()
