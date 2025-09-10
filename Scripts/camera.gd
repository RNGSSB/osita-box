extends Camera2D


var randomShakeStrenght: float = 10.0
var shakeFade: float = 5.0
var shake_strenght: float = 0.0

var rng = RandomNumberGenerator.new()


func apply_shake():
	shake_strenght = randomShakeStrenght

func randomOffset():
	return Vector2(rng.randf_range(shake_strenght, -shake_strenght), 0)


func cameraShake(delta):
	if shake_strenght > 0:
		shake_strenght = lerpf(shake_strenght,0, shakeFade * delta)
		offset = randomOffset()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !owner.frameAdvance:
		cameraShake(delta)
