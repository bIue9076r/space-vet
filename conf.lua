function love.conf(t)
	t.version = "11.3"
	t.console = true--false
	t.window.width = 800
	t.window.height = 600
	t.window.minwidth = 800
	t.window.minheight = 600
	t.window.icon = "/Assets/Game_Icon.png"
	t.window.title = "Help from a Terrestrial"
	t.identity = "help_terra"
	t.window.resizable = true
	t.window.fullscreen = false

	t.modules.audio = true
	t.modules.data = false
	t.modules.event = true
	t.modules.font = true
	t.modules.graphics = true
	t.modules.image = true
	t.modules.joystick = false
	t.modules.keyboard = true
	t.modules.math = true
	t.modules.mouse = true
	t.modules.physics = false
	t.modules.sound = true
	t.modules.system = false
	t.modules.thread = false
	t.modules.timer = true
	t.modules.touch = false
	t.modules.video = true
	t.modules.window = true
end