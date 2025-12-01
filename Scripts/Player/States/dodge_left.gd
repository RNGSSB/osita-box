extends State


func Exit():
	owner.ctrl = 1
	owner.moveCamera(0.2, 0)
	owner.dodgeSuccess = false
	owner.perfectDodge = false
	owner.dodgeLeft = false
	owner.makerHerVisible = false

func Enter():
	owner.ctrl = 0
	owner.makerHerVisible = true
	owner.moveCamera(0.2, -105)
	AudioManager.Play("Escape", "Left", 1.0, 1.0)
	owner.flip_h = false
	owner.animSys.animPlay("DodgeSide")
	owner.dodgeRight = false
	owner.dodgeDown = false
	owner.dodgeLeft = true
	owner.bufferDodgeL = false

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(1):
		owner.makerHerVisible = true
		owner.moveCamera(0.2, -105)
	if owner.cFrame(7):
		owner.makerHerVisible = false
	if owner.cFrame(16):
		owner.dodgeLeft = false
	if owner.cFrame(18):
		owner.moveCamera(0.2, 0)
	if owner.cFrame(20):
		if owner.dodgeSuccess:
			owner.ctrl = 1
	if owner.cFrame(31):
		owner.ctrl = 1
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
