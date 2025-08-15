extends State

var idleLoop = 0

func Exit():
	idleLoop = 0

func Enter():
	owner.ctrl = 1
	owner.spriteOffsets(7,1,0)
	owner.setFrame(0)
	idleLoop = 0

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	idleLoop += 1
	
	if idleLoop == 6:
		owner.setFrame(0)
	if idleLoop == 12:
		owner.setFrame(1)
	if idleLoop == 18:
		owner.setFrame(2)
	if idleLoop == 24:
		owner.setFrame(3)
	if idleLoop == 30:
		owner.setFrame(4)
	
	if idleLoop == 36:
		idleLoop = 0
