extends State

var idleLoop = 0

func Exit():
	idleLoop = 0
	Gamemanager.destroyEffect("DIZZY")

func Enter():
	Gamemanager.createEffects("DIZZY", 1.0, 1.0, 0, -335)
	owner.spriteOffsets(7,1,5)
	owner.setFrame(0)
	owner.dizzy = owner.dizzyTime

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	owner.dizzy -= 1
	idleLoop += 1
	
	if idleLoop == 0:
		owner.setFrame(0)
	if idleLoop == 7:
		owner.setFrame(1)
	if idleLoop == 14:
		owner.setFrame(2)
	if idleLoop == 21:
		owner.setFrame(3)
	if idleLoop == 28:
		owner.setFrame(4)
	if idleLoop == 35:
		idleLoop = 0
	
	if owner.dizzy <= 0:
		owner.hitLeft = false
		owner.hitRight = false
		owner.hitUpLeft = false
		owner.hitUpRight = false
		owner.spriteOffsets(7,1,5)
		Transitioned.emit(self, "dizzyend")
