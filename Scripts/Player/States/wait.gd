extends State

func Exit():
	pass

func Enter():
	owner.ctrl = 1
	if !owner.inBurnout:
		owner.animSys.animPlay("Wait")
	else:
		owner.animSys.animPlay("WaitBurn")

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if !owner.inBurnout:
		if owner.animSys.CURRANIM != "Wait":
			owner.animSys.animPlay("Wait")
	else:
		if owner.animSys.CURRANIM != "WaitBurn":
			owner.animSys.animPlay("WaitBurn")
