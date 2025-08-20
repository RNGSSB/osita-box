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

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(5)
	if owner.cFrame(8):
		owner.setFrame(6)
	if owner.cFrame(12):
		Transitioned.emit(self, "wait")
