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

var guardAll = false

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

var normalCombo = 2
var dodgeCombo = 4
var perfectCombo = 6

var punchHit = false
var attackMiss = false
var isAttacking = false

var healing = false

var hitCount = 0
var maxHitCount = 5

var maxHealth = 100
var health = 100

var aiActive = false

var damaged = false
var damageStopTimer = false

var rng = RandomNumberGenerator.new()

var superInit = 40

var R = 255
var G = 255
var B = 255

var playerPunch = 0 
var flipDamageLw = true
var flipDamageHi = true
var flipDamageCounterLw = true
var flipDamageCounterHi = false

@onready var brain = $Brain

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
preload("res://Sprites/Characters/Cardemomo/A19DamageLw4CounterL.png"),
preload("res://Sprites/Characters/Cardemomo/A20Attack4Start.png"),
preload("res://Sprites/Characters/Cardemomo/A21Attack4Hit.png"),
preload("res://Sprites/Characters/Cardemomo/A22Attack4Miss.png"),
preload("res://Sprites/Characters/Cardemomo/A23Dead.png"),]

func setColor(value1, value2, value3):
	R = value1 
	G = value2
	B = value3

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

func moveCamera(rate, towards):
	owner.moveCamera(rate, towards)

func moveCameraY(rate, towards):
	owner.moveCameraY(rate, towards)

func enemyHeal(value, rate):
	healing = true
	owner.enemyHealing = health + value
	if owner.enemyHealing > maxHealth:
		owner.enemyHealing = maxHealth
	owner.enemyHealingRate = rate

func punchHitFunc(damage = 1, meter = 1, damageState = "DamageS", playerX = 0, flip = false, 
hitlag = 3, shake = 25, 
sfx = "Hurt", volume = 1.0, pitch = 1.0, audioBus = "SFX", 
effectName = "HIT", scaleX = 1.0, scaleY = 1.0, posX = 0, posY = 0, animOverride = "no", posOverride = 0, dirOverride = false):
	#Engine.physics_ticks_per_second = 60
	#Engine.time_scale = 1.0
	enemyRef = owner.player
	owner.playerUpdateHealth(damage)
	punchHit = true
	attackMiss = false
	enemyRef.flip_h = flip
	if enemyRef.inBurnout:
		owner.hitLag(hitlag * 4, shake * 2)
	else:
		owner.hitLag(hitlag, shake)
	if enemyRef.superMeter == 0 and !enemyRef.inBurnout:
		owner.playerBurnout()
	enemyRef.superMeter -= meter
	AudioManager.Play(sfx, audioBus, volume, pitch)
	Gamemanager.createEffects(effectName, scaleX, scaleY, posX, posY)
	if animOverride == "no":
		enemyRef.stateMachine.change_state2(damageState)
		#enemyRef.position.x = playerX
	else:
		enemyRef.stateMachine.change_state2(animOverride)
		enemyRef.flip_h = dirOverride
		#enemyRef.position.x = posOverride

func punchDodgeFunc(audioBus, combo = 3, comboPerfect = 5):
	enemyRef = owner.player
	enemyRef.dodgeSuccess = true
	attackMiss = true
	AudioManager.Play("Dodge", audioBus, 1.0, 1.0)
	enemyRef.hasCombo = true
	maxHitCount = combo
	if enemyRef.stateFrame <= enemyRef.perfectTiming:
		enemyRef.superMeter += enemyRef.perfectDodgeMeterGain
		enemyRef.burnoutEnd()
		if enemyRef.superMeter >= enemyRef.superMax:
			enemyRef.gotSuper = true
		maxHitCount = comboPerfect
		AudioManager.Play("Perfect", audioBus, 1.0, 1.0)
		enemyRef.perfectDodge = true

func punchBlockFunc(audioBus, meter, guardMeter, stun, combo = 3):
	enemyRef = owner.player
	owner.hitLag(5, 15)
	hitLeft = true
	hitRight = true
	hitUpLeft = true
	hitUpRight = true
	if stun:
		maxHitCount = combo
		enemyRef.hasCombo = true
		punchHit = false
		attackMiss = true
	else:
		maxHitCount = normalCombo
		enemyRef.hasCombo = false
		punchHit = true
		attackMiss = true
	
	if enemyRef.superMeter <= 0 and !enemyRef.inBurnout:
		owner.playerBurnout()
	
	if guardMeter == -1:
		enemyRef.superMeter -= meter / 2
	else:
		enemyRef.superMeter -= guardMeter
	AudioManager.Play("Block", audioBus, 1.0, 1.0)
	Gamemanager.createEffects("BLOCK", 1.5, 1.5, 0, 200, 1, true)
	enemyRef.stateMachine.change_state2("BlockDamage")


func hitMasks(hitLeft, hitNeutral, hitRight, hitDown):
	enemyRef = owner.player
	if enemyRef.dodgeLeft:
		if hitLeft:
			return true
	elif enemyRef.dodgeRight:
		if hitRight:
			return true
	elif enemyRef.dodgeDown:
		if hitDown:
			return true
	elif !enemyRef.dodgeLeft and !enemyRef.dodgeRight and !enemyRef.dodgeDown:
		if hitNeutral:
			return true
	else:
		return false

func punchOpponent(value = 0, damage = 1, meter = 1, blockable = true, 
hitLag = 3, screenShake = 25, 
sfx = "Hurt", volume = 1.0, pitch = 1.0, 
effect = "HIT", scaleX = 1.0, scaleY = 1.0, posX = 1.0, posY = 1.0,
guardMeter = -1, blockStun = true, dodgeCombo = 3, blockCombo = 3, perfectCombo = 5, 
hitLeft = true, hitNeutral = true, hitRight = true, hitDown = true, 
animOverride = "no", posOverride = 0, dirOverride = false):
	enemyRef = owner.player
	if attackMiss or punchHit:
		return
	
	if value == 0: #Dodge Left
		if enemyRef.isBlocking and blockable and !enemyRef.inBurnout:
			punchBlockFunc("Left", meter, guardMeter, blockStun, blockCombo)
			return
		if !enemyRef.dodgeLeft:
			if hitMasks(hitLeft, hitNeutral, hitRight, hitDown):
				punchHitFunc(damage, meter, "DamageS", 250, true, hitLag, screenShake, 
				sfx, volume, pitch, "Left", effect, scaleX, scaleY, posX, posY, animOverride, posOverride, dirOverride)
			else:
				return
		else:
			punchDodgeFunc("Left", dodgeCombo, perfectCombo)
	elif value == 1: #Dodge Right
		if enemyRef.isBlocking and blockable and !enemyRef.inBurnout:
			punchBlockFunc("Right", meter, guardMeter, blockStun, blockCombo)
			return
		if !enemyRef.dodgeRight:
			if hitMasks(hitLeft, hitNeutral, hitRight, hitDown):
				punchHitFunc(damage, meter, "DamageS", -250, false, hitLag, screenShake, 
				sfx, volume, pitch, "Right", effect, scaleX, scaleY, posX, posY, animOverride, posOverride, dirOverride)
			else:
				return
		else:
			punchDodgeFunc("Right", dodgeCombo, perfectCombo)
	elif value == 2: #Dodge Down
		if enemyRef.isBlocking and blockable and !enemyRef.inBurnout:
			punchBlockFunc("SFX", meter, guardMeter, blockStun, blockCombo)
			return
		if !enemyRef.dodgeDown:
			if hitMasks(hitLeft, hitNeutral, hitRight, hitDown):
				punchHitFunc(damage, meter, "DamageN", 0, false, hitLag, screenShake, 
				sfx, volume, pitch, "SFX", effect, scaleX, scaleY, posX, posY, animOverride, posOverride, dirOverride)
			else:
				return
		else:
			punchDodgeFunc("SFX", dodgeCombo, perfectCombo)
	elif value == 3: #Dodge All
		if enemyRef.isBlocking and blockable and !enemyRef.inBurnout:
			punchBlockFunc("SFX", meter, guardMeter, blockStun, blockCombo)
			return
		if !enemyRef.dodgeLeft and !enemyRef.dodgeRight and !enemyRef.dodgeDown:
			if hitMasks(hitLeft, hitNeutral, hitRight, hitDown):
				punchHitFunc(damage, meter, "DamageN", 0, false, hitLag, screenShake, 
				sfx, volume, pitch, "SFX", effect, scaleX, scaleY, posX, posY, animOverride, posOverride, dirOverride)
			else:
				return
		else:
			punchDodgeFunc("SFX", dodgeCombo, perfectCombo)

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
		pass
	else:
		if Input.is_key_pressed(KEY_3):
			stateMachine.change_state2("Attack1")
		if Input.is_key_pressed(KEY_4):
			stateMachine.change_state2("Attack2")
		if Input.is_key_pressed(KEY_5):
			stateMachine.change_state2("Attack3")
		if Input.is_key_pressed(KEY_6):
			stateMachine.change_state2("Attack4")
		if Input.is_key_pressed(KEY_7):
			stateMachine.change_state2("Dead")

func _physics_process(delta):
	if health < 0:
		health = 0
	
	if (owner.player.CURRSTATE == "PunchLeft" or owner.player.CURRSTATE == "PunchRight" or owner.player.CURRSTATE == "UpperLeft" or owner.player.CURRSTATE == "UpperRight") and counterPunch:
		counterPunch = false
	
	if hitCount == maxHitCount and !owner.player.hasCombo:
		guardAll = true
	
	if damaged and !damageStopTimer and (CURRSTATE != "DizzyHi" and CURRSTATE != "DizzyLw" and CURRSTATE != "DizzyEnd"):
		owner.pauseTimer = true
		damageStopTimer = true
	
	if (!damaged or (CURRSTATE == "DizzyHi" or CURRSTATE == "DizzyLw" or CURRSTATE == "DizzyEnd" or CURRSTATE == "DamageN4" or CURRSTATE == "DamageHi4" or CURRSTATE == "DamageN4Counter" or CURRSTATE == "DamageHi4Counter")) and damageStopTimer:
		owner.pauseTimer = false
		damageStopTimer = false
	
	if counterPunch:
		modulate = counterColor
	else:
		modulate = Color8(255,255,255,255)
	
	if Input.is_action_just_pressed("Freeze"):
		pass
