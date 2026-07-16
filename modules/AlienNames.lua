Name = {}
Name.AlienNames = {}

function Name.get(path)
	path = path or "/Assets/TextNames_English.txt"
	local info = love.filesystem.getInfo(path)
	if info then
		if info.type == "file" then
			for v in love.filesystem.lines(path) do
				table.insert(Name.AlienNames,v)
			end
		else
			Panic("Error: Text File is a Directory", "Name.get")
		end
	else
		Panic("Error: No Text File at Path", "Name.get")
	end
end

-- Generates random alien name
function Name.Generate()
	return Name.AlienNames[math.random(1,#Name.AlienNames)]
end
