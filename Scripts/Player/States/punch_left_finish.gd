extends State


func Exit():
	owner.ctrl = 1
	owner.punchHit = false
	owner.punchBlock = false
	owner.hasCombo = false
	owner.makerHerVisible = false

func Enter():
	owner.ctrl = 0
	owner.makerHerVisible = true
	owner.animSys.animPlay("PunchLowFinisher")
	AudioManager.Play("Attack4Swoosh", "Left", 1.0, 1.0)
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
		owner.punchOpponent(0, owner.finishDamage, owner.finishMeterGain, true, "Left", "Damage4", 1.0, 1.35, 
		"DamageN4", false, 4.0, 4.0, "HITFINISHER", 200, 60, 3.0, 3.0)
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
