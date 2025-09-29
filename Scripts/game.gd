extends Node2D

var frameCounter = 0

var frameAdvance = false
var fuckYou = false

var hitStop = 0 
var prevHitStop = 0

var cameraZoom = 1.0

var cameraTilt = 0.0

@onready var player = $GameElements/Player
@onready var enemy = $GameElements/Enemy
@onready var camera = $GameElements/Camera
@onready var pauseUI = $PauseUI
var canPause = true

var fuckYou2 = false

var isPaused = false

@onready var playerHealth = $HUD/Timer/PlayerHealth
@onready var playerDamage = $HUD/Timer/PlayerDamage
@onready var enemyHealth = $HUD/Timer/EnemyHealth
@onready var enemyDamage = $HUD/Timer/EnemyDamage
@onready var enemyDamageTimer = $HUD/Timer/EnemyDamage/EnemyTimer
@onready var playerDamageTimer = $HUD/Timer/PlayerDamage/PlayerTimer
@onready var playerSuper = $HUD/Timer/PlayerSuper
@onready var damageFilter = $HUD/Damage

@onready var timer = $HUD/Timer

var roundTimer = 3600.0
var secondTimer = 3600.0
var lolText = ""
var pauseTimer = false

var setDamageBarPlayer = false
var setDamageBarEnemy = false

var superFilled = false
var superDrained = false

var enemyHealing = 0
var enemyHealingRate = 0

var rageActive = false

var fuckYou3 = false
var prevScreenMode

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
	player.burnout()
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
		if cameraZoom < 1.0 + (enemy.hitCount * 0.07):
			cameraZoom += 0.05
		if cameraZoom > 1.0 + (enemy.hitCount * 0.07):
			cameraZoom = 1.0 + (enemy.hitCount * 0.07)
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
	if player.inBurnout:
		player.health -= value * 2
	else:
		player.health -= value
	setDamageBarPlayer = false
	playerDamageTimer.start()

func enemyUpdateHealth(value):
	if rageActive:
		if player.health > player.maxHealth / 1.2:
			enemy.health -= value * 1.0
		elif player.health > player.maxHealth / 2:
			enemy.health -= value * 1.15
		elif player.health > player.maxHealth / 4:
			enemy.health -= value * 1.2
		elif player.health < player.maxHealth / 4:
			enemy.health -= value * 1.3
	else:
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

func hitStopShake():
	if hitStop > 0:
		var rng = RandomNumberGenerator.new()
		if enemy.damaged:
			enemy.offset = Vector2(rng.randi_range((hitStop * 2) * -1, hitStop * 2),rng.randi_range(-10 + (hitStop * 2) * -1, 10 + hitStop * 2))
			player.offset = Vector2(rng.randi_range(-5 + (hitStop * 2) * -1, 5 + hitStop * 2),rng.randi_range(0, 10 + hitStop * 2))
		else:
			enemy.offset = Vector2(rng.randi_range(-5 + (hitStop * 2) * -1, 5 + hitStop * 2),rng.randi_range(-10 + (hitStop * 2) * -1, 10 + hitStop * 2))
			player.offset = Vector2(rng.randi_range(-10 + (hitStop * 12) * -1, 10 + hitStop * 12),rng.randi_range(0, 10 + hitStop * 2))
	else:
		enemy.offset = Vector2(0,0)
		player.offset = Vector2(0,0)

func timerUI():
	if Input.is_key_pressed(KEY_8):
		roundTimer = 3600.0
		secondTimer = 3600.0
	
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

func playerBurnout():
	hitLag(20, 25)
	player.inBurnout = true
	playerSuper.value = 0
	playerSuper.max_value = 0
	playerSuper.min_value = player.burnoutTime * -1
	playerSuper.get("theme_override_styles/fill").bg_color = Color.DARK_GRAY
	player.burnoutTimer = player.burnoutTime
	AudioManager.Play("SuperDrain", "SFX", 1.0, 1.0)
	superDrained = true


func meterHandle():
	if !player.inBurnout:
		if player.superMeter == player.superMax and !superFilled: 
			AudioManager.Play("SuperMax", "SFX", 1.0, 1.0)
			superFilled = true
		
		if player.superMeter < player.superMax:
			superFilled = false
		
		if player.superMeter == 0 and !superDrained:
			playerBurnout()
		
		if player.superMeter > 0:
			superDrained = false
		
		if playerSuper.value > player.superMeter:
			playerSuper.value = lerp(playerSuper.value, float(player.superMeter), 0.5)
		if playerSuper.value < player.superMeter:
			playerSuper.value = lerp(playerSuper.value, float(player.superMeter), 0.5)
	else:
		playerSuper.value = player.burnoutTimer * -1
	
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
		
		if (player.CURRSTATE == "DamageS" or player.CURRSTATE == "DamageN") and player.stateFrame < 16:
			damageFilter.visible = true
		else:
			damageFilter.visible = false
		
		if enemy.CURRSTATE == "Wait":
			player.hasCombo = false
		
		player.hitCount = enemy.hitCount + 1
		
		
		if Input.is_action_just_pressed("Fullscreen") and !fuckYou3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) 
		
		if Input.is_action_just_released("Fullscreen") and !fuckYou3 and DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			fuckYou3 = true
		
		if Input.is_action_just_pressed("Fullscreen") and fuckYou3 :
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
		
		if Input.is_action_just_released("Fullscreen") and fuckYou3 and DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			fuckYou3 = false
		
		
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
					#hitStopShake()
					meterHandle()
					cameraShenanigans()
		else:
			cameraShenanigans()
			meterHandle()
			enemyHealingFunc()
			#hitStopShake()
			if hitStop <= 0:
				frameCounter += 1 
				player.burnout()
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
