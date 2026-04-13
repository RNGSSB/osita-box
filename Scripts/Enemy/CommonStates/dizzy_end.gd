extends State


func Exit():
	pass

func Enter():
	owner.stunned = false
	owner.hitLeft = false
	owner.hitRight = false
	owner.hitUpLeft = false
	owner.hitUpRight = false
	owner.hitCount = 0

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(6):
		owner.zoomCamera(0.2, 1.0)
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
