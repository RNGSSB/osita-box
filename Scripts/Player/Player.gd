extends Sprite2D
@onready var stateMachine = $StateMachine
@onready var debugInfoPlayer = $DebugUI/Player1Side
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

var animSheets = [preload("res://Sprites/Characters/Canela/A00Wait1.png"),
preload("res://Sprites/Characters/Canela/A01AttackLw.png"),
preload("res://Sprites/Characters/Canela/A02AttackHi.png"),
preload("res://Sprites/Characters/Canela/A03AttackLw4.png"),
preload("res://Sprites/Characters/Canela/A04EscapeN.png"),
preload("res://Sprites/Characters/Canela/A05AttackHi4.png"),
preload("res://Sprites/Characters/Canela/A06EscapeS.png"),
preload("res://Sprites/Characters/Canela/A07DamageS.png"),]

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
	pass

func _process(delta):
	inputX = Input.get_axis("Left", "Right")
	inputY = Input.get_axis("Down", "Up")
	
	processInputs()
	
	if ctrl == 1:
		if inputY <= 0 and bufferPunchL and !bufferUp:
			if !owner.enemy.counterPunch:
				stateMachine.change_state2("PunchLeft")
			else:
				stateMachine.change_state2("PunchLeftCounter")
		if inputY <= 0 and bufferPunchR and !bufferUp:
			if !owner.enemy.counterPunch:
				stateMachine.change_state2("PunchRight")
			else:
				stateMachine.change_state2("PunchRightCounter")
		if (inputY > 0 or bufferUp) and bufferPunchL:
			if !owner.enemy.counterPunch:
				stateMachine.change_state2("UpperLeft")
			else:
				stateMachine.change_state2("UpperLeftCounter")
		if (inputY > 0 or bufferUp) and bufferPunchR:
			if !owner.enemy.counterPunch:
				stateMachine.change_state2("UpperRight")
			else:
				stateMachine.change_state2("UpperRightCounter")
		
		if bufferDodgeL:
			stateMachine.change_state2("DodgeLeft")
		if bufferDodgeR:
			stateMachine.change_state2("DodgeRight")
		if bufferDodgeLW:
			stateMachine.change_state2("DodgeDown")
		if bufferDodgeHI:
			stateMachine.change_state("Guard")

func _physics_process(delta):
	debugUI()
	fixThisShit()
	clearBuffer()

func punchOpponent(value):
	enemyRef = owner.enemy
	if value == 0: #Left Punch
		if enemyRef.hitLeft:
			punchHit = true
			enemyRef.flip_h = true
			if !enemyRef.counterPunch:
				owner.hitLag(enemyRef.hitlagPunch,enemyRef.shakePunch)
				Gamemanager.createEffects("HIT", 2.0, 2.0, 0, 60)
				enemyRef.stateMachine.change_state2("DamageN")
			else:
				owner.hitLag(enemyRef.hitlagPunch * 2,enemyRef.shakePunch * 2)
				Gamemanager.createEffects("HITFINISHER", 2.0, 2.0, 0, 60)
				enemyRef.stateMachine.change_state2("DamageN4")
	elif value == 1: #Right Punch
		if enemyRef.hitRight:
			punchHit = true
			enemyRef.flip_h = false
			if !enemyRef.counterPunch:
				owner.hitLag(enemyRef.hitlagPunch,enemyRef.shakePunch)
				Gamemanager.createEffects("HIT", 2.0, 2.0, 0, 60)
				enemyRef.stateMachine.change_state2("DamageN")
			else:
				owner.hitLag(enemyRef.hitlagPunch * 2,enemyRef.shakePunch * 2)
				Gamemanager.createEffects("HITFINISHER", 2.0, 2.0, 0, 60)
				enemyRef.stateMachine.change_state2("DamageN4")
	elif value == 2: #Left Upper
		if enemyRef.hitUpLeft:
			punchHit = true
			enemyRef.flip_h = true
			if !enemyRef.counterPunch:
				owner.hitLag(enemyRef.hitlagUpper,enemyRef.shakeUpper)
				Gamemanager.createEffects("HIT", 2.0, 2.0, 0, -140)
				enemyRef.stateMachine.change_state2("DamageHi")
			else:
				owner.hitLag(enemyRef.hitlagUpper * 2,enemyRef.shakeUpper * 2)
				Gamemanager.createEffects("HITFINISHER", 2.0, 2.0, 60, -240)
				enemyRef.stateMachine.change_state2("DamageHi4")
	elif value == 3: #Right Upper
		if enemyRef.hitUpRight:
			punchHit = true
			enemyRef.flip_h = false
			if !enemyRef.counterPunch:
				owner.hitLag(enemyRef.hitlagUpper,enemyRef.shakeUpper)
				Gamemanager.createEffects("HIT", 2.0, 2.0, 0, -140)
				enemyRef.stateMachine.change_state2("DamageHi")
			else:
				owner.hitLag(enemyRef.hitlagUpper * 2,enemyRef.shakeUpper * 2)
				Gamemanager.createEffects("HITFINISHER", 2.0, 2.0, -60, -240)
				enemyRef.stateMachine.change_state2("DamageHi4")
	elif value == 4: #Left Punch Finish
		if enemyRef.hitLeft:
			punchHit = true
			enemyRef.flip_h = true
			if !enemyRef.counterPunch:
				owner.hitLag(enemyRef.hitlagPunch * enemyRef.finalHitlagMul,enemyRef.shakePunch * enemyRef.finalShakeMul)
			else:
				owner.hitLag(enemyRef.hitlagPunch * 2,enemyRef.shakePunch * 2)
			Gamemanager.createEffects("HITFINISHER", 2.0, 2.0, 0, 60)
			enemyRef.stateMachine.change_state2("DamageN4")
	elif value == 5: #Right Punch Finish
		if enemyRef.hitRight:
			punchHit = true
			enemyRef.flip_h = false
			if !enemyRef.counterPunch:
				owner.hitLag(enemyRef.hitlagPunch * enemyRef.finalHitlagMul,enemyRef.shakePunch * enemyRef.finalShakeMul)
			else:
				owner.hitLag(enemyRef.hitlagPunch * 2,enemyRef.shakePunch * 2)
			Gamemanager.createEffects("HITFINISHER", 2.0, 2.0, 0, 60)
			enemyRef.stateMachine.change_state2("DamageN4")
	elif value == 6: #Left Upper Finish
		if enemyRef.hitUpLeft:
			punchHit = true
			enemyRef.flip_h = true
			if !enemyRef.counterPunch:
				owner.hitLag(enemyRef.hitlagUpper * enemyRef.finalHitlagMul,enemyRef.shakeUpper * enemyRef.finalShakeMul)
			else:
				owner.hitLag(enemyRef.hitlagUpper * 2,enemyRef.shakeUpper * 2)
			Gamemanager.createEffects("HITFINISHER", 2.0, 2.0, 60, -240)
			enemyRef.stateMachine.change_state2("DamageHi4")
	elif value == 7: #Right Upper Finish
		if enemyRef.hitUpRight:
			punchHit = true
			enemyRef.flip_h = false
			if !enemyRef.counterPunch:
				owner.hitLag(enemyRef.hitlagUpper * enemyRef.finalHitlagMul,enemyRef.shakeUpper * enemyRef.finalShakeMul)
			else:
				owner.hitLag(enemyRef.hitlagUpper * 2,enemyRef.shakeUpper * 2)
			Gamemanager.createEffects("HITFINISHER", 2.0, 2.0, -60, -240)
			enemyRef.stateMachine.change_state2("DamageHi4")

func debugUI():
	debugInfoPlayer.text = "Frame: " + str(frameCounter) + "\n" + "State: " + CURRSTATE + "\n" + "StateFrame: " + str(stateFrame) + "\n" + "ctrl: " + str(ctrl) + "\n" + "frameAdvance: " + str(owner.frameAdvance) + "\n" + "animFrame: " + str(frame) + "\n" + "PrevState: " + PREVSTATE + "\n" + "PrevFrame: " + str(prevStateFrame) + "\n" + "HitStop: " + str(owner.hitStop)
	debugInfoPlayer2.text = "Frame: " + str(frameCounter) + "\n" + "State: " + owner.enemy.CURRSTATE + "\n" + "StateFrame: " + str(owner.enemy.stateFrame) + "\n" + "animFrame: " + str(owner.enemy.frame) + "\n" + "PrevState: " + str(owner.enemy.PREVSTATE) + "\n" + "PrevFrame: " + str(owner.enemy.prevStateFrame)

func fixThisShit():
	if CURRSTATE == "PunchLeft" and owner.enemy.counterPunch:
		stateMachine.change_state4("PunchLeftCounter")
	if CURRSTATE == "PunchRight" and owner.enemy.counterPunch:
		stateMachine.change_state4("PunchRightCounter")
	if CURRSTATE == "UpperLeft" and owner.enemy.counterPunch:
		stateMachine.change_state4("UpperLeftCounter")
	if CURRSTATE == "UpperRight" and owner.enemy.counterPunch:
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

func clearBuffer():
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
