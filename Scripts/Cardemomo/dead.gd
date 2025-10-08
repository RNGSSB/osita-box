extends State


func Exit():
	owner.position.x = 0

func Enter():
	owner.spriteOffsets(7,3,23)
	owner.position.x = 400
	owner.flip_h = false
	owner.setFrame(0)
	owner.hitLeft = false
	owner.hitRight = false
	owner.hitUpLeft = false
	owner.hitUpRight = false
	owner.blockLeft = false
	owner.blockRight = false
	owner.blockUpLeft = false
	owner.blockUpRight = false
	owner.guardAll = false

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	owner.guardAll = false
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
		owner.setFrame(5) #3
	if owner.cFrame(14):
		owner.setFrame(6) #3
	if owner.cFrame(17):
		owner.setFrame(7) #2
	if owner.cFrame(19):
		owner.setFrame(8) #2
	if owner.cFrame(21):
		owner.setFrame(9) #2
	if owner.cFrame(23):
		owner.setFrame(10) #4
	if owner.cFrame(27):
		owner.setFrame(11) #3
	if owner.cFrame(30):
		owner.setFrame(12) #2
	if owner.cFrame(32):
		owner.setFrame(13) #2
	if owner.cFrame(34):
		owner.setFrame(14) #2
	if owner.cFrame(36):
		owner.setFrame(15) #2
	if owner.cFrame(38):
		owner.setFrame(16) #2
