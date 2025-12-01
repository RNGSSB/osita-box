extends State


func Exit():
	owner.ctrl = 1
	owner.position.x = 0
	owner.makerHerVisible = false
	owner.setColor(255,255,255)

func Enter():
	owner.ctrl = 0
	owner.animSys.animPlay("DamageS")
	owner.dodgeRight = false
	owner.dodgeLeft = false
	owner.setColor(255,164,150)
	owner.dodgeDown = false
	owner.makerHerVisible = true

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(16):
		owner.setColor(255,255,255)
	if owner.cFrame(27):
		owner.makerHerVisible = false
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
