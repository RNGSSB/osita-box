extends Node2D


func Play(name, audiobus, volume, pitch):
	if get_node(name) == null:
		print("No SFX found dumbass")
		return
	get_node(name).bus = audiobus
	get_node(name).volume_db = volume
	get_node(name).pitch_scale = pitch
	get_node(name).play()

func Stop(name):
	if get_node(name) == null:
		print("No SFX found dumbass")
		return
	get_node(name).stop()

func _process(delta):
	pass
