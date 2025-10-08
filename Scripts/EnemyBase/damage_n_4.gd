extends State


func Exit():
	owner.damaged = false

func Enter():
	owner.hitLeft = false
	owner.hitRight = false
	owner.hitUpLeft = false
	owner.hitUpRight = false
	owner.counterPunch = false
	owner.guardAll = true
	owner.damaged = true
	owner.stunned = false
	if owner.flipDamageLw:
		owner.flip_h = false
		if owner.playerPunch == 0:
			owner.spriteOffsets(7,2,17)
		if owner.playerPunch == 1:
			owner.spriteOffsets(7,2,4)
		if owner.playerPunch == 4:
			owner.spriteOffsets(7,2,4)
	else:
		owner.spriteOffsets(7,2,4)
		if owner.playerPunch == 0:
			owner.flip_h = true
		if owner.playerPunch == 1:
			owner.flip_h = false
	owner.hitCount = 0
	AudioManager.Stop("Dizzy")
	owner.setFrame(0)

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(0)
	if owner.cFrame(2):
		if owner.health == 0:
			Transitioned.emit(self, "dead")
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
