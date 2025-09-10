extends Node


var effects = preload("res://Scenes/effect.tscn")


func createEffects(name, scaleX, scaleY, posX, posY):
	var instance = effects.instantiate()
	instance.name = name
	instance.animName = name
	instance.position.y = posY
	instance.position.x = posX
	instance.scale = Vector2(scaleX, scaleY)
	get_node("/root/Game").add_child(instance)



func destroyEffect(name):
	get_node("/root/Game/" + name).queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
