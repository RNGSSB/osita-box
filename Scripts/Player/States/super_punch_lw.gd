extends State


func Exit():
	owner.ctrl = 1
	owner.makerHerVisible = false
	owner.hasCombo = false
	owner.punchHit = false

func Enter():
	owner.ctrl = 0
	owner.animSys.animPlay("SuperPunchLow")
	owner.makerHerVisible = true
	owner.gameManager.hitLag(0,10)
	owner.bufferSuper = false
	owner.bufferUp = false
	AudioManager.Play("SuperStart", "SFX", 1.0, 1.0)
	owner.flip_h = false

func Update(_delta: float):
	if owner.frameCounter >= 6:
		if Gamemanager.checkInputJustPressed("Up") and !owner.bufferUp:
			owner.upBuffer = owner.frameCounter
			owner.bufferUp = true

func Physics_Update(_delta: float):
	if owner.cFrame(18):
		AudioManager.Play("Attack4Swoosh", "Left", 1.0, 1.0)
	if owner.cFrame(21):
		owner.punchOpponent(4, owner.superDamage, 2, false, "SFX", "SuperHit", 1.0, 1.0, 
		"DamageN4", false, 6.0, 4.0, "HITFINISHER", -200, 60, 3.0, 3.0)
	if owner.cFrame(22):
		owner.makerHerVisible = false
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
