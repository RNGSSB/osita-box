extends State

var idleLoop = 0

func Exit():
	idleLoop = 0

func Enter():
	owner.spriteOffsets(7,1,0)
	owner.flip_h = false
	owner.setFrame(0)
	owner.hitLeft = true
	owner.hitRight = true
	owner.hitUpLeft = true
	owner.hitUpRight = true
	owner.hitCount = 0
	owner.maxHitCount = owner.normalCombo
	idleLoop = 0

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	idleLoop += 1
	
	if idleLoop == 0:
		owner.setFrame(0)
	if idleLoop == 5:
		owner.setFrame(1)
	if idleLoop == 10:
		owner.setFrame(2)
	if idleLoop == 15:
		owner.setFrame(3)
	if idleLoop == 20:
		owner.setFrame(4)
	if idleLoop == 25:
		owner.setFrame(5)
	if idleLoop == 30:
		owner.setFrame(6)
	
	
	
	if idleLoop == 35:
		idleLoop = 0
