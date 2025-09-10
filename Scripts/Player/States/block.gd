extends State

var idleLoop = 0

func Exit():
	idleLoop = 0
	owner.isBlocking = false
	owner.makerHerVisible = false

func Enter():
	owner.spriteOffsets(7,2,10)
	owner.isBlocking = true
	owner.setFrame(0)
	owner.makerHerVisible = true
	idleLoop = 0

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if Input.is_action_pressed("Up") and owner.isBlocking:
		idleLoop += 1
		
		if idleLoop == 0:
			owner.setFrame(0)
		if idleLoop == 8:
			owner.setFrame(1)
		if idleLoop == 16:
			owner.setFrame(2)
		if idleLoop == 24:
			owner.setFrame(3)
		if idleLoop == 32:
			owner.setFrame(4)
		
		if idleLoop == 40:
			owner.setFrame(0)
			idleLoop = 0
	
	if !Input.is_action_pressed("Up") and owner.stateFrame > 10 and owner.isBlocking:
		idleLoop = 0
		owner.setFrame(9)
		owner.isBlocking = false
	
	if !owner.isBlocking:
		idleLoop += 1
		
		if idleLoop == 0:
			owner.setFrame(9)
		if idleLoop == 2:
			owner.setFrame(10)
			owner.makerHerVisible = false
		if idleLoop == 4:
			owner.setFrame(11)
		if idleLoop == 6:
			owner.setFrame(12)
		if idleLoop == 8:
			owner.setFrame(13)
		if idleLoop == 10:
			Transitioned.emit(self, "wait")
