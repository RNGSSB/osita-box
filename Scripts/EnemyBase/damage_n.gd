extends State


func Exit():
	pass

func Enter():
	owner.hitLeft = true
	owner.hitRight = true
	owner.hitUpLeft = true
	owner.hitUpRight = true
	if owner.flipDamageLw:
		owner.flip_h = false
		if owner.playerPunch == 0:
			owner.spriteOffsets(7,2,17)
		if owner.playerPunch == 1:
			owner.spriteOffsets(7,2,4)
	else:
		owner.spriteOffsets(7,2,4)
		if owner.playerPunch == 0:
			owner.flip_h = true
		if owner.playerPunch == 1:
			owner.flip_h = false
	AudioManager.Stop("Dizzy")
	owner.setFrame(2)

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(2)
	if owner.cFrame(5):
		owner.setFrame(3)
	if owner.cFrame(10):
		owner.setFrame(4)
	if owner.cFrame(15):
		owner.setFrame(5)
	if owner.cFrame(20):
		owner.setFrame(6)
	if owner.cFrame(25):
		owner.setFrame(7)
	if owner.cFrame(30):
		if owner.stunned:
			AudioManager.Play("Dizzy", "SFX", 1.0, 1.0) 
		owner.setFrame(8)
	if owner.cFrame(35):
		owner.setFrame(9)
	if owner.cFrame(40):
		if owner.stunned:
			Transitioned.emit(self, "dizzylw")
		else:
			Transitioned.emit(self, "wait")
