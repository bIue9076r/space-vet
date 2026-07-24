-- Normalize Mouse inputs to screen
function NormalizeMouse(x,y)
	local ain = G_ASPECT_INDEX_EVAL()
	local cx = (CSCREEN_X - (ain * SCREEN_X))/2
	local cy = (CSCREEN_Y - (ain * SCREEN_Y))/2
	x = SCREEN_X*((x - cx) / (ain * SCREEN_X))
	y = SCREEN_Y*((y - cy) / (ain * SCREEN_Y))
	x = math.max(0,math.min(x,SCREEN_X))
	y = math.max(0,math.min(y,SCREEN_Y))
	return x,y
end
