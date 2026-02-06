extends State


func Exit():
	owner.ctrl = 1
	owner.makerHerVisible = false
	owner.zoomCamera(0.2, 1.0)

func Enter():
	owner.ctrl = 0
	owner.animSys.animPlay("BlockDamage")
	owner.makerHerVisible = true
	owner.zoomCamera(0.6, 1.03)

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(10):
		owner.makerHerVisible = false
		owner.zoomCamera(0.2, 1.0)
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
