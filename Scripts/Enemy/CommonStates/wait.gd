extends State

func Enter():
	owner.animSys.animPlay("Wait")
	owner.flip_h = false

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(2):
		owner.resetCombo()
	if owner.cFrame(20):
		owner.guardAll = false
