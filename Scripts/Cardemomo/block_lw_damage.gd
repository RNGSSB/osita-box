extends State


func Exit():
	pass

func Enter():
	owner.setFrame(0)
	owner.counterPunch = false
	owner.spriteOffsets(7,1,1)
	owner.blockLeft = true
	owner.blockRight = true
	owner.blockUpLeft = false
	owner.blockUpRight = false

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(0) 
	if owner.cFrame(4):
		owner.setFrame(1) 
	if owner.cFrame(8):
		owner.setFrame(2) 
	if owner.cFrame(12):
		owner.setFrame(3) 
	if owner.cFrame(16):
		owner.setFrame(4) 
	if owner.cFrame(20):
		owner.setFrame(5) 
	if owner.cFrame(24):
		owner.setFrame(6) 
	if owner.cFrame(30):
		Transitioned.emit(self, "blocklw")
