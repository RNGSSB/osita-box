extends CanvasLayer

@onready var volumeSlider = $HSlider

var masterVolume = 0

@onready var volumeLabel = $GayLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	volumeLabel.text = str(volumeSlider.value + 100) 
	AudioServer.set_bus_volume_db(0, volumeSlider.value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_h_slider_value_changed(value):
	masterVolume = value
	
	if masterVolume == volumeSlider.min_value:
		AudioServer.set_bus_volume_db(0, -100)
		volumeLabel.text = "Mute"
	else:
		volumeLabel.text = str(value + 100)
		AudioServer.set_bus_volume_db(0, value)
