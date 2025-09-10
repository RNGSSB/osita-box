extends State


func Exit():
	owner.ctrl = 1
	owner.punchHit = false
	owner.punchBlock = false
	owner.makerHerVisible = false

func Enter():
	owner.spriteOffsets(7,2,3)
	owner.ctrl = 0
	owner.setFrame(0)
	owner.makerHerVisible = true
	AudioManager.Play("Attack4Swoosh", "Left", 1.0, 1.0)
	owner.bufferPunchL = false
	owner.bufferUp = false
	owner.flip_h = true

func Update(_delta: float):
	if owner.frameCounter >= 6:
		if Input.is_action_just_pressed("Up") and !owner.bufferUp:
			owner.upBuffer = owner.frameCounter
			owner.bufferUp = true

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
		owner.punchOpponent(0)
		owner.setFrame(4)
	if owner.cFrame(10):
		owner.setFrame(5)
	if owner.cFrame(11):
		owner.setFrame(6)
	if owner.cFrame(12):
		owner.setFrame(7)
	if owner.cFrame(23):
		owner.ctrl = 1
		owner.setFrame(8)
	if owner.cFrame(29):
		owner.setFrame(9)
	if owner.cFrame(34):
		owner.setFrame(10)
	if owner.cFrame(40):
		Transitioned.emit(self, "wait")
