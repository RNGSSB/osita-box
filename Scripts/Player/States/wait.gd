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
		owner.setFrame(0)
		idleLoop = 0
