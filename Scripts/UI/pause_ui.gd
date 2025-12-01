extends CanvasLayer

@onready var resumeButton = $Resume
@onready var optionsButton = $Options
@onready var restartButton = $Restart
@onready var menuButton = $Menu

var select = 0
var menuMin = 0
var menuMax = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !Options.visible and !InputMapper.visible:
		if Input.is_action_just_pressed("ui_cancel") and !Options.holdOn:
			select = 0
			owner.isPaused = false
			owner.fuckYou2 = false
		
		if Input.is_action_just_released("ui_cancel"):
			Options.holdOn = false
		
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
				if !resumeButton.has_focus():
					resumeButton.grab_focus()
			1:
				if !restartButton.has_focus():
					restartButton.grab_focus()
			2:
				if !optionsButton.has_focus():
					optionsButton.grab_focus()
			3:
				if !menuButton.has_focus():
					menuButton.grab_focus()


func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(Gamemanager.menu)


func _on_options_pressed():
	Options.visible = true
	Options.vsyncCheck.grab_focus()


func _on_resume_pressed():
	select = 0
	owner.isPaused = false
	owner.fuckYou2 = false


func _on_restart_pressed():
	get_tree().reload_current_scene()


func _on_options_mouse_entered():
	if !Options.visible and !InputMapper.visible:
		select = 2
		optionsButton.grab_focus()


func _on_restart_mouse_entered():
	if !Options.visible and !InputMapper.visible:
		select = 1
		restartButton.grab_focus()


func _on_resume_mouse_entered():
	if !Options.visible and !InputMapper.visible:
		select = 0
		resumeButton.grab_focus()


func _on_menu_mouse_entered():
	if !Options.visible and !InputMapper.visible:
		select = 3
		menuButton.grab_focus()
