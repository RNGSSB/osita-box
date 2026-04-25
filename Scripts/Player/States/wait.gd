extends State

func Exit():
	pass

func Enter():
	owner.ctrl = 1
	owner.canDodge = true
	owner.canBlock = true
	owner.dodgeSuccess = false
	owner.perfectDodge = false
	owner.dodgeLeft = false
	owner.dodgeRight = false
	owner.dodgeDown = false
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
