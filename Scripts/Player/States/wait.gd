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
	
	if !owner.inBurnout:
		if owner.superMeter >= owner.superMax:
			if idleLoop == 0:
				owner.setFrame(0)
			if idleLoop == 4:
				owner.setFrame(1)
			if idleLoop == 8:
				owner.setFrame(2)
			if idleLoop == 12:
				owner.setFrame(3)
			if idleLoop == 16:
				owner.setFrame(4)
			if idleLoop == 20:
				owner.setFrame(0)
				idleLoop = 0
			if idleLoop > 20:
				idleLoop = 0
		else:
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
			if idleLoop > 35:
				idleLoop = 0
	else:
		if idleLoop == 0:
			owner.setFrame(0)
		if idleLoop == 14:
			owner.setFrame(1)
		if idleLoop == 24:
			owner.setFrame(2)
		if idleLoop == 34:
			owner.setFrame(3)
		if idleLoop == 44:
			owner.setFrame(4)
		if idleLoop == 54:
			owner.setFrame(0)
			idleLoop = 0
