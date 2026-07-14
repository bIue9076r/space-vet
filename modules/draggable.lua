Draggable = {}
Draggable.location = {x = 0, y = 0, Button = Button.new(), Key = ""}
Draggable.goal = {Button = Button.new(), Action = function() end, Key = ""}
Draggable.firstKey = false
Draggable.firstClick = false
Draggable.firstDrag = false
Draggable.drag = false
Draggable.dragOffset = {x = 0, y = 0}

function Draggable:notFirst()
	return (not self.firstKey) and (not self.firstClick) and (not self.firstDrag)
end

function Draggable:firstClear()
	self.firstKey = false
	self.firstClick = false
	self.drag = false
end

function Draggable:collide()
	return	(self.location.Button.x + self.location.Button.w >= self.goal.Button.x) and
			(self.location.Button.y + self.location.Button.h >= self.goal.Button.y) and
			(self.location.Button.x <= self.goal.Button.x + self.goal.Button.w) and
			(self.location.Button.y <= self.goal.Button.y + self.goal.Button.h)
end

function Draggable:draw()
	self.goal.Button:draw()
	self.location.Button:draw()
end

function Draggable:update(dt)
	local x,y = NormalizeMouse(love.mouse.getPosition())

	local ft = self.location.Button.t
	self.location.Button:focus(x,y)
	self.goal.Button:focus(x,y)

	if love.mouse.isDown(1) then
		if (not self.firstDrag) and self.location.Button.f then
			self.dragOffset.x = self.location.Button.x - x
			self.dragOffset.y = self.location.Button.y - y
			self.firstDrag = true
			self.drag = true
		end
	else
		self.drag = false
	end

	if self.drag then
		-- Drag
		self.location.Button.x = x + self.dragOffset.x
		self.location.Button.y = y + self.dragOffset.y
		self.location.Button.t = ft
		self.location.Button.f = true
	else
		-- Let go
		if self:collide() then
			self.goal.Action()
		end
		self.location.Button.x = self.location.x
		self.location.Button.y = self.location.y
		self.dragOffset.x = 0
		self.dragOffset.y = 0
		self.firstDrag = false
	end
end

function Draggable:keypressed(key)
	if self:notFirst() then
		if key == self.location.Key then
			self.firstKey = true
		end
	else
		if key == self.goal.Key then
			self.goal.Action()
		end
		self:firstClear()
	end
end

function Draggable:mousepressed(x,y,button)
	x,y = NormalizeMouse(x,y)

	if self:notFirst() then
		self.location.Button:focus(x,y)
		if self.location.Button.f and button == 1 then
			self.firstClick = true
		end
	else
		self.goal.Button:focus(x,y)
		if self.goal.Button.f and button == 1 then
			self.goal.Action()
		end
		self:firstClear()
	end
end

function Draggable.new(x1,y1,w1,h1,x2,y2,w2,h2,A,k1,k2)
	local tbl = {
		location = {
			x = x1 or 0,
			y = y1 or 0,
			Button = Button.new(x1,y1,w1,h1),
			Key = k1 or "",
		},
		
		goal = {Button = Button.new(x2,y2,w2,h2), Action = A or function() end, Key = k2 or ""},

		firstKey = false,
		firstClick = false,
		firstDrag = false,
		dragOffset = {x = 0, y = 0}
	}

	local mt = {
		__index = Draggable,
	}

	return setmetatable(tbl,mt)
end
