extends State


func Exit():
	owner.ctrl = 1
	owner.position.x = 0
	owner.makerHerVisible = false
	owner.setColor(255,255,255)

func Enter():
	owner.ctrl = 0
	owner.dodgeRight = false
	owner.dodgeLeft = false
	owner.setColor(255,164,150)
	owner.dodgeDown = false
	owner.makerHerVisible = true
	owner.spriteOffsets(7,3,7)
	owner.setFrame(0)

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(0) #2
	if owner.cFrame(3):
		owner.setFrame(1) #2
	if owner.cFrame(5):
		owner.setFrame(2) #1
	if owner.cFrame(6):
		owner.setFrame(3) #2
	if owner.cFrame(8):
		owner.setFrame(4) #2
	if owner.cFrame(10):
		owner.setFrame(5) #2
	if owner.cFrame(12):
		owner.setFrame(6) #4 
	if owner.cFrame(16):
		owner.setColor(255,255,255)
		owner.setFrame(7) #4
	if owner.cFrame(20):
		owner.setFrame(8) #3
	if owner.cFrame(23):
		owner.setFrame(9) #2
	if owner.cFrame(25):
		owner.setFrame(10) #2
	if owner.cFrame(27):
		owner.makerHerVisible = false
		owner.setFrame(11) #2
	if owner.cFrame(29):
		owner.setFrame(12) #2
	if owner.cFrame(31):
		owner.setFrame(13) #2
	if owner.cFrame(33):
		owner.setFrame(14) #2
	if owner.cFrame(35):
		owner.setFrame(15) #2
	if owner.cFrame(37):
		Transitioned.emit(self, "wait")
