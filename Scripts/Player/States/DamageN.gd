extends State


func Exit():
	owner.ctrl = 1
	owner.position.x = 0

func Enter():
	owner.ctrl = 0
	owner.dodgeRight = false
	owner.dodgeLeft = false
	owner.dodgeDown = false
	owner.spriteOffsets(7,3,7)
	owner.setFrame(0)

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(0)
	if owner.cFrame(4):
		owner.setFrame(1)
	if owner.cFrame(7):
		owner.setFrame(2)
	if owner.cFrame(8):
		owner.setFrame(3)
	if owner.cFrame(10):
		owner.setFrame(4)
	if owner.cFrame(12):
		owner.setFrame(5)
	if owner.cFrame(14):
		owner.setFrame(6)
	if owner.cFrame(15):
		owner.setFrame(7)
	if owner.cFrame(20):
		owner.setFrame(8)
	if owner.cFrame(25):
		owner.setFrame(9)
	if owner.cFrame(26):
		owner.setFrame(10)
	if owner.cFrame(28):
		owner.setFrame(11)
	if owner.cFrame(30):
		owner.setFrame(12)
	if owner.cFrame(35):
		owner.setFrame(13)
	if owner.cFrame(40):
		owner.setFrame(14)
	if owner.cFrame(45):
		owner.setFrame(15)
	if owner.cFrame(50):
		owner.setFrame(16)
	if owner.cFrame(55):
		Transitioned.emit(self, "wait")
