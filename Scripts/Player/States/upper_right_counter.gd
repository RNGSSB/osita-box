extends State


func Exit():
	owner.ctrl = 1
	owner.punchHit = false
	owner.punchBlock = false
	owner.makerHerVisible = false

func Enter():
	owner.ctrl = 0
	owner.animSys.animPlay("PunchHighCounter")
	owner.punchOpponent(3, owner.counterDamage, owner.counterMeterGain, false, "Right", "Damage4", 1.0, 1.35, 
	"DamageHi4", true, 3.0, 3.0, "HITCOUNTER", -150, -240, 3.0, 3.0)
	owner.makerHerVisible = true
	AudioManager.Play("Attack4Swoosh", "Right", 1.0, 1.0)
	owner.bufferPunchR = false
	owner.bufferUp = false
	owner.flip_h = false

func Update(_delta: float):
	if owner.frameCounter >= 6:
		if Gamemanager.checkInputJustPressed("Up") and !owner.bufferUp:
			owner.upBuffer = owner.frameCounter
			owner.bufferUp = true

func Physics_Update(_delta: float):
	if owner.cFrame(11):
		owner.ctrl = 1
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
