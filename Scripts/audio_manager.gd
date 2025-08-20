extends Node2D


func Play(name, audiobus, volume, pitch):
	var stream = AudioStreamPlayer.new()
	stream.name = name
	if get_node("/root/AudioManager/" + stream.name) != null:
		get_node("/root/AudioManager/" + stream.name).bus = audiobus
		get_node("/root/AudioManager/" + stream.name).volume_db = volume
		get_node("/root/AudioManager/" + stream.name).pitch_scale = pitch
		get_node("/root/AudioManager/" + stream.name).play()
		return
	stream.stream = load(name)
	stream.bus = audiobus
	stream.volume_db = volume
	stream.pitch_scale = pitch
	self.add_child(stream)
	
	stream.play()
	stream.connect("finished", Callable(stream, "queue_free"))
