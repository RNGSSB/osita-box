extends State


func Exit():
	pass

func Enter():
	owner.hitLeft = false
	owner.hitRight = false
	owner.hitUpLeft = false
	owner.hitUpRight = false
	owner.counterPunch = false
	owner.stunned = false
	owner.hitCount = 0
	owner.spriteOffsets(7,1,13)
	AudioManager.Stop("Dizzy")
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
		Transitioned.emit(self, "wait")
