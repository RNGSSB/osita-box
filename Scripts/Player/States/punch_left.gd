extends State


func Exit():
	owner.ctrl = 1
	owner.punchHit = false
	owner.punchBlock = false
	owner.makerHerVisible = false

func Enter():
	owner.spriteOffsets(7,1,1)
	owner.ctrl = 0
	owner.setFrame(0)
	owner.makerHerVisible = true
	AudioManager.Play("AttackSwoosh", "Left", 1.0, 1.0)
	owner.bufferPunchL = false
	owner.bufferUp = false
	owner.flip_h = true

func Update(_delta: float):
	if owner.frameCounter >= 6:
		if Gamemanager.checkInputJustPressed("Up") and !owner.bufferUp:
			owner.upBuffer = owner.frameCounter
			owner.bufferUp = true

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.makerHerVisible = true
		owner.setFrame(0)
	if owner.cFrame(2):
		owner.setFrame(1)
	if owner.cFrame(3):
		owner.setFrame(2)
	if owner.cFrame(4):
		owner.setFrame(3)
	if owner.cFrame(5):
		owner.punchOpponent(0, owner.punchDamage, owner.punchMeterGain, true, "Left", "Damage3", 1.0, 1.0 + (owner.hitCount * 0.2), 
		"DamageN", false, 1.0, 1.0, "HIT", 0, 60, 2.0, 2.0)
		owner.setFrame(4)
	if !owner.punchHit:
		if owner.cFrame(10):
			owner.spriteOffsets(3,1,11)
			owner.setFrame(0)
		if owner.cFrame(18):
			owner.setFrame(1)
		if owner.cFrame(24):
			owner.setFrame(2)
		if owner.cFrame(30):
			Transitioned.emit(self, "wait")
	else:
		if owner.cFrame(15):
			owner.makerHerVisible = false
		if owner.cFrame(16):
			owner.setFrame(5)
		if owner.cFrame(20 - owner.epicCombo):
			if owner.punchHit:
				owner.ctrl = 1
		if owner.cFrame(20):
			owner.setFrame(5)
		if owner.cFrame(22):
			owner.setFrame(6)
		if owner.cFrame(30):
			Transitioned.emit(self, "wait")
