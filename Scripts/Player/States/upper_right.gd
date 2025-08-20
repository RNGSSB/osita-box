extends State


func Exit():
	owner.ctrl = 1
	owner.punchHit = false

func Enter():
	owner.spriteOffsets(7,1,2)
	owner.ctrl = 0
	owner.setFrame(0)
	AudioManager.Play("res://SFX/Player/AttackSwoosh.wav", "Right", 1.0, 1.0)
	owner.bufferPunchR = false
	owner.bufferUp = false
	owner.flip_h = false

func Update(_delta: float):
	if owner.frameCounter >= 6:
		if Input.is_action_just_pressed("Up") and !owner.bufferUp:
			owner.upBuffer = owner.frameCounter
			owner.bufferUp = true

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.setFrame(0)
	if owner.cFrame(3):
		owner.setFrame(1)
	if owner.cFrame(4):
		owner.setFrame(2)
	if owner.cFrame(5):
		owner.punchOpponent(3)
		owner.setFrame(3)
	if owner.cFrame(6):
		owner.setFrame(4)
	if owner.cFrame(20):
		if owner.punchHit:
			owner.ctrl = 1
	if owner.cFrame(21):
		owner.setFrame(5)
	if owner.cFrame(23):
		owner.setFrame(6)
	if owner.cFrame(30):
		Transitioned.emit(self, "wait")
