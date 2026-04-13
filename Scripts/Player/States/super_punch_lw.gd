extends State


func Exit():
	owner.ctrl = 1
	owner.makerHerVisible = false
	owner.hasCombo = false
	owner.punchHit = false
	owner.canDodge = true
	owner.canBlock = true
	owner.isSuper = false

func Enter():
	owner.ctrl = 0
	owner.animSys.animPlay("SuperPunchLow")
	owner.makerHerVisible = true
	owner.moveCamera(0.2, -105)
	#owner.gameManager.hitLag(0,10)
	owner.bufferSuper = false
	owner.bufferUp = false
	owner.dodgeRight = false
	owner.dodgeDown = false
	owner.dodgeLeft = true
	owner.superMeter -= owner.superCost
	owner.isSuper = true
	#AudioManager.Play("SuperStart", "SFX", 1.0, 1.0)
	owner.flip_h = true
	if owner.PREVSTATE == "PunchRight" or owner.PREVSTATE == "PunchLeft" or owner.PREVSTATE == "UpperRight" or owner.PREVSTATE == "UpperLeft":
		owner.animSys.setFrame(9)

func Update(_delta: float):
	if owner.frameCounter >= 6:
		if Gamemanager.checkInputJustPressed("Up") and !owner.bufferUp:
			owner.upBuffer = owner.frameCounter
			owner.bufferUp = true

func Physics_Update(_delta: float):
	if owner.cFrame(8):
		owner.dodgeLeft = false
	if owner.cFrame(24):
		AudioManager.Play("Attack4Swoosh", "Left", 1.0, 1.0)
		owner.moveCamera(0.2, 0)
	#if owner.cFrame(21):
		#owner.punchOpponent(4, owner.superDamage, 2, false, "SFX", "SuperHit", 1.0, 1.0, 
		#"DamageN4", false, 6.0, 4.0, "HITFINISHER", -200, 60, 3.0, 3.0)
	if owner.cFrame(37):
		owner.punchOpponent("SuperPunchLwL")
	if owner.cFrame(60):
		owner.makerHerVisible = false
	if owner.animSys.animEnd and owner.animSys.CURRANIM == "SuperPunchLow":
		owner.animSys.animPlay("SuperPunchLowHit")
	if owner.animSys.animEnd and owner.animSys.CURRANIM == "SuperPunchLowHit":
		Transitioned.emit(self, "wait")
