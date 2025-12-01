extends Sprite2D


var animName = "HIT"
@onready var animation = $AnimationPlayer
var frameCounter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play(animName)

func _physics_process(_delta):
	frameCounter += 1
	
	if animName != "DIZZY":
		if frameCounter >= 21:
			queue_free()
