extends State


func Exit():
	owner.punchHit = false

func Enter():
	owner.stunned = false
	owner.hitCount = 0
	owner.counterPunch = false
	owner.hitLeft = false
	owner.hitRight = true
	owner.hitUpLeft = false
	owner.hitUpRight = false
	owner.setFrame(0)
	owner.flip_h = false
	owner.spriteOffsets(7,3,9)

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(0)
	if owner.cFrame(3):
		owner.setFrame(1)
	if owner.cFrame(6):
		owner.setFrame(2)
	if owner.cFrame(8):
		owner.setFrame(3)
	if owner.cFrame(9):
		owner.setFrame(4)
	if owner.cFrame(10):
		owner.setFrame(5)
	if owner.cFrame(11):
		owner.setFrame(6)
	if owner.cFrame(14):
		owner.setFrame(7)
	if owner.cFrame(16):
		owner.setFrame(8)
	if owner.cFrame(18):
		owner.setFrame(9)
	if owner.cFrame(20):
		owner.counterPunch = true
		owner.setFrame(10)
	if owner.cFrame(22):
		owner.setFrame(11)
	if owner.cFrame(24):
		owner.setFrame(12)
	if owner.cFrame(29):
		owner.setFrame(13)
	if owner.cFrame(31):
		owner.setFrame(14)
	if owner.cFrame(36):
		owner.setFrame(15)
	if owner.cFrame(38):
		owner.setFrame(16)
	if owner.cFrame(40):
		owner.counterPunch = false
		owner.punchOpponent(1)
		owner.setFrame(17)
	if owner.punchHit:
		if owner.cFrame(41):
			owner.spriteOffsets(7,1,10)
			owner.setFrame(0)
		if owner.cFrame(43):
			owner.setFrame(1)
		if owner.cFrame(45):
			owner.setFrame(2)
		if owner.cFrame(51):
			owner.setFrame(3)
		if owner.cFrame(56):
			owner.setFrame(4)
		if owner.cFrame(61):
			owner.setFrame(5)
		if owner.cFrame(66):
			owner.setFrame(6)
		if owner.cFrame(71):
			Transitioned.emit(self, "wait")
	else:
		if owner.cFrame(41):
			owner.hitLeft = true
			owner.hitRight = true
			owner.hitUpLeft = true
			owner.hitUpRight = true
			owner.spriteOffsets(7,1,11)
			owner.setFrame(0)
		if owner.cFrame(42):
			owner.stunned = true 
		if owner.cFrame(49):
			owner.setFrame(1)
		if owner.cFrame(56):
			owner.setFrame(2)
		if owner.cFrame(67):
			owner.setFrame(3)
		if owner.cFrame(73):
			owner.setFrame(4)
		if owner.cFrame(79):
			owner.setFrame(5)
		if owner.cFrame(85):
			owner.setFrame(6)
		if owner.cFrame(91):
			owner.stunned = false
			Transitioned.emit(self, "wait")
