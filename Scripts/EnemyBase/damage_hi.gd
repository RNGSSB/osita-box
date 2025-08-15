extends State


func Exit():
	pass

func Enter():
	owner.hitLeft = true
	owner.hitRight = true
	owner.hitUpLeft = true
	owner.hitUpRight = true
	owner.spriteOffsets(7,2,6)
	owner.setFrame(0)

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(0)
	if owner.cFrame(5):
		owner.setFrame(1)
	if owner.cFrame(10):
		owner.setFrame(2)
	if owner.cFrame(15):
		owner.setFrame(3)
	if owner.cFrame(20):
		owner.setFrame(4)
	if owner.cFrame(25):
		owner.setFrame(5)
	if owner.cFrame(30):
		owner.setFrame(6)
	if owner.cFrame(35):
		owner.setFrame(7)
	if owner.cFrame(40):
		Transitioned.emit(self, "wait")
