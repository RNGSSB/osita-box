extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar

var prevHealth = 0
var health = 0

func set_health(newHealth):
	prevHealth = value
	value = newHealth
	health = value
	timer.start()
	
	


func _on_timer_timeout():
	damage_bar.value = value
	print("deez")
