extends State

var idleLoop = 0

func Exit():
	idleLoop = 0

func Enter():
	owner.setFrame(0)
	owner.counterPunch = false
	owner.spriteOffsets(7,1,1)
	owner.attackMiss = false
	owner.damaged = false
	idleLoop = 0
	owner.blockLeft = true
	owner.blockRight = true
	owner.blockUpLeft = false
	owner.blockUpRight = false

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	idleLoop += 1
	
	
	if owner.cFrame(20):
		owner.guardAll = false
	
	if idleLoop == 0:
		owner.setFrame(1)
	if idleLoop == 4:
		owner.setFrame(2)
	if idleLoop == 8:
		owner.setFrame(3)
	if idleLoop == 12:
		owner.setFrame(4)
	if idleLoop == 16:
		owner.setFrame(5)
	if idleLoop == 20:
		owner.setFrame(6)
	
	
	
	if idleLoop == 24:
		owner.setFrame(1)
		idleLoop = 0
