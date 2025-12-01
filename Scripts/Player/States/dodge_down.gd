extends State


func Exit():
	owner.ctrl = 1
	owner.dodgeSuccess = false
	owner.perfectDodge = false
	owner.dodgeDown = false
	owner.moveCameraY(0.2, 0)
	owner.position.y = 0
	owner.makerHerVisible = false

func Enter():
	owner.ctrl = 0
	owner.animSys.animPlay("DodgeDown")
	owner.makerHerVisible = true
	owner.position.y = 160
	AudioManager.Play("Escape", "SFX", 1.0, 1.0)
	owner.flip_h = false
	owner.dodgeRight = false
	owner.dodgeDown = true
	owner.dodgeLeft = false
	owner.bufferDodgeLW = false
	owner.moveCameraY(0.2, 100)

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(1):
		owner.makerHerVisible = true
	if owner.cFrame(14):
		owner.makerHerVisible = false
	if owner.cFrame(15):
		owner.dodgeDown = false
	if owner.cFrame(20):
		if owner.dodgeSuccess:
			owner.ctrl = 1
		owner.moveCameraY(0.2, 0)
	if owner.cFrame(31):
		owner.ctrl = 1
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
