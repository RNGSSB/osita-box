extends State


func Exit():
	owner.ctrl = 1
	owner.punchHit = false
	owner.punchBlock = false
	owner.makerHerVisible = false

func Enter():
	owner.ctrl = 0
	owner.makerHerVisible = true
	owner.animSys.animPlay("PunchHigh")
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
	if owner.cFrame(5):
		owner.punchOpponent(2, owner.punchDamage, owner.punchMeterGain, true, "Left", "Damage3", 1.0, 1.0 + (owner.hitCount * 0.2), 
		"DamageHi", true, 1.0, 1.0, "HIT", 0, -180, 2.0, 2.0)
	if !owner.punchHit:
		if owner.cFrame(6):
			owner.animSys.animPlay("PunchHighMiss")
		if owner.animSys.animEnd:
			Transitioned.emit(self, "wait")
	else:
		if owner.cFrame(20 - owner.epicCombo):
			if owner.punchHit:
				owner.ctrl = 1
		if owner.animSys.animEnd:
			Transitioned.emit(self, "wait")
