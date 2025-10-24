extends Node2D


var gameScene = preload("res://Scenes/game.tscn")

@onready var carde1 = $CanvasLayer/VBoxContainer/Cardemomo
@onready var carde2 = $CanvasLayer/VBoxContainer/Character2
@onready var setting = $CanvasLayer/VBoxContainer/Settings
@onready var quit = $CanvasLayer/VBoxContainer/Quit
@onready var paletteSlider = $CanvasLayer/PaletteSlider
@onready var paletteLabel = $CanvasLayer/Palette


var select = 0
var menuMin = 0
var menuMax = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	paletteSlider.max_value = Gamemanager.playerPalettes.size() - 1 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if !Options.visible and !InputMapper.visible:
		carde1.disabled = false
		carde2.disabled = false
		setting.disabled = false
		quit.disabled = false
		
		paletteLabel.text = str(paletteSlider.value + 1)
		
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
				if !carde1.has_focus():
					carde1.grab_focus()
			1:
				if !carde2.has_focus():
					carde2.grab_focus()
			2:
				if !setting.has_focus():
					setting.grab_focus()
			3:
				if !quit.has_focus():
					quit.grab_focus()
	else:
		carde1.disabled = true
		carde2.disabled = true
		setting.disabled = true
		quit.disabled = true


func _on_cardemomo_pressed():
	Gamemanager.playerId = 0
	Gamemanager.playerPaletteId = paletteSlider.value
	Gamemanager.enemyId = 0
	Options.visible = true
	get_tree().change_scene_to_packed(gameScene)


func _on_character_2_pressed():
	Gamemanager.playerId = 0
	Gamemanager.playerPaletteId = paletteSlider.value
	Gamemanager.enemyId = 1
	Options.visible = true
	get_tree().change_scene_to_packed(gameScene)


func _on_settings_pressed():
	Options.visible = true


func _on_quit_pressed():
	get_tree().quit()


func _on_cardemomo_mouse_entered():
	if !Options.visible and !InputMapper.visible:
		select = 0
		carde1.grab_focus()


func _on_character_2_mouse_entered():
	if !Options.visible and !InputMapper.visible:
		select = 1
		carde2.grab_focus()


func _on_settings_mouse_entered():
	if !Options.visible and !InputMapper.visible:
		select = 2
		setting.grab_focus()


func _on_quit_mouse_entered():
	if !Options.visible and !InputMapper.visible:
		select = 3
		quit.grab_focus()
