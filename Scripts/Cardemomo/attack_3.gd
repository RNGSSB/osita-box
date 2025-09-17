extends State


func Exit():
	owner.punchHit = false

func Enter():
	owner.stunned = false
	owner.hitCount = 0
	owner.counterPunch = false
	owner.hitLeft = true
	owner.hitRight = false
	owner.hitUpLeft = false
	owner.hitUpRight = false
	owner.Guard(true,true,true,true)
	owner.setFrame(0)
	owner.flip_h = true
	owner.spriteOffsets(7,3,9)

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(0) #2
	if owner.cFrame(3):
		owner.setFrame(1) #2
	if owner.cFrame(5):
		AudioManager.Play("AttackSwoosh", "Left", 1.0, 1.0)
		owner.setFrame(2) #1
	if owner.cFrame(6):
		owner.setFrame(3) #1
	if owner.cFrame(7):
		owner.setFrame(4) #1
	if owner.cFrame(8):
		
		owner.setFrame(5) #1
	if owner.cFrame(9):
		owner.Guard(false,false,false,false)
		owner.counterPunch = true
		owner.setFrame(6) #4
	if owner.cFrame(13):
		owner.setFrame(7) #4
	if owner.cFrame(17):
		owner.setFrame(8) #4
	if owner.cFrame(21):
		owner.setFrame(9) #2
	if owner.cFrame(23):
		owner.setFrame(10) #2
	if owner.cFrame(25):
		owner.setFrame(11) #2
	if owner.cFrame(27):
		owner.setFrame(12) #2
	if owner.cFrame(29):
		owner.setFrame(13) #2
	if owner.cFrame(31):
		owner.setFrame(14) #4
	if owner.cFrame(35):
		owner.setFrame(15) #1
	if owner.cFrame(36):
		owner.setFrame(16) #2
	if owner.cFrame(38):
		owner.setFrame(17) #2
	if owner.cFrame(40):
		owner.counterPunch = false
		owner.punchOpponent(0, 10, 15, true, 3, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200, 20)
		owner.setFrame(18) #2
	if owner.punchHit:
		if owner.cFrame(42):
			owner.spriteOffsets(7,1,10)
			owner.setFrame(0)
		if owner.cFrame(44): #2
			owner.setFrame(1)
		if owner.cFrame(46): # 2
			owner.setFrame(2)
		if owner.cFrame(48): # 2
			owner.setFrame(3)
		if owner.cFrame(55): #7
			owner.setFrame(4)
		if owner.cFrame(62): #7
			owner.setFrame(5)
		if owner.cFrame(69): #7
			owner.setFrame(6)
		if owner.cFrame(76): #7
			Transitioned.emit(self, "wait")
	else:
		if owner.cFrame(42):
			owner.stun()
			owner.spriteOffsets(7,3,11)
			owner.setFrame(0) #2
		if owner.cFrame(42):
			owner.stun()
		if owner.cFrame(44):
			owner.setFrame(1) #1
		if owner.cFrame(45):
			owner.setFrame(2) #1
		if owner.cFrame(46):
			owner.setFrame(3) #1
		if owner.cFrame(47):
			owner.setFrame(4) #1
		if owner.cFrame(48):
			owner.setFrame(5) #1
		if owner.cFrame(49):
			owner.setFrame(6) #1
		if owner.cFrame(50):
			owner.setFrame(7) #2
		if owner.cFrame(52):
			owner.setFrame(8) #2
		if owner.cFrame(54):
			owner.setFrame(9) #1
		if owner.cFrame(55):
			owner.setFrame(10) #6
		if owner.cFrame(61):
			owner.setFrame(11) #6
		if owner.cFrame(67):
			owner.setFrame(12) #6
		if owner.cFrame(73):
			owner.setFrame(13) #6
		if owner.cFrame(80):
			owner.setFrame(14) #6
		if owner.cFrame(86):
			owner.setFrame(15) #6
		if owner.cFrame(92):
			owner.setFrame(16) #3
		if owner.cFrame(95):
			owner.setFrame(17) #3
		if owner.cFrame(98):
			owner.setFrame(18) #3
		if owner.cFrame(101):
			owner.setFrame(19) #3
		if owner.cFrame(104):
			owner.setFrame(20) #3
		if owner.cFrame(107):
			owner.stunned = false
			Transitioned.emit(self, "wait")
