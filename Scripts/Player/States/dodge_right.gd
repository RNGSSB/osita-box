extends State


func Exit():
	owner.ctrl = 1
	owner.dodgeSuccess = false
	owner.perfectDodge = false
	owner.dodgeRight = false
	owner.makerHerVisible = false

func Enter():
	owner.ctrl = 0
	AudioManager.Play("Escape", "Right", 1.0, 1.0)
	owner.makerHerVisible = true
	owner.moveCamera(0.2, 105)
	owner.flip_h = true
	owner.animSys.animPlay("DodgeSide")
	owner.dodgeRight = true
	owner.dodgeDown = false
	owner.dodgeLeft = false
	owner.bufferDodgeR = false

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(1):
		owner.makerHerVisible = true
	if owner.cFrame(7):
		owner.makerHerVisible = false
	if owner.cFrame(16):
		owner.dodgeRight = false
	if owner.cFrame(18):
		owner.moveCamera(0.2, 0)
	if owner.cFrame(20):
		if owner.dodgeSuccess:
			owner.ctrl = 1
	if owner.cFrame(31):
		owner.ctrl = 1
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
