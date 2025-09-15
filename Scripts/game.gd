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

@onready var playerHealth = $CanvasLayer/PlayerHealth
@onready var playerDamage = $CanvasLayer/PlayerDamage
@onready var enemyHealth = $CanvasLayer/EnemyHealth
@onready var enemyDamage = $CanvasLayer/EnemyDamage
@onready var enemyDamageTimer = $CanvasLayer/EnemyDamage/EnemyTimer
@onready var playerDamageTimer = $CanvasLayer/PlayerDamage/PlayerTimer
@onready var playerSuper = $CanvasLayer/PlayerSuper

@onready var timer = $CanvasLayer/Timer

var roundTimer = 3600.0
var secondTimer = 3600.0
var lolText = ""
var pauseTimer = true

var setDamageBarPlayer = false
var setDamageBarEnemy = false

var superFilled = false
var superDrained = false

var enemyHealing = 0
var enemyHealingRate = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player.superMeter = enemy.superInit
	initHealthBars()

func initHealthBars():
	playerHealth.max_value = player.maxHealth
	playerDamage.max_value = player.maxHealth
	enemyDamage.max_value = enemy.maxHealth
	enemyHealth.max_value = enemy.maxHealth
	playerHealth.value = player.health
	playerDamage.value = player.health
	enemyHealth.value = enemy.health
	enemyDamage.value = enemy.health
	playerSuper.max_value = player.superMax 
	playerSuper.value = enemy.superInit

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
	
	if isPaused:
		player.debugLayer.visible = false
	else:
		player.debugLayer.visible = true
	
	get_tree().paused = isPaused


func hitLag(value, shake):
	hitStop = value
	camera.randomShakeStrenght = shake
	camera.apply_shake()

func zoomAdjust(value):
	camera.zoom = Vector2(value, value)

func advanceFrame(delta):
	frameCounter += 1 
	if !pauseTimer:
		roundTimer -= 1.0
		if roundTimer > 0:
			secondTimer -= 1.0
	player.stateFrame += 1
	enemy.stateFrame += 1
	player.frameCounter = frameCounter
	enemy.frameCounter = frameCounter
	camera.cameraShake(delta)
	cameraShenanigans()
	enemyHealingFunc()
	meterHandle()
	player.sheVisibleNow()
	player.stateMachine.current_state.Update(delta)
	player.stateMachine.current_state.Physics_Update(delta)
	enemy.stateMachine.current_state.Update(delta)
	enemy.stateMachine.current_state.Physics_Update(delta)

func rewindFrame(delta):
	if frameCounter > 1 and player.stateFrame > 1 and enemy.stateFrame > 1:
		frameCounter -= 1 
	if !pauseTimer:
		roundTimer += 1.0
		secondTimer += 1.0
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

func playerUpdateHealth(value):
	player.health -= value
	setDamageBarPlayer = false
	playerDamageTimer.start()

func enemyUpdateHealth(value):
	enemy.health -= value
	setDamageBarEnemy = false
	enemyDamageTimer.start()

func enemyHealingFunc():
	if enemy.healing:
		if enemy.health < enemyHealing:
			enemy.health = lerp(enemy.health, float(enemyHealing), enemyHealingRate)
		else:
			enemyHealing = 0
			enemyHealingRate = 0
			enemy.healing = false

func regenHealth():
	enemy.health = enemy.maxHealth
	player.health = player.maxHealth
	playerDamage.value = player.health
	enemyDamage.value = enemy.health

func timerUI():
	if Input.is_key_pressed(KEY_7):
		pauseTimer = true
		
	if Input.is_key_pressed(KEY_8):
		pauseTimer = false
	
	if (secondTimer * 3 / 60) - 120 < 10:
		lolText = "0"
	else:
		lolText = ""
	
	if (secondTimer * 3 / 60) - 120 == 60:
		timer.text = str(snapped(roundTimer * 3 / 60 / 60, 00)) + ":00" 
	else:
		timer.text = str(snapped(roundTimer * 3 / 60 / 60, 00)) + ":" + lolText + str(snapped((secondTimer * 3 / 60) - 120, 00))
		
	if roundTimer < 0:
		roundTimer = 0
		secondTimer = 3600.0
	
	if (secondTimer * 3 / 60) - 120 < 0 and roundTimer > 0:
		secondTimer = 3600.0

func meterHandle():
	if player.superMeter == player.superMax and !superFilled: 
		AudioManager.Play("SuperMax", "SFX", 1.0, 1.0)
		superFilled = true
	
	if player.superMeter < player.superMax:
		superFilled = false
	
	if player.superMeter == 0 and !superDrained:
		hitLag(20, 25)
		AudioManager.Play("SuperDrain", "SFX", 1.0, 1.0)
		superDrained = true
	
	if player.superMeter > 0:
		superDrained = false
	
	if playerSuper.value > player.superMeter:
		playerSuper.value = lerp(playerSuper.value, float(player.superMeter), 0.5)
	if playerSuper.value < player.superMeter:
		playerSuper.value = lerp(playerSuper.value, float(player.superMeter), 0.5)
	
	if playerHealth.value > player.health:
		playerHealth.value = lerp(playerHealth.value, float(player.health), 0.5)
	if playerHealth.value < player.health:
		playerHealth.value = lerp(playerHealth.value, float(player.health), 0.5)
	
	if enemyHealth.value > enemy.health:
		enemyHealth.value = lerp(enemyHealth.value, float(enemy.health), 0.5)
	if enemyHealth.value < enemy.health:
		enemyHealth.value = lerp(enemyHealth.value, float(enemy.health), 0.5)
	
	if setDamageBarEnemy and enemyDamage.value != enemyHealth.value:
		enemyDamage.value = lerp(enemyDamage.value, float(enemy.health), 0.3)
	else:
		setDamageBarEnemy = false
	
	if setDamageBarPlayer and playerDamage.value != playerHealth.value:
		playerDamage.value = lerp(playerDamage.value, float(player.health), 0.3)
	else:
		setDamageBarPlayer = false

func _physics_process(delta):
	if !isPaused:
		if Input.is_key_pressed(KEY_9):
			regenHealth()
		
		timerUI()
		
		player.hitCount = enemy.hitCount + 1
		
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
			else:
				if Input.is_action_just_pressed("FrameAdvance"):
					hitStop -= 1
					meterHandle()
					cameraShenanigans()
		else:
			cameraShenanigans()
			meterHandle()
			enemyHealingFunc()
			if hitStop <= 0:
				frameCounter += 1 
				if !pauseTimer:
					roundTimer -= 1.0
					if roundTimer > 0:
						secondTimer -= 1.0
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


func _on_enemy_timer_timeout():
	setDamageBarEnemy = true

func _on_player_timer_timeout():
	setDamageBarPlayer = true
