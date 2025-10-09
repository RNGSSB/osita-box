extends CanvasLayer

const optionsSave = "user://options.save"

var masterVolume = -30

@onready var volumeSlider = $"Panel/VBoxContainer/Master Volume"
@onready var volumeLabel = $"Panel/VBoxContainer/Volume Label"
@onready var fullScreenCheck = $Panel/VBoxContainer/Fullscreen
@onready var vsyncCheck = $Panel/VBoxContainer/Vsync
@onready var backButton = $Panel/VBoxContainer/Back
@onready var inputButton = $Panel/VBoxContainer/Controls

var select = 0
var menuMin = 0
var menuMax = 4

var holdOn = false

var vsync = false
var fullscreen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	loadData()
	fullScreenCheck.button_pressed = fullscreen
	vsyncCheck.button_pressed = vsync
	volumeSlider.value = masterVolume
	volumeLabel.text = str(volumeSlider.value + 100) 
	AudioServer.set_bus_volume_db(0, volumeSlider.value)
	if fullscreen:
		Gamemanager.fuckYou3 = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		Gamemanager.fuckYou3 = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func SaveData():
	var file = FileAccess.open(optionsSave, FileAccess.WRITE)
	file.store_var(vsync)
	fullscreen = fullScreenCheck.button_pressed
	file.store_var(fullscreen)
	file.store_var(masterVolume)
	print("Data Saved!")

func loadData():
	if FileAccess.file_exists(optionsSave):
		var file = FileAccess.open(optionsSave, FileAccess.READ)
		vsync = file.get_var(vsync)
		fullscreen = file.get_var(fullscreen)
		masterVolume = file.get_var(masterVolume)
		print("Data Loaded!")
	else:
		vsync = false
		fullscreen = false
		masterVolume = -30
		print("No data found")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		if Gamemanager.checkInputJustPressed("Start"):
			select = 0
			holdOn = false
			SaveData()
			visible = false
		if Gamemanager.checkInputJustPressed("ui_cancel"):
			select = 0
			holdOn = true
			SaveData()
			visible = false
		if Gamemanager.checkInputJustPressed("Down"):
			select += 1
		if Gamemanager.checkInputJustPressed("Up"):
			select -= 1
		
		if select < menuMin:
			select = menuMax
		
		if select > menuMax:
			select = menuMin
		
		match select:
			0:
				if !vsyncCheck.has_focus():
					vsyncCheck.grab_focus()
			1:
				if !fullScreenCheck.has_focus():
					fullScreenCheck.grab_focus()
			2:
				if !volumeSlider.has_focus():
					volumeSlider.grab_focus()
			4:
				if !backButton.has_focus():
					backButton.grab_focus()
			3:
				if !inputButton.has_focus():
					inputButton.grab_focus()


func _on_master_volume_value_changed(value):
	masterVolume = value
	
	if masterVolume == volumeSlider.min_value:
		AudioServer.set_bus_volume_db(0, -100)
		volumeLabel.text = "Mute"
	else:
		volumeLabel.text = str(value + 100)
		AudioServer.set_bus_volume_db(0, value)


func _on_back_pressed():
	select = 0
	SaveData()
	visible = false


func _on_fullscreen_pressed():
	if fullScreenCheck.button_pressed:
		fullscreen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		Gamemanager.fuckYou3 = true
		return
	else:
		fullscreen = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Gamemanager.fuckYou3 = false
		return


func _on_vsync_pressed():
	if vsyncCheck.button_pressed:
		vsync = true
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		vsync = false
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _on_vsync_mouse_entered():
	if !InputMapper.visible:
		select = 0
		vsyncCheck.grab_focus()


func _on_fullscreen_mouse_entered():
	if !InputMapper.visible:
		select = 1
		fullScreenCheck.grab_focus()


func _on_master_volume_mouse_entered():
	if !InputMapper.visible:
		select = 2
		volumeSlider.grab_focus()


func _on_back_mouse_entered():
	if !InputMapper.visible:
		select = 4
		backButton.grab_focus()


func _on_controls_pressed():
	visible = false
	InputMapper.canPress = true
	InputMapper.selectX = 0
	InputMapper.selectY = 0
	InputMapper.setting = false
	InputMapper.visible = true


func _on_controls_mouse_entered():
	if !InputMapper.visible:
		select = 3
		inputButton.grab_focus()
