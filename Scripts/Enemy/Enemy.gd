extends Sprite2D

var frozen = false
var CURRSTATE = "Wait"
var PREVSTATE = "Wait"
@export var background : PackedScene
@onready var stateMachine = $StateMachine
@export var animSys : Node
@export var hitSys : Node
@export var enemyPortrait : CompressedTexture2D
@export var charName = "Cardemomo"
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
@export var baseColor = Color8(255,255,255,255)
var counterColor = Color8(255,164,167,255)

@export var hitlagPunch = 3
@export var hitlagUpper = 3
@export var shakePunch = 10
@export var shakeUpper = 10

var dizzy = 0
@export var dizzyTime = 97

@export var finalHitlagMul = 4
@export var finalShakeMul = 4

var enemyRef

@export var normalCombo = 2
@export var dodgeCombo = 4
@export var perfectCombo = 6

var punchHit = false
var attackMiss = false
var isAttacking = false
@export var defaultPosY = 100

var healing = false

var hitCount = 0
@export var maxHitCount = 5
var blockCount = 0
@export var maxBlockCount = 3

@export var maxHealth = 100
var health = 100

var aiActive = false

var damaged = false
var damageStopTimer = false

var rng = RandomNumberGenerator.new()

@export var superInit = 40

var R = 255
var G = 255
var B = 255

var playerPunch = 0 
@export var flipDamageLw = true
@export var flipDamageHi = true
@export var flipDamageCounterLw = true
@export var flipDamageCounterHi = false

var dizzyAnim = "DizzyLw"
@export var flipBlockLw = false
@export var flipBlockHi = true

@onready var brain = $Brain



func setColor(value1, value2, value3):
	R = value1 
	G = value2
	B = value3

func cFrame(value):
	if stateFrame == value:
		return true
	else:
		return false

func moveCamera(rate, towards):
	owner.moveCamera(rate, towards)

func moveCameraY(rate, towards):
	owner.moveCameraY(rate, towards)

func zoomCamera(rate, towards):
	owner.zoomCamera(rate,towards)

func enemyHeal(value, rate):
	healing = true
	owner.enemyHealing = health + value
	if owner.enemyHealing > maxHealth:
		owner.enemyHealing = maxHealth
	owner.enemyHealingRate = rate

func punchHitFunc(hitbox : Hit):
	enemyRef = owner.player
	if enemyRef.stateFrame > 15 and enemyRef.stateFrame <= 18:
		if (hitbox.dodgeDirection == hitbox.HITDIRECTIONS.LEFT and enemyRef.CURRSTATE == "DodgeLeft") or (hitbox.dodgeDirection == hitbox.HITDIRECTIONS.RIGHT and enemyRef.CURRSTATE == "DodgeRight") or (hitbox.dodgeDirection == hitbox.HITDIRECTIONS.DOWN and enemyRef.CURRSTATE == "DodgeDown") or (hitbox.dodgeDirection == hitbox.HITDIRECTIONS.ALL and (enemyRef.CURRSTATE == "DodgeLeft" or enemyRef.CURRSTATE == "DodgeRight" or enemyRef.CURRSTATE == "DodgeDown")) or (hitbox.dodgeDirection == hitbox.HITDIRECTIONS.HORIZONTAL and (enemyRef.CURRSTATE == "DodgeLeft" or enemyRef.CURRSTATE == "DodgeRight")):
			punchDodgeFunc(hitbox)
			AudioManager.Play("Dizzy", hitbox.AUDIOBUS.keys()[hitbox.audioBus], 8.0, hitbox.pitch)
			return
	owner.playerUpdateHealth(hitbox.damage)
	punchHit = true
	attackMiss = false
	enemyRef.flip_h = hitbox.flip
	enemyRef.moveCamera(0.2, 0.0)
	enemyRef.moveCameraY(0.2, 0.0)
	if enemyRef.inBurnout:
		owner.hitLag(hitbox.hitlag * 2, hitbox.screenShake * 2)
	else:
		owner.hitLag(hitbox.hitlag, hitbox.screenShake)
	if enemyRef.superMeter == 0 and !enemyRef.inBurnout:
		owner.playerBurnout()
	enemyRef.superMeter -= hitbox.meter
	AudioManager.Play(hitbox.sfx, hitbox.AUDIOBUS.keys()[hitbox.audioBus], hitbox.volume, hitbox.pitch)
	Gamemanager.createEffects(hitbox.effect, hitbox.scaleX, hitbox.scaleY, hitbox.posX, hitbox.posY, hitbox.zIndex)
	enemyRef.stateMachine.change_state2(hitbox.HITANIMATIONS.keys()[hitbox.damageAnim])
	enemyRef.position.x = hitbox.playerX

func punchDodgeFunc(hitbox : Hit):
	enemyRef = owner.player
	enemyRef.dodgeSuccess = true
	attackMiss = true
	enemyRef.zoomCamera(0.2, 1.2)
	#enemyRef.moveCamera(0.2, 0.0)
	#enemyRef.moveCameraY(0.2, 0.0)
	enemyRef.canDodge = false
	enemyRef.canBlock = false
	if enemyRef.CURRSTATE == "DodgeLeft":
		AudioManager.Play("Dodge", "Left", 1.0, 1.0)
	elif enemyRef.CURRSTATE == "DodgeRight":
		AudioManager.Play("Dodge", "Right", 1.0, 1.0)
	else:
		AudioManager.Play("Dodge", "SFX", 1.0, 1.0)
	enemyRef.hasCombo = true
	maxHitCount = hitbox.dodgeCombo
	if enemyRef.stateFrame <= enemyRef.perfectTiming and !enemyRef.inBurnout:
		enemyRef.superMeter += enemyRef.perfectDodgeMeterGain
		if enemyRef.superMeter >= enemyRef.superMax:
			enemyRef.gotSuper = true
		maxHitCount = hitbox.perfectCombo
		
		AudioManager.Play("Perfect", "SFX", 1.0, 1.0)
		enemyRef.perfectDodge = true

func punchBlockFunc(hitbox : Hit):
	enemyRef = owner.player
	owner.hitLag(5, 15)
	hitLeft = true
	hitRight = true
	hitUpLeft = true
	hitUpRight = true
	if stun:
		maxHitCount = hitbox.blockCombo
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
	
	if hitbox.guardMeter == -1:
		enemyRef.superMeter -= hitbox.meter / 2
	else:
		enemyRef.superMeter -= hitbox.guardMeter
	AudioManager.Play("Block", hitbox.AUDIOBUS.keys()[hitbox.audioBus], 1.0, 1.0)
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

func punchOpponent(hitboxName : String):
	var hitbox
	for child in hitSys.get_children():
		if child is Hit and child.name == hitboxName:
			hitbox = child
	
	if !hitbox is Hit:
		return

	enemyRef = owner.player
	if attackMiss or punchHit:
		return
	
	if hitbox.dodgeDirection == hitbox.HITDIRECTIONS.LEFT: #Dodge Left
		if enemyRef.isBlocking and hitbox.blockable and !enemyRef.inBurnout and hitbox.hitNeutral:
			punchBlockFunc(hitbox)
			return
		if !enemyRef.dodgeLeft:
			if hitMasks(hitbox.hitLeft, hitbox.hitNeutral, hitbox.hitRight, hitbox.hitDown):
				punchHitFunc(hitbox)
			else:
				return
		else:
			if hitMasks(hitbox.hitLeft, hitbox.hitNeutral, hitbox.hitRight, hitbox.hitDown):
				punchDodgeFunc(hitbox)
	elif hitbox.dodgeDirection == hitbox.HITDIRECTIONS.RIGHT: #Dodge Right
		if enemyRef.isBlocking and hitbox.blockable and !enemyRef.inBurnout and hitbox.hitNeutral:
			punchBlockFunc(hitbox)
			return
		if !enemyRef.dodgeRight:
			if hitMasks(hitbox.hitLeft, hitbox.hitNeutral, hitbox.hitRight, hitbox.hitDown):
				punchHitFunc(hitbox)
			else:
				return
		else:
			if hitMasks(hitbox.hitLeft, hitbox.hitNeutral, hitbox.hitRight, hitbox.hitDown):
				punchDodgeFunc(hitbox)
	elif hitbox.dodgeDirection == hitbox.HITDIRECTIONS.DOWN: #Dodge Down
		if enemyRef.isBlocking and hitbox.blockable and !enemyRef.inBurnout and hitbox.hitNeutral:
			punchBlockFunc(hitbox)
			return
		if !enemyRef.dodgeDown:
			if hitMasks(hitbox.hitLeft, hitbox.hitNeutral, hitbox.hitRight, hitbox.hitDown):
				punchHitFunc(hitbox)
			else:
				return
		else:
			if hitMasks(hitbox.hitLeft, hitbox.hitNeutral, hitbox.hitRight, hitbox.hitDown):
				punchDodgeFunc(hitbox)
	elif hitbox.dodgeDirection == hitbox.HITDIRECTIONS.ALL: #Dodge All
		if enemyRef.isBlocking and hitbox.blockable and !enemyRef.inBurnout and hitbox.hitNeutral:
			punchBlockFunc(hitbox)
			return
		if !enemyRef.dodgeLeft and !enemyRef.dodgeRight and !enemyRef.dodgeDown:
			if hitMasks(hitbox.hitLeft, hitbox.hitNeutral, hitbox.hitRight, hitbox.hitDown):
				punchHitFunc(hitbox)
			else:
				return
		else:
			if hitMasks(hitbox.hitLeft, hitbox.hitNeutral, hitbox.hitRight, hitbox.hitDown):
				punchDodgeFunc(hitbox)
	elif hitbox.dodgeDirection == hitbox.HITDIRECTIONS.HORIZONTAL: #Dodge Left or Right
		if enemyRef.isBlocking and hitbox.blockable and !enemyRef.inBurnout and hitbox.hitNeutral:
			punchBlockFunc(hitbox)
			return
		if !enemyRef.dodgeLeft and !enemyRef.dodgeRight:
			if hitMasks(hitbox.hitLeft, hitbox.hitNeutral, hitbox.hitRight, hitbox.hitDown):
				punchHitFunc(hitbox)
			else:
				return
		else:
			if hitMasks(hitbox.hitLeft, hitbox.hitNeutral, hitbox.hitRight, hitbox.hitDown):
				punchDodgeFunc(hitbox)

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


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
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
			owner.zoomCamera(0.2, 1.0)
			stateMachine.change_state2("Attack1")
		if Input.is_key_pressed(KEY_4):
			owner.zoomCamera(0.2, 1.0)
			stateMachine.change_state2("Attack2")
		if Input.is_key_pressed(KEY_5):
			owner.zoomCamera(0.2, 1.0)
			stateMachine.change_state2("Attack3")
		if Input.is_key_pressed(KEY_6):
			owner.zoomCamera(0.2, 1.0)
			stateMachine.change_state2("Attack4")
		if Input.is_key_pressed(KEY_7):
			owner.zoomCamera(0.2, 1.0)
			stateMachine.change_state2("Attack5")
		if Input.is_key_pressed(KEY_KP_0):
			owner.zoomCamera(0.2, 1.0)
			stateMachine.change_state2("Wait")
		if Input.is_key_pressed(KEY_KP_1):
			owner.zoomCamera(0.2, 1.0)
			blockLeft = true
			blockRight = true
			blockUpLeft = false
			blockUpRight = false
			guardAll = false
			flip_h = false
			animSys.animPlay("BlockLw")
			stateMachine.change_state2("Block")
		if Input.is_key_pressed(KEY_KP_2):
			owner.zoomCamera(0.2, 1.0)
			blockLeft = false
			blockRight = false
			blockUpLeft = true
			blockUpRight = true
			guardAll = false
			flip_h = false
			animSys.animPlay("BlockHi")
			stateMachine.change_state2("Block")
		

func _physics_process(_delta):
	if health < 0:
		health = 0
	
	if (owner.player.CURRSTATE == "PunchLeft" or owner.player.CURRSTATE == "PunchRight" or owner.player.CURRSTATE == "UpperLeft" or owner.player.CURRSTATE == "UpperRight") and counterPunch:
		counterPunch = false
	
	if hitCount == maxHitCount and !owner.player.hasCombo:
		guardAll = true
	
	if damaged and !damageStopTimer and (CURRSTATE != "DizzyHi" and CURRSTATE != "DizzyLw" and CURRSTATE != "DizzyEnd"):
		owner.pauseTimer = true
		damageStopTimer = true
	
	if (!damaged or (CURRSTATE == "Dizzy" or CURRSTATE == "Damage" or CURRSTATE == "DizzyEnd")) and damageStopTimer:
		owner.pauseTimer = false
		damageStopTimer = false
	
	if counterPunch:
		modulate = counterColor
	else:
		modulate = baseColor
	
	if Input.is_action_just_pressed("Freeze"):
		pass
