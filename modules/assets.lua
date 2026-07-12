Sound = {Contents = {}}
Video = {Contents = {}}
Image = {Contents = {}}
Font = {Contents = {}}

function Sound.new(Index, Path, Type)
	Sound.Contents[Index] = love.audio.newSource(Path,Type or "stream")
end

function Sound.get(Index)
	return Sound.Contents[Index] or Sound.Contents[0]
end

function Video.new(Index, Path)
	Video.Contents[Index] = love.graphics.newVideo(Path)
end

function Video.get(Index)
	return Video.Contents[Index] or Video.Contents[0]
end

function Image.new(Index, Path)
	Image.Contents[Index] = love.graphics.newImage(Path)
end

function Image.get(Index)
	return Image.Contents[Index] or Image.Contents[0]
end

function Font.new(Index, Path, Size)
	Font.Contents[Index] = love.graphics.newFont(Path, Size or 12)
end

function Font.get(Index)
	return Font.Contents[Index] or Font.Contents[0]
end
