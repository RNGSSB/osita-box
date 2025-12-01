extends Node


var effects = preload("res://Scenes/effect.tscn")

var menu = "res://Scenes/menu.tscn"

var players = ["res://Scenes/Players/canela.tscn"]
var playerPalettes = ["res://Scenes/Players/Palettes/default.tscn",
"res://Scenes/Players/Palettes/test.tscn",
"res://Scenes/Players/Palettes/test2.tscn",
"res://Scenes/Players/Palettes/test3.tscn",
"res://Scenes/Players/Palettes/test4.tscn",
"res://Scenes/Players/Palettes/test5.tscn",
"res://Scenes/Players/Palettes/test6.tscn"]
var enemyList = ["res://Scenes/Enemy/cardemomo.tscn",
"res://Scenes/Enemy/cardemomo2.tscn"]

var playerId = 0
var playerPaletteId = 0
var enemyId = 0

#Players: Canela - 0
#Enemies: Cardemomo - 0, Pau - 1

var fuckYou3 = false
var prevScreenMode


func createEffects(effectName = "HIT", scaleX = 1.0, scaleY = 1.0, posX = 0, posY = 0, zIndex = 3, flip = false):
	var instance = effects.instantiate()
	instance.name = effectName
	instance.animName = effectName
	instance.position.y = posY
	instance.position.x = posX
	instance.z_index = zIndex
	instance.flip_h = flip
	instance.scale = Vector2(scaleX, scaleY)
	get_node("/root/Game/GameElements").add_child(instance)


func checkInputJustPressed(inputName):
	if Input.is_action_just_pressed(inputName):
		return true
	elif Input.is_action_just_pressed(inputName + "Key"):
		return true
	elif Input.is_action_just_pressed(inputName + "2"):
		return true
	elif Input.is_action_just_pressed(inputName + "Key2"):
		return true
	else:
		return false

func checkInputJustReleased(inputName):
	if Input.is_action_just_released(inputName):
		return true
	elif Input.is_action_just_released(inputName + "Key"):
		return true
	elif Input.is_action_just_released(inputName + "2"):
		return true
	elif Input.is_action_just_released(inputName + "Key2"):
		return true
	else:
		return false

func checkInputHold(inputName):
	if Input.is_action_pressed(inputName):
		return true
	elif Input.is_action_pressed(inputName + "Key"):
		return true
	elif Input.is_action_pressed(inputName + "2"):
		return true
	elif Input.is_action_pressed(inputName + "Key2"):
		return true
	else:
		return false

func checkInputAxis(neg, pos):
	if Input.get_axis(neg, pos) != 0:
		return Input.get_axis(neg, pos)
	elif Input.get_axis(neg + "Key", pos + "Key") != 0:
		return Input.get_axis(neg + "Key", pos + "Key") 
	elif Input.get_axis(neg + "2", pos + "2") != 0:
		return Input.get_axis(neg + "2", pos + "2") 
	elif Input.get_axis(neg + "Key2", pos + "Key2") != 0:
		return Input.get_axis(neg + "Key2", pos + "Key2") 
	else:
		return 0


func destroyEffect(effectName):
	if get_node("/root/Game/GameElements/" + effectName) == null:
		return
	get_node("/root/Game/GameElements/" + effectName).queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	print(OS.get_data_dir())

func _process(_delta):
	#print(InputMap.action_get_events("LeftPunch2")[0].as_text())
	
	if Input.is_action_just_pressed("Fullscreen") and !fuckYou3:
		Options.fullScreenCheck.button_pressed = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN) 
	
	if Input.is_action_just_released("Fullscreen") and !fuckYou3 and DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		fuckYou3 = true
	
	if Input.is_action_just_pressed("Fullscreen") and fuckYou3 :
		Options.fullScreenCheck.button_pressed = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
	
	if Input.is_action_just_released("Fullscreen") and fuckYou3 and DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		fuckYou3 = false
