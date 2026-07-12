Button = {
	x = 200, y = 300, w = 300, h = 100, c = {1,1,1}, f = false, t = 0,
	d = false, i = "", s = "", sx = 0, sy = 0, sc = {0,0,0}, ix = 0, iy = 0, is = 1.1
}

function Button:inX(x)
	return ((x >= self.x) and (x <= (self.x + self.w)))
end

function Button:inY(y)
	return ((y >= self.y) and (y <= (self.y + self.h)))
end

function Button:focus(x,y)
	if self:inX(x) and self:inY(y) then
		self.f = true
		self.t = self.t + 1
	else
		self.f = false
		self.t = 0
	end
end

function Button:click(x,y,button)
	if self:inX(x) and self:inY(y) then
		return true
	end
	return false
end

function Button:draw()
	local t = (math.min(self.t,20) / 20)
	if self.d then
		local img = Image.get(self.i)
		if img then
			local d = 1
			local s = 1
			if self.f then
				d = 0.7 * t + (1 - t) * 1
				s = self.is * t + (1 - t) * 1
			end
			love.graphics.setColor(self.c[1] * d, self.c[2] * d, self.c[3] * d)
			love.graphics.draw(img,self.ix,self.iy,0,s)
			love.graphics.setColor(1,1,1)
		end
	else
		local d = 1
		local o = 0
		if self.f then
			d = 0.7 * t + (1 - t) * 1
			o = -5 * t
		end
		love.graphics.setColor(self.c[1] * d, self.c[2] * d, self.c[3] * d)
		love.graphics.rectangle("fill",self.x + o,self.y + o,self.w - 2*o,self.h - 2*o)
		love.graphics.setColor(1,1,1)

		love.graphics.print({self.sc,self.s},self.x + self.sx + o, self.y + self.sy + o)
	end
end

function Button.new(x,y,w,h,i,s,sx,sy,sc,ix,iy,is)
	local tbl = {
		x = x or 0, y = y or 0, w = w or 10, h = h or 10, c = {1,1,1}, f = false, t = 0,
		d = false, i = i or nil, s = s or "", sx = sx or 0, sy = sy or 0, sc = sc or {0,0,0}, ix = ix or x or 0, iy = iy or y or 0, is = is or 1.1,
	}

	if tbl.i then tbl.d = true end

	local mt = {
		__index = Button,
	}

	return setmetatable(tbl,mt)
end
