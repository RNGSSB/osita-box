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

var stunned = false

var counterPunch = false
var counterColor = Color8(255,164,167,255)

var hitlagPunch = 3
var hitlagUpper = 3
var shakePunch = 10
var shakeUpper = 10

var dizzy = 0
var dizzyTime = 90

var finalHitlagMul = 4
var finalShakeMul = 4

var enemyRef

var normalCombo = 1
var dodgeCombo = 2
var perfectCombo = 4

var punchHit = false

var hitCount = 0
var maxHitCount = 5

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

func punchOpponent(value):
	enemyRef = owner.player
	if value == 0: #Dodge Left
		if !enemyRef.dodgeLeft:
			punchHit = true
			enemyRef.flip_h = true
			owner.hitLag(0,25)
			AudioManager.Play("res://SFX/Hit/Hurt.wav", "Right", 1.0, 1.0)
			Gamemanager.createEffects("HIT", 3.0, 3.0, 0, 0)
			enemyRef.stateMachine.change_state2("DamageN")
			enemyRef.position.x = 250
		else:
			enemyRef.dodgeSuccess = true
			AudioManager.Play("res://SFX/Player/Dodge.ogg", "Left", 1.0, 1.0)
			maxHitCount = dodgeCombo
			if enemyRef.stateFrame <= enemyRef.perfectTiming:
				maxHitCount = perfectCombo
				AudioManager.Play("res://SFX/Player/Perfect.wav", "Left", 1.0, 1.0)
				enemyRef.perfectDodge = true
	elif value == 1: #Dodge Right
		if !enemyRef.dodgeRight:
			punchHit = true
			enemyRef.flip_h = false
			owner.hitLag(0,25)
			AudioManager.Play("res://SFX/Hit/Hurt.wav", "Right", 1.0, 1.0)
			Gamemanager.createEffects("HIT", 3.0, 3.0, 0, 0)
			enemyRef.stateMachine.change_state2("DamageN")
			enemyRef.position.x = -250
		else:
			enemyRef.dodgeSuccess = true
			AudioManager.Play("res://SFX/Player/Dodge.ogg", "Right", 1.0, 1.0)
			maxHitCount = dodgeCombo
			if enemyRef.stateFrame <= enemyRef.perfectTiming:
				maxHitCount = perfectCombo
				AudioManager.Play("res://SFX/Player/Perfect.wav", "Right", 1.0, 1.0)
				enemyRef.perfectDodge = true
	elif value == 2: #Dodge Down
		if !enemyRef.dodgeDown:
			punchHit = true
			owner.hitLag(0,25)
			AudioManager.Play("res://SFX/Hit/Hurt.wav", "SFX", 1.0, 1.0)
			Gamemanager.createEffects("HIT", 3.0, 3.0, 0, 0)
			enemyRef.stateMachine.change_state2("DamageN")
		else:
			enemyRef.dodgeSuccess = true
			AudioManager.Play("res://SFX/Player/Dodge.ogg", "SFX", 1.0, 1.0)
			maxHitCount = dodgeCombo
			if enemyRef.stateFrame <= enemyRef.perfectTiming:
				maxHitCount = perfectCombo
				AudioManager.Play("res://SFX/Player/Perfect.wav", "SFX", 1.0, 1.0)
				enemyRef.perfectDodge = true
	elif value == 3: #Dodge All
		if !enemyRef.dodgeLeft and !enemyRef.dodgeRight and !enemyRef.dodgeDown:
			punchHit = true
			owner.hitLag(0,25)
			AudioManager.Play("res://SFX/Hit/Hurt.wav", "SFX", 1.0, 1.0)
			Gamemanager.createEffects("HIT", 3.0, 3.0, 0, 0)
			enemyRef.stateMachine.change_state2("DamageN")
		else:
			enemyRef.dodgeSuccess = true
			AudioManager.Play("res://SFX/Player/Dodge.ogg", "SFX", 1.0, 1.0)
			maxHitCount = dodgeCombo
			if enemyRef.stateFrame <= enemyRef.perfectTiming:
				maxHitCount = perfectCombo
				AudioManager.Play("res://SFX/Player/Perfect.wav", "SFX", 1.0, 1.0)
				enemyRef.perfectDodge = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		stateMachine.change_state2("Attack1")

func _physics_process(delta):
	
	if counterPunch:
		modulate = counterColor
	else:
		modulate = Color8(255,255,255,255)
	
	if Input.is_action_just_pressed("Freeze"):
		pass
