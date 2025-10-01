extends Node


var effects = preload("res://Scenes/effect.tscn")

var menu = "res://Scenes/menu.tscn"

var players = [preload("res://Scenes/Players/canela.tscn")]
var enemyList = [preload("res://Scenes/Enemy/cardemomo.tscn"),
preload("res://Scenes/Enemy/cardemomo2.tscn")]

var playerId = 0
var enemyId = 0

#Players: Canela - 0
#Enemies: Cardemomo - 0, Pau - 1

var fuckYou3 = false
var prevScreenMode


func createEffects(name = "HIT", scaleX = 1.0, scaleY = 1.0, posX = 0, posY = 0, zIndex = 3, flip = false):
	var instance = effects.instantiate()
	instance.name = name
	instance.animName = name
	instance.position.y = posY
	instance.position.x = posX
	instance.z_index = zIndex
	instance.flip_h = flip
	instance.scale = Vector2(scaleX, scaleY)
	get_node("/root/Game/GameElements").add_child(instance)



func destroyEffect(name):
	if get_node("/root/Game/GameElements/" + name) == null:
		return
	get_node("/root/Game/GameElements/" + name).queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
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
