extends State


func Exit():
	owner.ctrl = 1
	owner.position.x = 0
	owner.makerHerVisible = false
	owner.setColor(255,255,255)
	owner.zoomCamera(0.2, 1.0)

func Enter():
	owner.ctrl = 0
	owner.animSys.animPlay("DamageHi")
	owner.dodgeRight = false
	owner.dodgeLeft = false
	owner.dodgeDown = false
	owner.setColor(255,164,150)
	owner.makerHerVisible = true
	owner.zoomCamera(0.6, 1.1)
	

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(2):
		owner.moveCameraY(0.6, -50)
	if owner.cFrame(4):
		owner.zoomCamera(0.2, 1.0)
	if owner.cFrame(15):
		owner.moveCameraY(0.2, 0)
	if owner.cFrame(25):
		owner.setColor(255,255,255)
	if owner.cFrame(39):
		owner.makerHerVisible = false
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
