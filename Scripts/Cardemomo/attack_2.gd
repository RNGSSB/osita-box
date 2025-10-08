extends State


func Exit():
	owner.isAttacking = false
	owner.attackMiss = false
	owner.punchHit = false
	owner.counterPunch = false

func Enter():
	owner.isAttacking = true
	owner.stunned = false
	owner.hitCount = 0
	owner.counterPunch = false
	owner.guardAll = false
	owner.hitLeft = false
	owner.hitRight = false
	owner.hitUpLeft = true
	owner.hitUpRight = false
	owner.Guard(true,true,true,true)
	owner.setFrame(0)
	owner.flip_h = false
	owner.spriteOffsets(7,3,14)

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(0) #3
	if owner.cFrame(4):
		owner.setFrame(1) #3
	if owner.cFrame(7):
		owner.Guard(true,true,false,true)
		owner.setFrame(2) #1
	if owner.cFrame(8):
		owner.setFrame(3) #1
	if owner.cFrame(9):
		owner.setFrame(4) #1
	if owner.cFrame(10):
		owner.setFrame(5) #1
	if owner.cFrame(11):
		owner.setFrame(6) #1
	if owner.cFrame(12):
		owner.setFrame(7) #1
	if owner.cFrame(13):
		owner.setFrame(8) #2
	if owner.cFrame(15):
		owner.setFrame(9) #2
	if owner.cFrame(17):
		owner.setFrame(10) #2
	if owner.cFrame(19):
		owner.setFrame(11) #2
	if owner.cFrame(21):
		owner.setFrame(12) #2
		owner.counterPunch = true
	if owner.cFrame(23):
		owner.setFrame(13) #2
	if owner.cFrame(25):
		owner.setFrame(14) #2
	if owner.cFrame(27):
		owner.setFrame(15) #2
	if owner.cFrame(29):
		owner.setFrame(16) #5
	if owner.cFrame(34):
		owner.counterPunch = false
		owner.setFrame(17) #5
	if owner.cFrame(39):
		owner.spriteOffsets(7,2,15)
		owner.Guard(false,false,false,false)
		owner.setFrame(0) #1
	if owner.cFrame(40):
		owner.spriteOffsets(7,2,15)
		owner.punchOpponent(3, 7.5, 6, true, 6, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 0, 190, 1, true, 2, 3, 4)
		owner.setFrame(1) #2
	if owner.punchHit:
		if owner.cFrame(42): # 2
			owner.setFrame(2)
		if owner.cFrame(44): # 2
			owner.setFrame(3)
		if owner.cFrame(46): #2
			owner.setFrame(4)
		if owner.cFrame(51): #5
			owner.setFrame(5)
		if owner.cFrame(56): #5
			owner.setFrame(6)
		if owner.cFrame(61): #5
			owner.setFrame(7)
		if owner.cFrame(66): #5
			owner.setFrame(8)
		if owner.cFrame(71): #5
			Transitioned.emit(self, "wait")
	else:
		if owner.cFrame(40):
			owner.stun()
			owner.spriteOffsets(7,2,16)
			owner.setFrame(1) #1
		if owner.cFrame(41):
			owner.setFrame(1) #2
		if owner.cFrame(43):
			owner.setFrame(2) #2
		if owner.cFrame(45):
			owner.setFrame(3) #2
		if owner.cFrame(47):
			owner.setFrame(4) #2
		if owner.cFrame(49):
			owner.setFrame(5) #2
		if owner.cFrame(51):
			owner.setFrame(6) #2
		if owner.cFrame(53):
			owner.setFrame(7) #10
		if owner.cFrame(63):
			owner.setFrame(5) #2
		if owner.cFrame(65):
			owner.setFrame(6) #2
		if owner.cFrame(67):
			owner.setFrame(7) #10
		if owner.cFrame(77):
			owner.setFrame(8) #5
		if owner.cFrame(82):
			owner.setFrame(9) #5
		if owner.cFrame(87):
			owner.setFrame(10) #5
		if owner.cFrame(92):
			owner.setFrame(11) #5
		if owner.cFrame(97):
			owner.stunned = false
			Transitioned.emit(self, "wait")
