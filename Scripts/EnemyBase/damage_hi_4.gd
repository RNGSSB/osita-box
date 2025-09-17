extends State


func Exit():
	pass

func Enter():
	owner.hitLeft = false
	owner.hitRight = false
	owner.hitUpLeft = false
	owner.hitUpRight = false
	owner.counterPunch = false
	owner.hitCount = 0
	owner.stunned = false
	AudioManager.Stop("Dizzy")
	if owner.flipDamageHi:
		owner.flip_h = false
		if owner.playerPunch == 2:
			owner.spriteOffsets(7,2,18)
		if owner.playerPunch == 3:
			owner.spriteOffsets(7,2,6)
	else:
		owner.spriteOffsets(7,2,6)
		if owner.playerPunch == 2:
			owner.flip_h = true
		if owner.playerPunch == 3:
			owner.flip_h = false
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
