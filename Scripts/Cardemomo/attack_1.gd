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
	if owner.cFrame(5):
		owner.setFrame(2)
	if owner.cFrame(6):
		owner.setFrame(3)
	if owner.cFrame(7):
		owner.setFrame(4)
	if owner.cFrame(8):
		owner.setFrame(5)
	if owner.cFrame(9):
		owner.setFrame(6)
	if owner.cFrame(14):
		owner.setFrame(7)
	if owner.cFrame(18):
		owner.setFrame(8)
	if owner.cFrame(21):
		owner.setFrame(9)
	if owner.cFrame(23):
		owner.counterPunch = true
		owner.setFrame(10)
	if owner.cFrame(25):
		owner.setFrame(11)
	if owner.cFrame(27):
		owner.setFrame(12)
	if owner.cFrame(29):
		owner.setFrame(13)
	if owner.cFrame(32):
		owner.setFrame(14)
	if owner.cFrame(35):
		owner.setFrame(15)
	if owner.cFrame(37):
		owner.setFrame(16)
	if owner.cFrame(38):
		owner.setFrame(17)
	if owner.cFrame(39):
		owner.setFrame(18)
	if owner.cFrame(40):
		owner.counterPunch = false
		owner.punchOpponent(1)
		owner.setFrame(19)
	if owner.punchHit:
		if owner.cFrame(42):
			owner.spriteOffsets(7,1,10)
			owner.setFrame(0)
		if owner.cFrame(43): #1
			owner.setFrame(1)
		if owner.cFrame(44): # 1
			owner.setFrame(2)
		if owner.cFrame(48): # 4
			owner.setFrame(3)
		if owner.cFrame(53): #5
			owner.setFrame(4)
		if owner.cFrame(58): #4
			owner.setFrame(5)
		if owner.cFrame(64): #6
			owner.setFrame(6)
		if owner.cFrame(70): #6
			Transitioned.emit(self, "wait")
	else:
		if owner.cFrame(42):
			owner.hitLeft = true
			owner.hitRight = true
			owner.hitUpLeft = true
			owner.hitUpRight = true
			owner.spriteOffsets(7,4,11)
			owner.setFrame(0)
		if owner.cFrame(42):
			owner.stunned = true 
		if owner.cFrame(44):
			owner.setFrame(1)
		if owner.cFrame(45):
			owner.setFrame(2)
		if owner.cFrame(47):
			owner.setFrame(3)
		if owner.cFrame(48):
			owner.setFrame(4)
		if owner.cFrame(49):
			owner.setFrame(5)
		if owner.cFrame(50):
			owner.setFrame(6)
		if owner.cFrame(51):
			owner.setFrame(7)
		if owner.cFrame(52):
			owner.setFrame(8)
		if owner.cFrame(53):
			owner.setFrame(9)
		if owner.cFrame(54):
			owner.setFrame(10)
		if owner.cFrame(55):
			owner.setFrame(11)
		if owner.cFrame(56):
			owner.setFrame(12)
		if owner.cFrame(58):
			owner.setFrame(13)
		if owner.cFrame(60):
			owner.setFrame(14)
		if owner.cFrame(66):
			owner.setFrame(15)
		if owner.cFrame(72):
			owner.setFrame(16)
		if owner.cFrame(78):
			owner.setFrame(17)
		if owner.cFrame(84):
			owner.setFrame(18)
		if owner.cFrame(90):
			owner.setFrame(19)
		if owner.cFrame(92):
			owner.setFrame(20)
		if owner.cFrame(94):
			owner.setFrame(21)
		if owner.cFrame(96):
			owner.setFrame(22)
		if owner.cFrame(98):
			owner.stunned = false
			Transitioned.emit(self, "wait")
