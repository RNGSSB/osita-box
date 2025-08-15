extends Sprite2D

var frozen = false
var CURRSTATE = "Wait"
var PREVSTATE = "Wait"
@onready var stateMachine = $StateMachine

var stateFrame = 0
var frameCounter = 0
var prevStateFrame = 0 

var hitLeft = false
var hitRight = false
var hitUpLeft = false
var hitUpRight = false

var counterPunch = false
var counterColor = Color8(255,164,167,255)

var hitlagPunch = 3
var hitlagUpper = 3
var shakePunch = 10
var shakeUpper = 10

var finalHitlagMul = 4
var finalShakeMul = 4

var animSheets = [preload("res://Sprites/Characters/Cardemomo/A00Wait.png"),
preload("res://Sprites/Characters/Cardemomo/A01GuardLw.png"),
preload("res://Sprites/Characters/Cardemomo/A02GuardHi.png"),
preload("res://Sprites/Characters/Cardemomo/A03DamageLw.png"),
preload("res://Sprites/Characters/Cardemomo/A04DamageLw4.png"),
preload("res://Sprites/Characters/Cardemomo/A05DizzyLw.png"),
preload("res://Sprites/Characters/Cardemomo/A06DamageHi.png"),
preload("res://Sprites/Characters/Cardemomo/A07DamageHi4.png"),
preload("res://Sprites/Characters/Cardemomo/A08DizzyHi.png"),
preload("res://Sprites/Characters/Cardemomo/A09Attack1Start.png"),
preload("res://Sprites/Characters/Cardemomo/A10Attack1Hit.png"),
preload("res://Sprites/Characters/Cardemomo/A11Attack1Miss.png"),
preload("res://Sprites/Characters/Cardemomo/A12CardeKick.png"),
preload("res://Sprites/Characters/Cardemomo/A13DamageLw4Counter.png"),]

func spriteOffsets(x, y, value):
	hframes = x
	vframes = y
	texture = animSheets[value]

func cFrame(value):
	if stateFrame == value:
		return true
	else:
		return false

func setFrame(value):
	frame = value

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	
	if counterPunch:
		modulate = counterColor
	else:
		modulate = Color8(255,255,255,255)
	
	if Input.is_action_just_pressed("Freeze"):
		pass
