extends State


func Exit():
	owner.ctrl = 1
	owner.punchHit = false
	owner.punchBlock = false
	owner.makerHerVisible = false
	owner.hasCombo = false

func Enter():
	owner.ctrl = 0
	owner.makerHerVisible = true
	owner.animSys.animPlay("PunchLowFinisher")
	AudioManager.Play("Attack4Swoosh", "Right", 1.0, 1.0)
	owner.bufferPunchR = false
	owner.bufferUp = false
	owner.flip_h = false

func Update(_delta: float):
	if owner.frameCounter >= 6:
		if Gamemanager.checkInputJustPressed("Up") and !owner.bufferUp:
			owner.upBuffer = owner.frameCounter
			owner.bufferUp = true

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.makerHerVisible = true
	if owner.cFrame(5):
		owner.punchOpponent(1, owner.finishDamage, owner.finishMeterGain, false, "Right", "Damage4", 1.0, 1.35, 
		"DamageN4", false, 4.0, 4.0, "HITFINISHER", -200, 60, 3.0, 3.0)
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
