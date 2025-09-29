extends State


func Exit():
	owner.ctrl = 1
	owner.dodgeSuccess = false
	owner.perfectDodge = false
	owner.dodgeRight = false
	owner.makerHerVisible = false

func Enter():
	owner.ctrl = 0
	owner.spriteOffsets(7,3,6)
	owner.setFrame(0)
	AudioManager.Play("Escape", "Right", 1.0, 1.0)
	owner.makerHerVisible = true
	owner.flip_h = true
	owner.dodgeRight = true
	owner.dodgeDown = false
	owner.dodgeLeft = false
	owner.bufferDodgeR = false

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.makerHerVisible = true
		owner.setFrame(0)
	if owner.cFrame(2):
		owner.setFrame(1)
	if owner.cFrame(3):
		owner.setFrame(2)
	if owner.cFrame(4):
		owner.setFrame(3)
	if owner.cFrame(5):
		owner.setFrame(4)
	if owner.cFrame(6):
		owner.setFrame(5)
	if owner.cFrame(7):
		owner.makerHerVisible = false
		owner.setFrame(6)
	if owner.cFrame(8):
		owner.setFrame(7)
	if owner.cFrame(9):
		owner.setFrame(8)
	if owner.cFrame(10):
		owner.setFrame(9)
	if owner.cFrame(11):
		owner.setFrame(10)
	if owner.cFrame(12):
		owner.setFrame(11)
	if owner.cFrame(13):
		owner.setFrame(12)
	if owner.cFrame(14):
		owner.setFrame(13) #2
	if owner.cFrame(16):
		owner.dodgeRight = false
		owner.setFrame(14) #1
	if owner.cFrame(17):
		owner.setFrame(15) #1
	if owner.cFrame(18):
		owner.setFrame(16) #3
	if owner.cFrame(20):
		if owner.dodgeSuccess:
			owner.ctrl = 1
	if owner.cFrame(21):
		owner.setFrame(17) #3
	if owner.cFrame(24):
		owner.setFrame(18) #4
	if owner.cFrame(28):
		owner.setFrame(19) #5
	if owner.cFrame(31):
		owner.ctrl = 1
	if owner.cFrame(33):
		owner.setFrame(20) #6
	if owner.cFrame(39):
		Transitioned.emit(self, "wait")
