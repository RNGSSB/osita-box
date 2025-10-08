extends State


func Exit():
	owner.punchHit = false
	owner.attackMiss = false
	owner.isAttacking = false
	owner.counterPunch = false

func Enter():
	owner.isAttacking = true
	owner.stunned = false
	owner.hitCount = 0
	owner.counterPunch = false
	owner.guardAll = false
	owner.hitLeft = false
	owner.hitRight = false
	owner.hitUpLeft = false
	owner.hitUpRight = false
	owner.Guard(false,false,false,false)
	owner.setFrame(0)
	owner.flip_h = false
	owner.spriteOffsets(7,3,20)

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(0) #2
	if owner.cFrame(3):
		owner.setFrame(1) #2
	if owner.cFrame(5):
		owner.setFrame(2) #2
	if owner.cFrame(7):
		owner.setFrame(3) #2
	if owner.cFrame(9):
		owner.setFrame(4) #2
	if owner.cFrame(11):
		owner.setFrame(5) #2
	if owner.cFrame(13):
		owner.hitRight = true
		owner.setFrame(6) #2
	if owner.cFrame(15):
		owner.setFrame(7) #5
	if owner.cFrame(20):
		owner.setFrame(8) #10
		owner.counterPunch = true
	if owner.cFrame(30):
		owner.setFrame(9) #1
	if owner.cFrame(31):
		owner.setFrame(10) #1
	if owner.cFrame(32):
		owner.setFrame(11) #1
	if owner.cFrame(33):
		owner.setFrame(12) #1
		owner.counterPunch = false
	if owner.cFrame(34):
		owner.punchOpponent(2, 20, 20, true, 12, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200, 34, true, 6, 1, 9, true, false, false, false)
		owner.setFrame(13) #2
	if owner.cFrame(35):
		owner.punchOpponent(2, 20, 20, true, 12, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200, 34, true, 6, 1, 9,  true, false, false, false)
	if owner.cFrame(36):
		owner.punchOpponent(2, 20, 20, true, 12, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200, 34, true, 6, 1, 9,  true, true, false, true)
		owner.setFrame(14) #2
	if owner.cFrame(37):
		owner.punchOpponent(2, 20, 20, true, 12, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200, 34, true, 6, 1, 9,  true, true, false, true)
	if owner.cFrame(38):
		owner.punchOpponent(2, 20, 20, true, 12, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200, 34, true, 6, 1, 9,  true, true, true, true, "DamageS", 250, true)
		owner.setFrame(15) #2
	if owner.cFrame(39):
		owner.punchOpponent(2, 20, 20, true, 12, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200, 34, true, 6, 1, 9, true, true, true, true, "DamageS", 250, true)
	if owner.cFrame(40):
		owner.setFrame(16) #1
	if owner.cFrame(41):
		owner.setFrame(17) #1
	if owner.cFrame(42):
		owner.setFrame(18) #1
	if owner.cFrame(43):
		owner.setFrame(19) #1
	if owner.cFrame(44):
		owner.setFrame(20) #1
	if owner.punchHit:
		if owner.cFrame(45):
			owner.spriteOffsets(7,1,21)
			owner.setFrame(0)
		if owner.cFrame(46): #2
			owner.setFrame(1)
		if owner.cFrame(48): # 2
			owner.setFrame(2)
		if owner.cFrame(52): # 2
			owner.setFrame(3)
		if owner.cFrame(56): #7
			owner.setFrame(4)
		if owner.cFrame(60): #7
			owner.setFrame(5)
		if owner.cFrame(70): #7
			Transitioned.emit(self, "wait")
	else:
		if owner.cFrame(45):
			owner.stun()
			owner.spriteOffsets(7,2,22)
			owner.setFrame(0) #1
		if owner.cFrame(46):
			owner.setFrame(1) #3
		if owner.cFrame(49):
			owner.setFrame(2) #4
		if owner.cFrame(53):
			owner.setFrame(3) #10
		if owner.cFrame(63):
			owner.setFrame(4) #4
		if owner.cFrame(67):
			owner.setFrame(5) #4
		if owner.cFrame(77):
			owner.setFrame(3) #10
		if owner.cFrame(81):
			owner.setFrame(4) #4
		if owner.cFrame(85):
			owner.setFrame(5) #4
		if owner.cFrame(89):
			owner.setFrame(6) #4
		if owner.cFrame(93):
			owner.setFrame(7) #4
		if owner.cFrame(97):
			owner.setFrame(8) #4
		if owner.cFrame(101):
			owner.setFrame(9) #4
		if owner.cFrame(105):
			owner.setFrame(10) #4
		if owner.cFrame(109):
			owner.stunned = false
			Transitioned.emit(self, "wait")
