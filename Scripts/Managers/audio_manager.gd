extends Node2D


func Play(soundName, audiobus, volume, pitch):
	if get_node(soundName) == null:
		print("No SFX found dumbass")
		return
	get_node(soundName).bus = audiobus
	get_node(soundName).volume_db = volume
	get_node(soundName).pitch_scale = pitch
	get_node(soundName).play()

func Stop(soundName):
	if get_node(soundName) == null:
		print("No SFX found dumbass")
		return
	get_node(soundName).stop()

func _process(_delta):
	pass
