extends State


func Exit():
	owner.ctrl = 1
	owner.dodgeSuccess = false
	owner.perfectDodge = false
	owner.dodgeLeft = false
	owner.makerHerVisible = false

func Enter():
	owner.ctrl = 0
	owner.spriteOffsets(7,4,6)
	owner.setFrame(0)
	owner.makerHerVisible = true
	AudioManager.Play("Escape", "Left", 1.0, 1.0)
	owner.flip_h = false
	owner.dodgeRight = false
	owner.dodgeDown = false
	owner.dodgeLeft = true
	owner.bufferDodgeL = false

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
		owner.setFrame(13)
	if owner.cFrame(15):
		owner.dodgeLeft = false
		owner.setFrame(14)
	if owner.cFrame(16):
		owner.setFrame(15)
	if owner.cFrame(17):
		owner.setFrame(16)
	if owner.cFrame(18):
		owner.setFrame(17)
	if owner.cFrame(19):
		owner.setFrame(18)
	if owner.cFrame(20):
		if owner.dodgeSuccess:
			owner.ctrl = 1
		owner.setFrame(19)
	if owner.cFrame(23):
		owner.setFrame(20)
	if owner.cFrame(26):
		owner.setFrame(21)
	if owner.cFrame(29):
		owner.setFrame(22)
	if owner.cFrame(31):
		owner.ctrl = 1
	if owner.cFrame(33):
		owner.setFrame(24)
	if owner.cFrame(36):
		Transitioned.emit(self, "wait")
