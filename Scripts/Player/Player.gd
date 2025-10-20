extends Sprite2D

@onready var stateMachine = $StateMachine
@export var animSys : Node
@onready var debugInfoPlayer = $DebugUI/Player1Side
@onready var debugInfoPlayer3 = $DebugUI/Player1Side2
@onready var debugInfoPlayer2 = $DebugUI/Player2Side
@onready var debugLayer = $DebugUI
@onready var fpsCounter = $DebugUI/FPS

var charName = "Canela"
var frozen = false
var CURRSTATE = "Wait"
var PREVSTATE = "Wait"

var stateFrame = 0
var prevStateFrame = 0 
var frameCounter = 0

var controllerDir = Vector2()
var keyboardDir = Vector2()

var inputX = 0
var inputY = 0

var inputBuffer = 10

var bufferPunchL = false
var bufferPunchR = false
var punchLBuffer = 0
var punchRBuffer = 0
var bufferSuper = false
var superBuffer = 0

var bufferDodgeLW = false
var dodgeBufferLW = 0
var bufferDodgeL = false
var dodgeBufferL = 0
var bufferDodgeR = false
var dodgeBufferR = 0
var bufferDodgeHI = false
var dodgeBufferHI = 0
var bufferUp = false
var upBuffer = 0

var punchTime = 0

var enemyRef

var punchHit = false
var punchBlock = false

var dodgeLeft = false
var dodgeRight = false
var dodgeDown = false

var dodgeSuccess = false
var perfectDodge = false

var perfectTiming = 3

var transparency = 127

var makerHerVisible = false

var gameManager

var maxHealth = 100

var health = 100

var hasCombo = false

var isBlocking = false

var superMeter = 0
var superInit = 20
var superMax = 100

var hitCount = 0

var gotSuper = false

var inBurnout = false
var burnoutTime = 300
var burnoutTimer = 0

var epicCombo = 0



var R = 255
var G = 255
var B = 255

var animSheets = [preload("res://Sprites/Characters/Canela/A00Wait1.png"),
preload("res://Sprites/Characters/Canela/A01AttackLw.png"),
preload("res://Sprites/Characters/Canela/A02AttackHi.png"),
preload("res://Sprites/Characters/Canela/A03AttackLw4.png"),
preload("res://Sprites/Characters/Canela/A04EscapeN.png"),
preload("res://Sprites/Characters/Canela/A05AttackHi4.png"),
preload("res://Sprites/Characters/Canela/A06EscapeS.png"),
preload("res://Sprites/Characters/Canela/A07DamageS.png"),
preload("res://Sprites/Characters/Canela/A08AttackSuperLw.png"),
preload("res://Sprites/Characters/Canela/A09DamageN.png"),
preload("res://Sprites/Characters/Canela/A10Block.png"),
preload("res://Sprites/Characters/Canela/A11AttackLwMiss.png"),
preload("res://Sprites/Characters/Canela/A12AttackHiMiss.png"),]

var ctrl = 1 

const guardMeterLoss = 10
const punchDamage = 2.5
const punchMeterGain = 2
const finishDamage = 5
const finishMeterGain = 2
const counterDamage = 2.5
const counterMeterGain = 20
const superDamage = 40
const perfectDodgeMeterGain = 5

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

func _ready():
	health = maxHealth

func setColor(value1, value2, value3):
	R = value1 
	G = value2
	B = value3

func moveCamera(rate, towards):
	owner.moveCamera(rate, towards)

func moveCameraY(rate, towards):
	owner.moveCameraY(rate, towards)

func _process(delta):
	
	inputX = Gamemanager.checkInputAxis("Left", "Right")
	inputY = Gamemanager.checkInputAxis("Down", "Up")
	
	#print(inputY)
	gameManager = owner
	processInputs()
	
	if superMeter == superMax and inputY <= 0 and bufferSuper and !bufferUp and (ctrl == 1 or owner.hitStop == 0 and punchHit and CURRSTATE != "PunchLeftFinish" and CURRSTATE != "PunchLeftCounter" and CURRSTATE != "PunchRightFinish" and CURRSTATE != "PunchRightCounter" and CURRSTATE != "UpperLeftFinish" and CURRSTATE != "UpperLeftCounter" and CURRSTATE != "UpperRightCounter" and CURRSTATE != "UpperRightFinish"):
			stateMachine.change_state("SuperPunchLw")
	
	if inputY <= 0 and bufferPunchL and !bufferUp and ctrl == 1:
		if owner.enemy.counterPunch and owner.enemy.hitLeft:
			stateMachine.change_state2("PunchLeftCounter")
		else:
			if owner.enemy.hitCount < owner.enemy.maxHitCount or !hasCombo:
				stateMachine.change_state2("PunchLeft")
			else:
				stateMachine.change_state2("PunchLeftFinish")
	if inputY <= 0 and bufferPunchR and !bufferUp and ctrl == 1:
		if owner.enemy.counterPunch and owner.enemy.hitRight:
			stateMachine.change_state2("PunchRightCounter")
		else:
			if owner.enemy.hitCount < owner.enemy.maxHitCount or !hasCombo:
				stateMachine.change_state2("PunchRight")
			else:
				stateMachine.change_state2("PunchRightFinish")
	if (inputY > 0 or bufferUp) and bufferPunchL and ctrl == 1:
		if owner.enemy.counterPunch and owner.enemy.hitUpLeft:
			stateMachine.change_state2("UpperLeftCounter")
		else:
			if owner.enemy.hitCount < owner.enemy.maxHitCount or !hasCombo:
				stateMachine.change_state2("UpperLeft")
			else:
				stateMachine.change_state2("UpperLeftFinish")
	if (inputY > 0 or bufferUp) and bufferPunchR and ctrl == 1:
		if owner.enemy.counterPunch and owner.enemy.hitUpRight:
			stateMachine.change_state2("UpperRightCounter")
		else:
			if owner.enemy.hitCount < owner.enemy.maxHitCount or !hasCombo:
				stateMachine.change_state2("UpperRight")
			else:
				stateMachine.change_state2("UpperRightFinish")
	
	if bufferDodgeL and ctrl == 1:
		stateMachine.change_state2("DodgeLeft")
	if bufferDodgeR and ctrl == 1:
		stateMachine.change_state2("DodgeRight")
	if bufferDodgeLW and ctrl == 1:
		stateMachine.change_state2("DodgeDown")
	if bufferDodgeHI and ctrl == 1 and !inBurnout:
		stateMachine.change_state("Block")

func _physics_process(delta):
	if !frozen:
		sheVisibleNow()
	
	
	if stateFrame > 300 and ctrl == 0:
		stateFrame = 0
	
	if inBurnout:
		if R == 255 and G == 255 and B == 255:
			setColor(102,102,102)
	else:
		if R == 102 and G == 102 and B == 102:
			setColor(255,255,255)
	
	if health < 0:
		health = 0
	
	if owner.enemy.health <= finishDamage and CURRSTATE == "PunchLeft" and stateFrame < 5:
		stateMachine.change_state2("PunchLeftFinish")
	
	if owner.enemy.health <= finishDamage and CURRSTATE == "PunchRight" and stateFrame < 5:
		stateMachine.change_state2("PunchRightFinish")
	
	if owner.enemy.health <= finishDamage and CURRSTATE == "UpperLeft" and stateFrame < 5:
		stateMachine.change_state2("UpperLeftFinish")
	
	if owner.enemy.health <= finishDamage and CURRSTATE == "UpperRight" and stateFrame < 5:
		stateMachine.change_state2("UpperRightFinish")
	
	if superMeter > superMax:
		superMeter = superMax
	
	if superMeter < 0:
		superMeter = 0
	
	if superMeter < superMax:
		gotSuper = false
	
	if Input.is_key_pressed(KEY_0):
		superMeter = superMax
		gotSuper = true
		burnoutEnd()
	
	if Input.is_key_pressed(KEY_CTRL):
		superMeter = 0
	
	if owner.enemy.maxHitCount > 5:
		epicCombo = (hitCount) 
		if epicCombo > 14:
			epicCombo = 14
	else:
		epicCombo = 0 
	
	modulate = Color8(R,G,B,transparency)
	
	debugUI()
	#fixThisShit()
	clearBuffer()


func sheVisibleNow():
	if makerHerVisible:
		if transparency < 255:
			transparency += 200
		if transparency > 255:
			transparency = 255
	else:
		if transparency != 127:
			transparency -= 5
		
		if transparency < 127:
			transparency = 127

func punchBlockFunc(effectY = 0, audioBus = "SFX", blockState = "BlockLw", hitlag = 3, shake = 10):
	punchBlock = true
	superMeter -= guardMeterLoss
	enemyRef.hitCount = 0
	owner.hitLag(hitlag, shake)
	if superMeter <= 0 and !inBurnout:
		print("WHAT")
		owner.playerBurnout()
	Gamemanager.createEffects("BLOCK", 1.0, 1.0, 0, effectY)
	AudioManager.Play("Block", audioBus, 1.0, 1.0)
	enemyRef.stateMachine.change_state2(blockState+"Damage")


func punchHitFunc(damage = 1, meter = 1, flip = false, 
audioBus = "SFX", sfx = "Damage3", volume = 1.0, pitch = 1.0, 
hitState = "DamageN", upper = false, hitlagMul = 1.0, shakeMul = 1.0, 
effect = "HIT", effectX = 0.0, effectY = 0.0, scaleX = 1.0, scaleY = 1.0):
	enemyRef = owner.enemy
	punchHit = true
	enemyRef.healing = false
	owner.enemyUpdateHealth(damage)
	if enemyRef.isAttacking:
		enemyRef.attackMiss = true
	if !inBurnout:
		superMeter += meter
	enemyRef.hitCount += 1
	if effect == "HITCOUNTER":
		AudioManager.Play("CounterPunch", "SFX", 1.0, 1.0)
	if !upper:
		if superMeter >= superMax and !gotSuper:
			owner.hitLag((enemyRef.hitlagPunch * hitlagMul),(enemyRef.shakePunch * shakeMul))
			gotSuper = true
		else:
			owner.hitLag((enemyRef.hitlagPunch * hitlagMul),(enemyRef.shakePunch * shakeMul))
	else:
		if superMeter >= superMax and !gotSuper:
			owner.hitLag((enemyRef.hitlagUpper * hitlagMul),(enemyRef.shakeUpper * shakeMul))
			gotSuper = true
		else:
			owner.hitLag(enemyRef.hitlagUpper * hitlagMul,enemyRef.shakeUpper * shakeMul)
	Gamemanager.createEffects(effect, scaleX, scaleY, effectX, effectY)
	AudioManager.Play(sfx, audioBus, volume, pitch)
	enemyRef.stateMachine.change_state2(hitState)

func punchOpponent(value = 0, damage = 1, meter = 1, flip = false, 
audioBus = "SFX", sfx = "Damage3", volume = 1.0, pitch = 1.0, 
hitState = "DamageN", upper = false, hitlagMul = 1.0, shakeMul = 1.0, 
effect = "HIT", effectX = 0.0, effectY = 0.0, scaleX = 1.0, scaleY = 1.0):
	enemyRef = owner.enemy
	if value == 0: #Left
		if enemyRef.blockLeft or enemyRef.guardAll:
			punchBlockFunc(60, "Left", "BlockLw")
			return
		if enemyRef.hitLeft:
			if hasCombo or owner.enemy.hitCount < owner.enemy.maxHitCount:
				enemyRef.playerPunch = value
				punchHitFunc(damage, meter, flip, audioBus, sfx, volume, pitch, 
				hitState, upper, hitlagMul, shakeMul, effect, effectX, effectY, scaleX, scaleY)
			else:
				punchBlockFunc(60, "Left", "BlockLw")
	if value == 1: #Right
		if enemyRef.blockRight  or enemyRef.guardAll:
			punchBlockFunc(60, "Right", "BlockLw")
			return
		if enemyRef.hitRight:
			if hasCombo or owner.enemy.hitCount < owner.enemy.maxHitCount:
				enemyRef.playerPunch = value
				punchHitFunc(damage, meter, flip, audioBus, sfx, volume, pitch, 
				hitState, upper, hitlagMul, shakeMul, effect, effectX, effectY, scaleX, scaleY)
			else:
				punchBlockFunc(60, "Right", "BlockLw")
	if value == 2: #Left Up
		if enemyRef.blockUpLeft  or enemyRef.guardAll:
			punchBlockFunc(-150, "Left", "BlockHi")
			return
		if enemyRef.hitUpLeft:
			if hasCombo or owner.enemy.hitCount < owner.enemy.maxHitCount:
				enemyRef.playerPunch = value
				punchHitFunc(damage, meter, flip, audioBus, sfx, volume, pitch, 
				hitState, upper, hitlagMul, shakeMul, effect, effectX, effectY, scaleX, scaleY)
			else:
				punchBlockFunc(-150, "Left", "BlockHi")
	if value == 3: #Right Up
		if enemyRef.blockUpRight  or enemyRef.guardAll:
			punchBlockFunc(-150, "Right", "BlockHi")
			return
		if enemyRef.hitUpRight:
			if hasCombo or owner.enemy.hitCount < owner.enemy.maxHitCount:
				enemyRef.playerPunch = value
				punchHitFunc(damage, meter, flip, audioBus, sfx, volume, pitch, 
				hitState, upper, hitlagMul, shakeMul, effect, effectX, effectY, scaleX, scaleY)
			else:
				punchBlockFunc(-150, "Right", "BlockHi")
	if value == 4: #Super Lw
		if enemyRef.blockUpRight  or enemyRef.guardAll:
			punchBlockFunc(60, "SFX", "BlockLw", 20, 40)
			return
		if enemyRef.hitRight or enemyRef.hitLeft:
			enemyRef.playerPunch = value
			punchHitFunc(damage, meter, flip, audioBus, sfx, volume, pitch, 
			hitState, upper, hitlagMul, shakeMul, effect, effectX, effectY, scaleX, scaleY)
	if value == 5: #Super Hi
		if enemyRef.blockUpRight  or enemyRef.guardAll:
			punchBlockFunc(-150, "SFX", "BlockHi")
			return
		if enemyRef.hitUpRight or enemyRef.hitUpLeft:
			enemyRef.playerPunch = value
			punchHitFunc(damage, meter, flip, audioBus, sfx, volume, pitch, 
			hitState, upper, hitlagMul, shakeMul, effect, effectX, effectY, scaleX, scaleY)


func debugUI():
	fpsCounter.text = "FPS: " + str(Engine.get_frames_per_second())
	debugInfoPlayer.text = "Frame: " + str(frameCounter) + "\n" + "State: " + CURRSTATE + "\n" + "StateFrame: " + str(stateFrame) + "\n" + "ctrl: " + str(ctrl) + "\n" + "currentFrame: " + str(frame) + "\n" + "animWait: " + str(animSys.animWait) + "\n" + "animFrame: " + str(animSys.animFrame) + "\n" + "PrevState: " + PREVSTATE + "\n" + "HitStop: " + str(owner.hitStop) + "\n" + "PerfectDodge: " + str(perfectDodge) + "\n" + "superMeter: " + str(superMeter) + "\n" + "BurnoutTime: " + str(burnoutTimer)
	debugInfoPlayer2.text = "Frame: " + str(frameCounter) + "\n" + "State: " + owner.enemy.CURRSTATE + "\n" + "StateFrame: " + str(owner.enemy.stateFrame) + "\n" + "animFrame: " + str(owner.enemy.frame) + "\n" + "PrevState: " + str(owner.enemy.PREVSTATE) + "\n" + "PrevFrame: " + str(owner.enemy.prevStateFrame) + "\n" + "Stunned: " + str(owner.enemy.stunned) + "\n" + "HitCount: " + str(owner.enemy.hitCount) + "\n" + "MaxHitCount: " + str(owner.enemy.maxHitCount) + "\n" + "Health: " + str(owner.enemy.health) + "\n" + "aiActive: " + str(owner.enemy.aiActive) + "\n" + "attackPhase: " + str(owner.enemy.brain.attackPhase) + "\n" + "waitTimer: " + str(owner.enemy.brain.waitTimer) + "\n" + "nextMove: " + str(owner.enemy.brain.nextMove) + "\n" + "epicCombo: " + str(epicCombo)  
	debugInfoPlayer3.text = "bufferL: " + str(bufferPunchL) + "\n" + "bufferR: " + str(bufferPunchR) + "\n" + "bufferUp: " + str(bufferUp) + "\n" + "Zoom: " + str(owner.cameraZoom) + "\n" + "DodgeLeft: " + str(dodgeLeft) + "\n" + "DodgeRight: " + str(dodgeRight) + "\n" + "DodgeDown: " + str(dodgeDown) + "\n" + "Health: " + str(health) + "\n" + "hasCombo: " + str(hasCombo) + "\n" + "isBlocking: " + str(isBlocking) + "\n" + "superBarValue: " + str(owner.playerSuper.value) + "\n" + "inBurnout: " + str(inBurnout) + "\n" + "GameState: " + owner.CURRSTATE

func burnout():
	if inBurnout:
		burnoutTimer -= 1
		if burnoutTimer == 0:
			burnoutEnd()

func burnoutEnd():
	if inBurnout:
		owner.playerSuper.max_value = superMax
		owner.playerSuper.min_value = 0
		owner.playerSuper.get("theme_override_styles/fill").bg_color = Color(0.081, 0.622, 1)
		AudioManager.Play("BurnoutEnd", "SFX", 1.0, 1.0)
		inBurnout = false

func fixThisShit():
	if CURRSTATE == "PunchLeft" and owner.enemy.counterPunch and owner.enemy.hitLeft and stateFrame < 6:
		stateMachine.change_state4("PunchLeftCounter")
	if CURRSTATE == "PunchRight" and owner.enemy.counterPunch and owner.enemy.hitRight and stateFrame < 6:
		stateMachine.change_state4("PunchRightCounter")
	if CURRSTATE == "UpperLeft" and owner.enemy.counterPunch and owner.enemy.hitUpLeft and stateFrame < 6:
		stateMachine.change_state4("UpperLeftCounter")
	if CURRSTATE == "UpperRight" and owner.enemy.counterPunch and owner.enemy.hitUpRight and stateFrame < 6:
		stateMachine.change_state4("UpperRightCounter")
	
	if CURRSTATE == "PunchLeftCounter" and !owner.enemy.counterPunch and !punchHit:
		stateMachine.change_state4("PunchLeft")
	if CURRSTATE == "PunchRightCounter" and !owner.enemy.counterPunch and !punchHit:
		stateMachine.change_state4("PunchRight")
	if CURRSTATE == "UpperLeftCounter" and !owner.enemy.counterPunch and !punchHit:
		stateMachine.change_state4("UpperLeft")
	if CURRSTATE == "UpperRightCounter" and !owner.enemy.counterPunch and !punchHit:
		stateMachine.change_state4("UpperRight")

func processInputs():
	if owner.CURRSTATE == "Intro" or owner.CURRSTATE == "KnockDown":
		return
	if Gamemanager.checkInputJustPressed("LeftPunch") and !bufferPunchL:
		punchLBuffer = frameCounter
		bufferDodgeHI = false
		bufferPunchL = true
	
	if Gamemanager.checkInputJustPressed("RightPunch") and !bufferPunchR:
		punchRBuffer = frameCounter
		bufferDodgeHI = false
		bufferPunchR = true
	
	if Gamemanager.checkInputJustPressed("Down") and !bufferDodgeLW:
		dodgeBufferLW = frameCounter
		bufferDodgeLW = true
	
	if Gamemanager.checkInputJustPressed("Left") and !bufferDodgeL:
		dodgeBufferL = frameCounter
		bufferDodgeL = true
	
	if Gamemanager.checkInputJustPressed("Right") and !bufferDodgeR:
		dodgeBufferR = frameCounter
		bufferDodgeR = true
	
	if Gamemanager.checkInputJustPressed("Up") and !bufferDodgeHI:
		dodgeBufferHI = frameCounter
		bufferDodgeHI = true
	
	if Gamemanager.checkInputJustPressed("SuperPunch") and !bufferSuper:
		superBuffer = frameCounter
		bufferSuper = true

func clearBuffer():
	if bufferSuper and frameCounter == superBuffer + 15:
		bufferSuper = false
	
	if bufferPunchL and frameCounter == punchLBuffer + 15:
		bufferPunchL = false
	
	if bufferPunchR and frameCounter == punchRBuffer + 15: 
		bufferPunchR = false
	
	if bufferDodgeL and frameCounter == dodgeBufferL + inputBuffer:
		bufferDodgeL = false
	
	if bufferDodgeLW and frameCounter == dodgeBufferLW + inputBuffer:
		bufferDodgeLW = false
	
	if bufferDodgeR and frameCounter == dodgeBufferR + inputBuffer:
		bufferDodgeR = false
	
	if bufferDodgeHI and frameCounter == dodgeBufferHI + inputBuffer:
		bufferDodgeHI = false
	
	if bufferUp and frameCounter == upBuffer + 15:
		bufferUp = false
	
	if bufferPunchL and bufferPunchR:
		if punchLBuffer > punchRBuffer:
			bufferPunchR = false
		if punchLBuffer < punchRBuffer:
			bufferPunchL = false
		else:
			bufferPunchR = false
