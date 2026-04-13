extends State


func Exit():
	owner.ctrl = 1
	owner.punchHit = false
	owner.punchBlock = false
	owner.makerHerVisible = false
	owner.hasCombo = false

func Enter():
	owner.ctrl = 0
	owner.animSys.animPlay("PunchHighFinisher")
	owner.makerHerVisible = true
	AudioManager.Play("Attack4Swoosh", "Left", 1.0, 1.0)
	owner.bufferPunchL = false
	owner.bufferUp = false
	owner.flip_h = true
	#owner.animSys.setFrame(6)

func Update(_delta: float):
	if owner.frameCounter >= 6:
		if Gamemanager.checkInputJustPressed("Up") and !owner.bufferUp:
			owner.upBuffer = owner.frameCounter
			owner.bufferUp = true

func Physics_Update(_delta: float):
	if owner.cFrame(1):
		owner.makerHerVisible = true
	if owner.cFrame(5):
		owner.punchOpponent("UpperLeftFinisher")
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
