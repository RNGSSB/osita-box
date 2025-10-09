extends State


func Exit():
	owner.ctrl = 1
	owner.punchHit = false
	owner.punchBlock = false
	owner.makerHerVisible = false
	owner.hasCombo = false

func Enter():
	owner.spriteOffsets(7,2,5)
	owner.ctrl = 0
	owner.setFrame(0)
	owner.makerHerVisible = true
	AudioManager.Play("Attack4Swoosh", "Right", 1.0, 1.0)
	owner.bufferPunchR = false
	owner.bufferUp = false
	owner.flip_h = false

func Update(_delta: float):
	if owner.frameCounter >= 6:
		if Gamemanager.checkInputJustPressed("Up") and !owner.bufferUp:
			owner.upBuffer = owner.frameCounter
			owner.bufferUp = true

func Physics_Update(delta: float):
	if owner.cFrame(1):
		owner.makerHerVisible = true
		owner.setFrame(0)
	if owner.cFrame(2):
		owner.setFrame(1)
	if owner.cFrame(2):
		owner.setFrame(2)
	if owner.cFrame(3):
		owner.setFrame(3)
	if owner.cFrame(5):
		owner.punchOpponent(3, owner.finishDamage, owner.finishMeterGain, false, "Right", "Damage4", 1.0, 1.35, 
		"DamageHi4", true, 4.0, 4.0, "HITFINISHER", -150, -240, 3.0, 3.0)
		owner.setFrame(4)
	if owner.cFrame(10):
		owner.setFrame(5)
	if owner.cFrame(11):
		owner.setFrame(6)
	if owner.cFrame(12):
		owner.setFrame(7)
	if owner.cFrame(23):
		owner.setFrame(8)
	if owner.cFrame(29):
		owner.setFrame(9)
	if owner.cFrame(34):
		owner.setFrame(10)
	if owner.cFrame(40):
		Transitioned.emit(self, "wait")
