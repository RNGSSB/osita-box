extends State


func Exit():
	owner.ctrl = 1
	owner.makerHerVisible = false

func Enter():
	owner.ctrl = 0
	owner.animSys.animPlay("BlockDamage")
	owner.makerHerVisible = true

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(10):
		owner.makerHerVisible = false
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
