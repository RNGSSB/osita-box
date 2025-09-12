extends Sprite2D

var frozen = false
var CURRSTATE = "Wait"
var PREVSTATE = "Wait"
@onready var stateMachine = $StateMachine

var charName = "Cardemomo"
var stateFrame = 0
var frameCounter = 0
var prevStateFrame = 0 

var hitLeft = false
var hitRight = false
var hitUpLeft = false
var hitUpRight = false

var blockLeft = false
var blockRight = false
var blockUpLeft = false
var blockUpRight = false

var stunned = false

var counterPunch = false
var counterColor = Color8(255,164,167,255)

var hitlagPunch = 3
var hitlagUpper = 3
var shakePunch = 13
var shakeUpper = 13

var dizzy = 0
var dizzyTime = 90

var finalHitlagMul = 4
var finalShakeMul = 4

var enemyRef

var normalCombo = 2
var dodgeCombo = 4
var perfectCombo = 6

var punchHit = false

var hitCount = 0
var maxHitCount = 5

var maxHealth = 120
var health = 120

var aiActive = false

var rng = RandomNumberGenerator.new()

var superInit = 20

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
preload("res://Sprites/Characters/Cardemomo/A13DamageLw4Counter.png"),
preload("res://Sprites/Characters/Cardemomo/A14Attack2Start.png"),
preload("res://Sprites/Characters/Cardemomo/A15AttackHit.png"),
preload("res://Sprites/Characters/Cardemomo/A16AttackMiss.png"),
preload("res://Sprites/Characters/Cardemomo/A17DamageLw4L.png"),
preload("res://Sprites/Characters/Cardemomo/A18DamageHi4L.png"),
preload("res://Sprites/Characters/Cardemomo/A19DamageLw4CounterL.png"),]

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

func punchHitFunc(damage = 1, meter = 1, damageState = "DamageS", playerX = 0, flip = false, 
hitlag = 3, shake = 25, 
sfx = "Hurt", volume = 1.0, pitch = 1.0, audioBus = "SFX", 
effectName = "HIT", scaleX = 1.0, scaleY = 1.0, posX = 0, posY = 0):
	Engine.physics_ticks_per_second = 60
	Engine.time_scale = 1.0
	enemyRef = owner.player
	owner.playerUpdateHealth(damage)
	punchHit = true
	enemyRef.flip_h = flip
	enemyRef.superMeter -= meter
	owner.hitLag(hitlag, shake)
	AudioManager.Play(sfx, audioBus, volume, pitch)
	Gamemanager.createEffects(effectName, scaleX, scaleY, posX, posY)
	enemyRef.stateMachine.change_state2(damageState)
	enemyRef.position.x = playerX

func punchDodgeFunc(audioBus):
	enemyRef = owner.player
	enemyRef.dodgeSuccess = true
	AudioManager.Play("Dodge", audioBus, 1.0, 1.0)
	enemyRef.hasCombo = true
	maxHitCount = dodgeCombo
	if enemyRef.stateFrame <= enemyRef.perfectTiming:
		enemyRef.superMeter += enemyRef.perfectDodgeMeterGain
		maxHitCount = perfectCombo
		AudioManager.Play("Perfect", audioBus, 1.0, 1.0)
		enemyRef.perfectDodge = true

func punchBlockFunc(audioBus, meter):
	enemyRef = owner.player
	owner.hitLag(5, 15)
	hitLeft = true
	hitRight = true
	hitUpLeft = true
	hitUpRight = true
	maxHitCount = normalCombo
	enemyRef.hasCombo = true
	enemyRef.superMeter -= meter / 2
	AudioManager.Play("Block", audioBus, 1.0, 1.0)
	Gamemanager.createEffects("BLOCK", 1.5, 1.5, 0, 200, 1, true)
	enemyRef.stateMachine.change_state2("BlockDamage")
	stun()
	punchHit = false

func punchOpponent(value = 0, damage = 1, meter = 1, blockable = true, 
hitLag = 3, screenShake = 25, 
sfx = "Hurt", volume = 1.0, pitch = 1.0, 
effect = "HIT", scaleX = 1.0, scaleY = 1.0, posX = 1.0, posY = 1.0):
	enemyRef = owner.player
	if value == 0: #Dodge Left
		if enemyRef.isBlocking and blockable and enemyRef.superMeter > 0:
			punchBlockFunc("Left", meter)
			return
		if !enemyRef.dodgeLeft:
			punchHitFunc(damage, meter, "DamageS", 250, true, hitLag, screenShake, 
			sfx, volume, pitch, "Right", effect, scaleX, scaleY, posX, posY)
		else:
			punchDodgeFunc("Left")
	elif value == 1: #Dodge Right
		if enemyRef.isBlocking and blockable and enemyRef.superMeter > 0:
			punchBlockFunc("Right", meter)
			return
		if !enemyRef.dodgeRight:
			punchHitFunc(damage, meter, "DamageS", -250, false, hitLag, screenShake, 
			sfx, volume, pitch, "Right", effect, scaleX, scaleY, posX, posY)
		else:
			punchDodgeFunc("Right")
	elif value == 2: #Dodge Down
		if enemyRef.isBlocking and blockable and enemyRef.superMeter > 0:
			punchBlockFunc("SFX", meter)
			return
		if !enemyRef.dodgeDown:
			punchHitFunc(damage, meter, "DamageN", 0, false, hitLag, screenShake, 
			sfx, volume, pitch, "SFX", effect, scaleX, scaleY, posX, posY)
		else:
			punchDodgeFunc("SFX")
	elif value == 3: #Dodge All
		if enemyRef.isBlocking and blockable and enemyRef.superMeter > 0:
			punchBlockFunc("SFX", meter)
			return
		if !enemyRef.dodgeLeft and !enemyRef.dodgeRight and !enemyRef.dodgeDown:
			punchHitFunc(damage, meter, "DamageN", 0, false, hitLag, screenShake, 
			sfx, volume, pitch, "SFX", effect, scaleX, scaleY, posX, posY)
		else:
			punchDodgeFunc("SFX")

func stun():
	hitLeft = true
	hitRight = true
	hitUpLeft = true
	hitUpRight = true
	blockLeft = false
	blockRight = false
	blockUpLeft = false
	blockUpRight = false
	stunned = true

func Guard(left, right, upLeft, upRight):
	blockLeft = left
	blockRight = right
	blockUpLeft = upLeft
	blockUpRight = upRight

# Called when the node enters the scene tree for the first time.
func _ready():
	health = maxHealth


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_1):
		aiActive = true
	
	if Input.is_key_pressed(KEY_2):
		aiActive = false
	
	lobotomy()

func lobotomy():
	if aiActive:
		if rng.randi_range(0, 200) == 199 and (CURRSTATE == "Wait" or CURRSTATE == "Block"):
			stateMachine.change_state2("Attack1")
		if rng.randi_range(0, 200) == 198 and (CURRSTATE == "Wait" or CURRSTATE == "Block"):
			stateMachine.change_state2("Attack2")
		if rng.randi_range(0, 200) == 197 and (CURRSTATE == "Wait" or CURRSTATE == "Block"):
			stateMachine.change_state2("Attack3")
	else:
		if Input.is_key_pressed(KEY_3):
			stateMachine.change_state2("Attack1")
		if Input.is_key_pressed(KEY_4):
			stateMachine.change_state2("Attack2")
		if Input.is_key_pressed(KEY_5):
			stateMachine.change_state2("Attack3")

func _physics_process(delta):
	if health < 0:
		health = 0
	
	
	if counterPunch:
		modulate = counterColor
	else:
		modulate = Color8(255,255,255,255)
	
	if Input.is_action_just_pressed("Freeze"):
		pass
