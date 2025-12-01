extends Node2D

var frameCounter = 0

var frameAdvance = false
var fuckYou = false

var hitStop = 0 
var prevHitStop = 0

var cameraZoom = 1.0

var cameraTilt = 0.0
var cameraTiltMax = 0.0

var cameraTiltY = 0.0
var cameraTiltMaxY = 0.0

#@onready var player = $GameElements/Player
#@onready var enemy = $GameElements/Enemy
var player
var enemy

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
@onready var roundText = $HUD/Timer/Round

@onready var timer = $HUD/Timer

@onready var stateMachine = $StateMachine

@onready var readyText = $UIFront/Start

var CURRSTATE = "Intro"
var PREVSTATE = "Intro"
var stateFrame = 0
var frozen = false
var prevStateFrame = 0

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

var round = 1

func _ready():
	initFighters()
	
	round = 1
	
	player.superMeter = enemy.superInit
	initHealthBars()

func initFighters():
	var enemyInstance = load(Gamemanager.enemyList[Gamemanager.enemyId]).instantiate()
	get_node("GameElements").add_child(enemyInstance)
	enemyInstance.owner = self
	enemy = get_node("GameElements/Enemy")
	
	var playerInstance = load(Gamemanager.players[Gamemanager.playerId]).instantiate()
	get_node("GameElements").add_child(playerInstance)
	playerInstance.owner = self
	player = get_node("GameElements/Player")
	player.position.y = player.defaultPosY
	
	var playerPalette = load(Gamemanager.playerPalettes[Gamemanager.playerPaletteId]).instantiate()
	player.setPalette(playerPalette.glove_color_main,playerPalette.glove_color_socket,playerPalette.shirt_color_main,playerPalette.shirt_color_bottom,playerPalette.pant_color_main,playerPalette.pant_color_lines,playerPalette.shirt_color_shading,playerPalette.pant_color_shading,playerPalette.glove_color_shading ,playerPalette.glove_color_inner ,playerPalette.glove_color_socket_shading)


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

# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	if canPause:
		if Gamemanager.checkInputJustPressed("Start") and !fuckYou2:
			pauseUI.resumeButton.grab_focus()
			isPaused = true
			frozen = true
		
		if Gamemanager.checkInputJustReleased("Start") and isPaused:
			fuckYou2 = true
		
		if Gamemanager.checkInputJustPressed("Start") and fuckYou2 and !InputMapper.setting:
			pauseUI.select = 0
			if frameAdvance:
				frozen = true
			else:
				frozen = false
			isPaused = false
			fuckYou2 = false
	
	pauseUI.visible = isPaused
	
	if !pauseUI.visible and Options.visible:
		Options.visible = false
	
	if isPaused:
		readyText.visible = false
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

func advanceFrame(_delta):
	frameCounter += 1 
	if !pauseTimer:
		roundTimer -= 1.0
		if roundTimer > 0:
			secondTimer -= 1.0
	player.stateFrame += 1
	enemy.stateFrame += 1
	player.frameCounter = frameCounter
	enemy.frameCounter = frameCounter
	camera.cameraShake(_delta)
	cameraShenanigans()
	enemyHealingFunc()
	meterHandle()
	player.burnout()
	player.sheVisibleNow()
	player.stateMachine.current_state.Update(_delta)
	player.stateMachine.current_state.Physics_Update(_delta)
	player.animSys.animationProcess()
	if player.stateFrame == 1:
		player.animSys.animFrame = 1
	enemy.stateMachine.current_state.Update(_delta)
	enemy.stateMachine.current_state.Physics_Update(_delta)
	enemy.animSys.animationProcess()
	if enemy.stateFrame == 1:
		enemy.animSys.animFrame = 1


func cameraShenanigans():
	if enemy.stunned and (enemy.CURRSTATE == "DamageN" or enemy.CURRSTATE == "DamageHi" or enemy.CURRSTATE == "DizzyHi" or enemy.CURRSTATE == "DizzyLw") and enemy.hitCount < enemy.maxHitCount + 1:
		if cameraZoom < 1.0 + (enemy.hitCount * 0.05):
			cameraZoom += 0.05
		if cameraZoom > 1.0 + (7 * 0.05):
			cameraZoom = 1.0 + (7 * 0.05)
	else:
		if cameraZoom > 1.0:
			cameraZoom -= 0.04
		if cameraZoom < 1.0:
			cameraZoom = 1.0
	
	camera.position.x = lerp(camera.position.x, float(cameraTiltMax), cameraTilt)
	
	camera.position.y = lerp(camera.position.y, float(cameraTiltMaxY), cameraTiltY)
	
	zoomAdjust(cameraZoom)

func moveCamera(rate, towards):
	cameraTilt = rate
	cameraTiltMax = towards

func moveCameraY(rate, towards):
	cameraTiltY = rate
	cameraTiltMaxY = towards

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

func _physics_process(_delta):
	if !isPaused:
		if Input.is_key_pressed(KEY_9):
			regenHealth()
		
		timerUI()
		
		roundText.text = "ROUND " + str(round)
		
		if (player.CURRSTATE == "DamageS" or player.CURRSTATE == "DamageN") and player.stateFrame < 16:
			damageFilter.visible = true
		else:
			damageFilter.visible = false
		
		if enemy.CURRSTATE == "Wait":
			player.hasCombo = false
		
		player.hitCount = enemy.hitCount + 1
		
		if Input.is_action_just_pressed("Freeze") and !fuckYou:
			player.frozen = true
			player.animSys.frozen = true
			enemy.frozen = true 
			enemy.animSys.frozen = true
			frozen = true
			frameAdvance = true
		
		if Input.is_action_just_pressed("Freeze") and fuckYou:
			player.frozen = false
			player.animSys.frozen = false
			enemy.animSys.frozen = false
			enemy.frozen = false
			frameAdvance = false
			frozen = false
			fuckYou = false
		
		if Input.is_action_just_released("Freeze") and !fuckYou and frameAdvance:
			fuckYou = true
		
		if frameAdvance:
			if hitStop <= 0:
				if Input.is_action_just_pressed("FrameAdvance"):
					advanceFrame(_delta)
			else:
				if Input.is_action_just_pressed("FrameAdvance"):
					meterHandle()
					cameraShenanigans()
					camera.cameraShake(_delta)
					hitStop -= 1
					#hitStopShake()
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
				player.animSys.frozen = true
				enemy.frozen = true
				enemy.animSys.frozen = true
				hitStop -= 1
		else:
			if !frameAdvance:
				player.frozen = false
				player.animSys.frozen = false
				enemy.frozen = false
				enemy.animSys.frozen = false


func _on_enemy_timer_timeout():
	setDamageBarEnemy = true

func _on_player_timer_timeout():
	setDamageBarPlayer = true
