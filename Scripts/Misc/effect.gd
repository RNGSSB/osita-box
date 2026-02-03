extends Sprite2D


var animName = "HIT"
@onready var animation = $AnimationPlayer
@export var animSys : Node
var frameCounter = 0
var defaultPosY = -1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	animSys.animPlay(animName)

func _physics_process(_delta):
	
	if !owner.frameAdvance:
		animSys.frozen = false
		frameCounter += 1
		
		if animSys.animEnd:
			queue_free()
	else:
		animSys.frozen = true
		
		if Input.is_action_just_pressed("FrameAdvance"):
			frameCounter += 1
			animSys.animationProcess()
