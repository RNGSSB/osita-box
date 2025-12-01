extends State


func Exit():
	owner.ctrl = 1
	owner.punchHit = false
	owner.punchBlock = false
	owner.makerHerVisible = false

func Enter():
	owner.animSys.animPlay("Wait")
	owner.animSys.animPlay("PunchLow")
	owner.ctrl = 0
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

func Physics_Update(_delta: float):
	if owner.cFrame(1):
		owner.makerHerVisible = true
	if owner.cFrame(5):
		owner.punchOpponent(0, owner.punchDamage, owner.punchMeterGain, true, "Left", "Damage3", 1.0, 1.0 + (owner.hitCount * 0.2), 
		"DamageN", false, 1.0, 1.0, "HIT", 0, 60, 2.0, 2.0)
	if !owner.punchHit:
		if owner.cFrame(10):
			owner.animSys.animPlay("PunchLowMiss")
		
		if owner.animSys.animEnd:
			Transitioned.emit(self, "wait")
	else:
		if owner.cFrame(15):
			owner.makerHerVisible = false
		if owner.cFrame(20 - owner.epicCombo):
			if owner.punchHit:
				owner.ctrl = 1
		if owner.animSys.animEnd:
			Transitioned.emit(self, "wait")
