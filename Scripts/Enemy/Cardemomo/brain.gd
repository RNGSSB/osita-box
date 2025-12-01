extends Node


var currentStance = "Wait"
var nextAttack = "Attack2"
var attackAvailable = false
var rng = RandomNumberGenerator.new()
var attackPhase = 0 

var waitTimer = 0
var nextMove = 60
var minTime = 60
var maxTime = 180

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func clearMiss():
	owner.attackMiss = false

func timerDone():
	if waitTimer >= nextMove:
		waitTimer = 0
		nextMove = rng.randi_range(minTime, maxTime)
		if rng.randi_range(0, 3) == 0:
			currentStance = "Wait"
		elif rng.randi_range(0, 3) == 1:
			currentStance = "BlockLw"
		elif rng.randi_range(0, 3) == 2:
			currentStance = "BlockHi"
		return true
	else:
		return false

func brainJuice():
	if !owner.aiActive:
		return
	
	if attackAvailable:
		if !owner.damaged and !owner.guardAll and (owner.CURRSTATE != "BlockLwDamage" or owner.CURRSTATE != "BlockHiDamage"):
			owner.stateMachine.change_state(currentStance)
		waitTimer += 1
	else:
		if !owner.damaged:
			waitTimer = 0
		else:
			if waitTimer < nextMove - 1:
				waitTimer += 1
	
	if owner.CURRSTATE == "Wait" or owner.CURRSTATE == "BlockLw" or owner.CURRSTATE == "BlockHi" or owner.CURRSTATE == "BlockLwDamage" or owner.CURRSTATE == "BlockHiDamage":
		attackAvailable = true
	else:
		attackAvailable = false
	
	if timerDone() and attackAvailable:
		owner.stateMachine.change_state(nextAttack)
		attackAvailable = false
	
	if owner.attackMiss and attackPhase == 0:
		nextAttack = "Attack1"
		attackPhase = 1
		clearMiss()
	
	if owner.attackMiss and attackPhase == 1:
		nextAttack = "Attack3"
		attackPhase = 2
		clearMiss()
	
	if owner.attackMiss and attackPhase == 2:
		attackPhase = 3
		if rng.randi_range(0, 3) == 0:
			nextAttack = "Attack1"
		elif rng.randi_range(0, 3) == 1:
			nextAttack = "Attack2"
		elif rng.randi_range(0, 3) == 2:
			nextAttack = "Attack3"
		clearMiss()
	
	if attackPhase == 3 and !owner.attackMiss:
		if rng.randi_range(0, 3) == 0:
			nextAttack = "Attack1"
		elif rng.randi_range(0, 3) == 1:
			nextAttack = "Attack2"
		elif rng.randi_range(0, 3) == 2:
			nextAttack = "Attack3"
	
	if owner.attackMiss and attackPhase == 3:
		nextAttack = "Attack2"
		attackPhase = 0
		clearMiss()

func _physics_process(_delta):
	brainJuice()
