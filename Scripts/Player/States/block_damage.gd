extends State


func Exit():
	owner.ctrl = 1
	owner.makerHerVisible = false

func Enter():
	owner.spriteOffsets(7,2,10)
	owner.ctrl = 0
	owner.setFrame(5)
	owner.makerHerVisible = true

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(5)
	if owner.cFrame(2):
		owner.setFrame(6)
	if owner.cFrame(4):
		owner.setFrame(7)
	if owner.cFrame(6):
		owner.setFrame(8)
	if owner.cFrame(8):
		owner.setFrame(9)
	if owner.cFrame(10):
		owner.setFrame(10)
		owner.makerHerVisible = false
	if owner.cFrame(12):
		owner.setFrame(11)
	if owner.cFrame(14):
		owner.setFrame(12)
	if owner.cFrame(16):
		owner.setFrame(13)
	if owner.cFrame(18):
		Transitioned.emit(self, "wait")
