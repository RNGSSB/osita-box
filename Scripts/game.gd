extends Node2D

var frameCounter = 0

var frameAdvance = false
var fuckYou = false

var hitStop = 0 

@onready var player = $Player
@onready var enemy = $Enemy
@onready var camera = $Camera


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func hitLag(value, shake):
	hitStop = value
	camera.randomShakeStrenght = shake
	camera.apply_shake()

func advanceFrame(delta):
	frameCounter += 1 
	player.stateFrame += 1
	enemy.stateFrame += 1
	player.frameCounter = frameCounter
	enemy.frameCounter = frameCounter
	camera.cameraShake(delta)
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


func _physics_process(delta):
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
			if Input.is_action_just_pressed("FrameUnwind"):
				hitStop = 0
	else:
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
