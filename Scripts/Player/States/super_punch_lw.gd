extends State


func Exit():
	owner.ctrl = 1
	owner.makerHerVisible = false
	owner.hasCombo = false
	owner.punchHit = false

func Enter():
	owner.ctrl = 0
	owner.makerHerVisible = true
	owner.setFrame(0)
	owner.gameManager.hitLag(0,10)
	owner.bufferSuper = false
	owner.bufferUp = false
	AudioManager.Play("SuperStart", "SFX", 1.0, 1.0)
	owner.flip_h = false
	owner.spriteOffsets(7,2,8)

func Update(_delta: float):
	if owner.frameCounter >= 6:
		if Input.is_action_just_pressed("Up") and !owner.bufferUp:
			owner.upBuffer = owner.frameCounter
			owner.bufferUp = true

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(0) #3
	if owner.cFrame(4):
		#owner.gameManager.hitLag(5, 5)
		owner.setFrame(1) #3
	if owner.cFrame(7):
		owner.setFrame(2) #3
	if owner.cFrame(10):
		owner.setFrame(3) #3
	if owner.cFrame(13):
		owner.setFrame(4) #3
	if owner.cFrame(16):
		owner.setFrame(5) #3
	if owner.cFrame(18):
		AudioManager.Play("Attack4Swoosh", "Left", 1.0, 1.0)
	if owner.cFrame(19):
		owner.setFrame(6) #2
	if owner.cFrame(21):
		owner.punchOpponent(4, owner.superDamage, 2, false, "SFX", "SuperHit", 1.0, 1.0, 
		"DamageN4", false, 6.0, 4.0, "HITFINISHER", -200, 60, 3.0, 3.0)
		owner.setFrame(7) #1
	if owner.cFrame(22):
		owner.makerHerVisible = false
		owner.setFrame(8) #4
	if owner.cFrame(26):
		owner.setFrame(9) #6
	if owner.cFrame(32):
		owner.setFrame(10) #7
	if owner.cFrame(39):
		owner.setFrame(11) #7
	if owner.cFrame(46):
		owner.setFrame(12) #7
	if owner.cFrame(53):
		owner.setFrame(13) #7
	if owner.cFrame(60):
		Transitioned.emit(self, "wait")
