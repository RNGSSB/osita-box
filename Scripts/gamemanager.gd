extends Node


var effects = preload("res://Scenes/effect.tscn")


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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
