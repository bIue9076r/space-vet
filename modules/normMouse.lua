-- Normalize Mouse inputs to screen
function NormalizeMouse(x,y)
	local cx = (SCREEN_X - (ASPECT_INDEX * SCREEN_X_O))/2
	local cy = (SCREEN_Y - (ASPECT_INDEX * SCREEN_Y_O))/2
	x = SCREEN_X_O*((x - cx) / (ASPECT_INDEX * SCREEN_X_O))
	y = SCREEN_Y_O*((y - cy) / (ASPECT_INDEX * SCREEN_Y_O))
	x = math.max(0,math.min(x,SCREEN_X_O))
	y = math.max(0,math.min(y,SCREEN_Y_O))
	return x,y
end
