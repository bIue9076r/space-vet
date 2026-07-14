-- Normalize Mouse inputs to screen
function NormalizeMouse(x,y)
	local cx = (CSCREEN_X - (ASPECT_INDEX * SCREEN_X))/2
	local cy = (CSCREEN_Y - (ASPECT_INDEX * SCREEN_Y))/2
	x = SCREEN_X*((x - cx) / (ASPECT_INDEX * SCREEN_X))
	y = SCREEN_Y*((y - cy) / (ASPECT_INDEX * SCREEN_Y))
	x = math.max(0,math.min(x,SCREEN_X))
	y = math.max(0,math.min(y,SCREEN_Y))
	return x,y
end
