extends State


func Exit():
	owner.ctrl = 1
	owner.punchHit = false
	owner.punchBlock = false
	owner.makerHerVisible = false

func Enter():
	owner.ctrl = 0
	owner.makerHerVisible = true
	owner.animSys.animPlay("PunchLowCounter")
	owner.punchOpponent(0, owner.counterDamage, owner.counterMeterGain, true, "Left", "Damage4", 1.0, 1.35, 
	"DamageN4Counter", false, 3.0, 3.0, "HITCOUNTER", 200, 60, 3.0, 3.0)
	owner.makerHerVisible = true
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
	if owner.cFrame(11):
		owner.ctrl = 1
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
