extends Sprite2D
@onready var stateMachine = $StateMachine
@onready var debugInfoPlayer = $DebugUI/Player1Side
@onready var debugInfoPlayer3 = $DebugUI/Player1Side2
@onready var debugInfoPlayer2 = $DebugUI/Player2Side
var frozen = false
var CURRSTATE = "Wait"
var PREVSTATE = "Wait"

var stateFrame = 0
var prevStateFrame = 0 
var frameCounter = 0

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

var maxHealth = 40

var health = 40

var hasCombo = false

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
preload("res://Sprites/Characters/Canela/A09DamageN.png"),]

var ctrl = 1 

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
	

func _process(delta):
	inputX = Input.get_axis("Left", "Right")
	inputY = Input.get_axis("Down", "Up")
	gameManager = owner
	processInputs()
	
	if inputY <= 0 and bufferSuper and !bufferUp and (ctrl == 1 or owner.hitStop == 0 and punchHit and CURRSTATE != "PunchLeftFinish" and CURRSTATE != "PunchLeftCounter" and CURRSTATE != "PunchRightFinish" and CURRSTATE != "PunchRightCounter" and CURRSTATE != "UpperLeftFinish" and CURRSTATE != "UpperLeftCounter" and CURRSTATE != "UpperRightCounter" and CURRSTATE != "UpperRightFinish"):
			stateMachine.change_state("SuperPunchLw")
	
	if ctrl == 1:
		if inputY <= 0 and bufferPunchL and !bufferUp:
			if owner.enemy.counterPunch and owner.enemy.hitLeft:
				stateMachine.change_state2("PunchLeftCounter")
			else:
				if owner.enemy.hitCount < owner.enemy.maxHitCount or !hasCombo:
					stateMachine.change_state2("PunchLeft")
				else:
					stateMachine.change_state2("PunchLeftFinish")
		if inputY <= 0 and bufferPunchR and !bufferUp:
			if owner.enemy.counterPunch and owner.enemy.hitRight:
				stateMachine.change_state2("PunchRightCounter")
			else:
				if owner.enemy.hitCount < owner.enemy.maxHitCount or !hasCombo:
					stateMachine.change_state2("PunchRight")
				else:
					stateMachine.change_state2("PunchRightFinish")
		if (inputY > 0 or bufferUp) and bufferPunchL:
			if owner.enemy.counterPunch and owner.enemy.hitUpLeft:
				stateMachine.change_state2("UpperLeftCounter")
			else:
				if owner.enemy.hitCount < owner.enemy.maxHitCount or !hasCombo:
					stateMachine.change_state2("UpperLeft")
				else:
					stateMachine.change_state2("UpperLeftFinish")
		if (inputY > 0 or bufferUp) and bufferPunchR:
			if owner.enemy.counterPunch and owner.enemy.hitUpRight:
				stateMachine.change_state2("UpperRightCounter")
			else:
				if owner.enemy.hitCount < owner.enemy.maxHitCount or !hasCombo:
					stateMachine.change_state2("UpperRight")
				else:
					stateMachine.change_state2("UpperRightFinish")
		
		if bufferDodgeL:
			stateMachine.change_state2("DodgeLeft")
		if bufferDodgeR:
			stateMachine.change_state2("DodgeRight")
		if bufferDodgeLW:
			stateMachine.change_state2("DodgeDown")
		if bufferDodgeHI:
			stateMachine.change_state("Guard")

func _physics_process(delta):
	if Input.is_key_pressed(KEY_0):
		health = maxHealth
	
	if !frozen:
		sheVisibleNow()
	
	if health < 0:
		health = 0
	
	modulate = Color8(R,G,B,transparency)
	
	debugUI()
	fixThisShit()
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

func punchBlockFunc(effectY, audioBus, blockState):
	punchBlock = true
	Gamemanager.createEffects("BLOCK", 1.0, 1.0, 0, effectY)
	AudioManager.Play("Block", audioBus, 1.0, 1.0)
	enemyRef.stateMachine.change_state2(blockState)


func punchHitFunc(damage, flip, counter, audioBus, normalState, counterState, hitlagMul, shakeMul, effectX, effectY, hardPunch, hardEffectX, hardEffectY, sfx, volume, pitch):
	enemyRef = owner.enemy
	punchHit = true
	enemyRef.health -= damage
	enemyRef.hitCount += 1
	enemyRef.flip_h = flip
	
	if counter:
		if enemyRef.counterPunch:
			owner.hitLag(enemyRef.hitlagPunch * 2,enemyRef.shakePunch * 2)
			Gamemanager.createEffects("HITCOUNTER", 3.0, 3.0, hardEffectX, hardEffectY)
			AudioManager.Play("CounterPunch", "SFX", 1.0, 1.0)
			AudioManager.Play("Damage4", audioBus, 1.0, 1.35)
			enemyRef.spriteOffsets(7,1,13)
			enemyRef.stateMachine.change_state2(counterState)
			return
	if !hardPunch:
		Gamemanager.createEffects("HIT", 2.0, 2.0, effectX, effectY)
		AudioManager.Play("Damage3", audioBus, 1.0, 1.0 + (enemyRef.hitCount * 0.2))
		owner.hitLag(enemyRef.hitlagPunch * hitlagMul,enemyRef.shakePunch * shakeMul)
	else:
		Gamemanager.createEffects("HITFINISHER", 2.0, 2.0, hardEffectX, hardEffectY)
		AudioManager.Play(sfx, audioBus, volume, pitch)
		owner.hitLag((enemyRef.hitlagPunch * enemyRef.finalHitlagMul) * hitlagMul,(enemyRef.shakePunch * enemyRef.finalShakeMul) * shakeMul)
	
	enemyRef.stateMachine.change_state2(normalState)

func punchOpponent(value):
	enemyRef = owner.enemy
	if value == 0: #Left Punch
		if enemyRef.blockLeft:
			punchBlockFunc(60, "Left", "BlockLw")
			return
		if enemyRef.hitLeft:
			if hasCombo:
				punchHitFunc(1, true, true, "Left", "DamageN", "DamageN4Counter", 1.0, 1.0, 0, 60, false, 200, 60, "Damage4", 1.0, 1.35)
			elif owner.enemy.hitCount < owner.enemy.maxHitCount:
				punchHitFunc(1, true, true, "Left", "DamageN", "DamageN4Counter", 1.0, 1.0, 0, 60, false, 200, 60, "Damage4", 1.0, 1.35)
			else:
				punchBlockFunc(60, "Left", "BlockLw")
	elif value == 1: #Right Punch
		if enemyRef.blockRight:
			punchBlockFunc(60, "Right", "BlockLw")
			return
		if enemyRef.hitRight:
			if hasCombo:
				punchHitFunc(1, false, true, "Right", "DamageN", "DamageN4Counter", 1.0, 1.0, 0, 60, false, -200, 60, "Damage4", 1.0, 1.35)
			elif owner.enemy.hitCount < owner.enemy.maxHitCount:
				punchHitFunc(1, false, true, "Right", "DamageN", "DamageN4Counter", 1.0, 1.0, 0, 60, false, -200, 60, "Damage4", 1.0, 1.35)
			else:
				punchBlockFunc(60, "Right", "BlockLw")
	elif value == 2: #Left Upper
		if enemyRef.blockUpLeft:
			punchBlockFunc(-150, "Left", "BlockHi")
			return
		if enemyRef.hitUpLeft:
			if hasCombo:
				punchHitFunc(1, true, true, "Left", "DamageHi", "DamageHi4", 1.0, 1.0, 0, -180, false, 150, -240, "Damage4", 1.0, 1.35)
			elif owner.enemy.hitCount < owner.enemy.maxHitCount:
				punchHitFunc(1, true, true, "Left", "DamageHi", "DamageHi4", 1.0, 1.0, 0, -180, false, 150, -240, "Damage4", 1.0, 1.35)
			else:
				punchBlockFunc(-150, "Left", "BlockHi")
	elif value == 3: #Right Upper
		if enemyRef.blockUpRight:
			punchBlockFunc(-150, "Right", "BlockHi")
			return
		if enemyRef.hitUpRight:
			if hasCombo:
				punchHitFunc(1, false, true, "Right", "DamageHi", "DamageHi4", 1.0, 1.0, 0, -180, false, -150, -240, "Damage4", 1.0, 1.35)
			elif owner.enemy.hitCount < owner.enemy.maxHitCount:
				punchHitFunc(1, false, true, "Right", "DamageHi", "DamageHi4", 1.0, 1.0, 0, -180, false, -150, -240, "Damage4", 1.0, 1.35)
			else:
				punchBlockFunc(-150, "Right", "BlockHi")
	elif value == 4: #Left Punch Finish
		if enemyRef.hitLeft:
			punchHitFunc(1, true, false, "Left", "DamageN4", "Damage4Counter", 1.0, 1.0, 0, 60, true, 200, 60, "Damage4", 1.0, 1.35)
	elif value == 5: #Right Punch Finish
		if enemyRef.hitRight:
			punchHitFunc(1, false, false, "Right", "DamageN4", "Damage4Counter", 1.0, 1.0, 0, 60, true, -200, 60, "Damage4", 1.0, 1.35)
	elif value == 6: #Left Upper Finish
		if enemyRef.hitUpLeft:
			punchHitFunc(1, true, false, "Left", "DamageHi4", "Damage4Counter", 1.0, 1.0, -150, -240, true, 150, -240, "Damage4", 1.0, 1.35)
	elif value == 7: #Right Upper Finish
		if enemyRef.hitUpRight:
			punchHitFunc(1, false, false, "Right", "DamageHi4", "Damage4Counter", 1.0, 1.0, -150, -240, true, -150, -240, "Damage4", 1.0, 1.35)
	elif value == 8: #Super Lw
		if enemyRef.hitLeft or enemyRef.hitRight:
			punchHitFunc(1, false, false, "Right", "DamageN4", "Damage4Counter", 2.0, 1.0, 0, 60, true, -200, 60, "SuperHit", 1.0, 1.0)
	elif value == 9: #Super Hi
		if enemyRef.hitUpRight or enemyRef.hitUpLeft:
			punchHitFunc(1, false, false, "Right", "DamageHi4", "Damage4Counter", 2.0, 2.0, -150, -240, true, -150, -240, "SuperHit", 1.0, 1.0)

func debugUI():
	debugInfoPlayer.text = "Frame: " + str(frameCounter) + "\n" + "State: " + CURRSTATE + "\n" + "StateFrame: " + str(stateFrame) + "\n" + "ctrl: " + str(ctrl) + "\n" + "frameAdvance: " + str(owner.frameAdvance) + "\n" + "animFrame: " + str(frame) + "\n" + "PrevState: " + PREVSTATE + "\n" + "PrevFrame: " + str(prevStateFrame) + "\n" + "HitStop: " + str(owner.hitStop) + "\n" + "PerfectDodge: " + str(perfectDodge)
	debugInfoPlayer2.text = "Frame: " + str(frameCounter) + "\n" + "State: " + owner.enemy.CURRSTATE + "\n" + "StateFrame: " + str(owner.enemy.stateFrame) + "\n" + "animFrame: " + str(owner.enemy.frame) + "\n" + "PrevState: " + str(owner.enemy.PREVSTATE) + "\n" + "PrevFrame: " + str(owner.enemy.prevStateFrame) + "\n" + "Stunned: " + str(owner.enemy.stunned) + "\n" + "HitCount: " + str(owner.enemy.hitCount) + "\n" + "MaxHitCount: " + str(owner.enemy.maxHitCount) + "\n" + "Health: " + str(owner.enemy.health) + "\n" + "aiActive: " + str(owner.enemy.aiActive)  
	debugInfoPlayer3.text = "bufferL: " + str(bufferPunchL) + "\n" + "bufferR: " + str(bufferPunchR) + "\n" + "bufferUp: " + str(bufferUp) + "\n" + "Zoom: " + str(owner.cameraZoom) + "\n" + "DodgeLeft: " + str(dodgeLeft) + "\n" + "DodgeRight: " + str(dodgeRight) + "\n" + "DodgeDown: " + str(dodgeDown) + "\n" + "Health: " + str(health) + "\n" + "hasCombo: " + str(hasCombo)

func fixThisShit():
	if CURRSTATE == "PunchLeft" and owner.enemy.counterPunch and owner.enemy.hitLeft:
		stateMachine.change_state4("PunchLeftCounter")
	if CURRSTATE == "PunchRight" and owner.enemy.counterPunch and owner.enemy.hitRight:
		stateMachine.change_state4("PunchRightCounter")
	if CURRSTATE == "UpperLeft" and owner.enemy.counterPunch and owner.enemy.hitUpLeft:
		stateMachine.change_state4("UpperLeftCounter")
	if CURRSTATE == "UpperRight" and owner.enemy.counterPunch and owner.enemy.hitUpRight:
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
	if Input.is_action_just_pressed("LeftPunch") and !bufferPunchL:
		punchLBuffer = frameCounter
		bufferDodgeHI = false
		bufferPunchL = true
	
	if Input.is_action_just_pressed("RightPunch") and !bufferPunchR:
		punchRBuffer = frameCounter
		bufferDodgeHI = false
		bufferPunchR = true
	
	if Input.is_action_just_pressed("Down") and !bufferDodgeLW:
		dodgeBufferLW = frameCounter
		bufferDodgeLW = true
	
	if Input.is_action_just_pressed("Left") and !bufferDodgeL:
		dodgeBufferL = frameCounter
		bufferDodgeL = true
	
	if Input.is_action_just_pressed("Right") and !bufferDodgeR:
		dodgeBufferR = frameCounter
		bufferDodgeR = true
	
	if Input.is_action_just_pressed("Up") and !bufferDodgeHI:
		dodgeBufferHI = frameCounter
		bufferDodgeHI = true
	
	if Input.is_action_just_pressed("SuperPunch") and !bufferSuper:
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
