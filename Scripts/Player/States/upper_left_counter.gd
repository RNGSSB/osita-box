extends State


func Exit():
	owner.ctrl = 1
	owner.punchHit = false
	owner.punchBlock = false
	owner.makerHerVisible = false

func Enter():
	owner.spriteOffsets(7,2,5)
	owner.ctrl = 0
	owner.setFrame(4)
	owner.punchOpponent(2, owner.counterDamage, owner.counterMeterGain, true, "Left", "Damage4", 1.0, 1.35, 
	"DamageHi4", true, 3.0, 3.0, "HITCOUNTER", 150, -240, 3.0, 3.0)
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
		owner.setFrame(4)
	if owner.cFrame(6):
		owner.setFrame(5)
	if owner.cFrame(7):
		owner.setFrame(6)
	if owner.cFrame(8):
		owner.setFrame(7)
	if owner.cFrame(11):
		owner.ctrl = 1
		owner.setFrame(8)
	if owner.cFrame(17):
		owner.setFrame(9)
	if owner.cFrame(22):
		owner.setFrame(10)
	if owner.cFrame(28):
		Transitioned.emit(self, "wait")
