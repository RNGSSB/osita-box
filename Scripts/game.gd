extends Node2D

var frameCounter = 0

var frameAdvance = false
var fuckYou = false

var hitStop = 0 

var cameraZoom = 1.0

var cameraTilt = 0.0

@onready var player = $Player
@onready var enemy = $Enemy
@onready var camera = $Camera
@onready var pauseUI = $PauseUI
var canPause = true

var fuckYou2 = false

var isPaused = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if canPause:
		if Input.is_action_just_pressed("Start") and !fuckYou2:
			isPaused = true
		
		if Input.is_action_just_released("Start") and isPaused:
			fuckYou2 = true
		
		if Input.is_action_just_pressed("Start") and fuckYou2:
			isPaused = false
			fuckYou2 = false
	
	pauseUI.visible = isPaused
	
	get_tree().paused = isPaused


func hitLag(value, shake):
	hitStop = value
	camera.randomShakeStrenght = shake
	camera.apply_shake()

func zoomAdjust(value):
	camera.zoom = Vector2(value, value)

func advanceFrame(delta):
	frameCounter += 1 
	player.stateFrame += 1
	enemy.stateFrame += 1
	player.frameCounter = frameCounter
	enemy.frameCounter = frameCounter
	camera.cameraShake(delta)
	cameraShenanigans()
	player.sheVisibleNow()
	player.stateMachine.current_state.Update(delta)
	player.stateMachine.current_state.Physics_Update(delta)
	enemy.stateMachine.current_state.Update(delta)
	enemy.stateMachine.current_state.Physics_Update(delta)

func rewindFrame(delta):
	if frameCounter > 1 and player.stateFrame > 1 and enemy.stateFrame > 1:
		frameCounter -= 1 
	player.frameCounter = frameCounter
	enemy.frameCounter = frameCounter
	if player.stateFrame > 1:
		player.stateFrame -= 1
	elif player.CURRSTATE != player.PREVSTATE:
		player.stateMachine.change_state3(player.PREVSTATE)
		player.PREVSTATE = player.CURRSTATE
		player.stateFrame = player.prevStateFrame
	if enemy.stateFrame > 0:
		enemy.stateFrame -= 1
	elif enemy.CURRSTATE != enemy.PREVSTATE:
		enemy.stateMachine.change_state3(enemy.PREVSTATE)
		enemy.PREVSTATE = enemy.CURRSTATE
		enemy.stateFrame = enemy.prevStateFrame
	player.stateMachine.current_state.Update(delta)
	player.stateMachine.current_state.Physics_Update(delta)
	enemy.stateMachine.current_state.Update(delta)
	enemy.stateMachine.current_state.Physics_Update(delta)


func cameraShenanigans():
	if enemy.stunned and (enemy.CURRSTATE == "DamageN" or enemy.CURRSTATE == "DamageHi" or enemy.CURRSTATE == "DizzyHi" or enemy.CURRSTATE == "DizzyLw") and enemy.hitCount < enemy.maxHitCount + 1:
		if cameraZoom < 1.0 + (enemy.hitCount * 0.05):
			cameraZoom += 0.05
		if cameraZoom > 1.0 + (enemy.hitCount * 0.05):
			cameraZoom = 1.0 + (enemy.hitCount * 0.05)
	else:
		if cameraZoom > 1.0:
			cameraZoom -= 0.04
		if cameraZoom < 1.0:
			cameraZoom = 1.0
	
	if player.CURRSTATE == "DodgeLeft" and player.stateFrame <= 13:
		if cameraTilt > -105:
			cameraTilt -= 20
		
		if cameraTilt < -105:
			cameraTilt = -105
	
	if player.CURRSTATE == "DodgeLeft" and player.stateFrame > 16:
		if cameraTilt >= -105:
			cameraTilt += 10
		
		if cameraTilt > 0:
			cameraTilt = 0
	
	if player.CURRSTATE == "DodgeRight" and player.stateFrame <= 13:
		if cameraTilt < 105:
			cameraTilt += 20
		
		if cameraTilt > 105:
			cameraTilt = 105
	
	if player.CURRSTATE == "DodgeRight" and player.stateFrame > 16:
		if cameraTilt <= 105:
			cameraTilt -= 10
		
		if cameraTilt < 0:
			cameraTilt = 0
	
	
	if player.CURRSTATE != "DodgeLeft" and player.CURRSTATE != "DodgeRight":
		if cameraTilt > 0:
			cameraTilt -= 10
			if cameraTilt < 0:
				cameraTilt = 0
		if cameraTilt < 0:
			cameraTilt += 10
			if cameraTilt > 0:
				cameraTilt = 0
	
	camera.position.x = cameraTilt
	
	zoomAdjust(cameraZoom)

func _physics_process(delta):
	if !isPaused:
		if Input.is_action_just_pressed("Freeze") and !fuckYou:
			player.frozen = true
			enemy.frozen = true 
			frameAdvance = true
		
		if Input.is_action_just_pressed("Freeze") and fuckYou:
			player.frozen = false
			enemy.frozen = false
			frameAdvance = false
			fuckYou = false
		
		if Input.is_action_just_released("Freeze") and !fuckYou and frameAdvance:
			fuckYou = true
		
		if frameAdvance:
			if hitStop <= 0:
				if Input.is_action_just_pressed("FrameAdvance"):
					advanceFrame(delta)
				if Input.is_action_just_pressed("FrameUnwind"):
					rewindFrame(delta)
			else:
				if Input.is_action_just_pressed("FrameAdvance"):
					hitStop -= 1
					cameraShenanigans()
				if Input.is_action_just_pressed("FrameUnwind"):
					hitStop = 0
		else:
			cameraShenanigans()
			if hitStop <= 0:
				frameCounter += 1 
				player.frameCounter = frameCounter
				enemy.frameCounter = frameCounter
		
		if hitStop > 0:
			if !frameAdvance:
				player.frozen = true
				enemy.frozen = true
				hitStop -= 1
		else:
			if !frameAdvance:
				player.frozen = false
				enemy.frozen = false
