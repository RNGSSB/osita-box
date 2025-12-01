extends State


func Exit():
	owner.damaged = false

func Enter():
	owner.hitLeft = true
	owner.hitRight = true
	owner.hitUpLeft = true
	owner.hitUpRight = true
	owner.damaged = true
	AudioManager.Stop("Dizzy")
	if owner.flipDamageHi:
		owner.flip_h = false
		if owner.playerPunch == 2:
			owner.animSys.animPlay("DamageHiL")
		if owner.playerPunch == 3:
			owner.animSys.animPlay("DamageHi")
	else:
		owner.animSys.animPlay("DamageHi")
		if owner.playerPunch == 2:
			owner.flip_h = true
		if owner.playerPunch == 3:
			owner.flip_h = false

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(30):
		if owner.stunned:
			AudioManager.Play("Dizzy", "SFX", 1.0, 1.0)
	if owner.animSys.animEnd:
		if owner.stunned:
			Transitioned.emit(self, "dizzyhi")
		else:
			Transitioned.emit(self, "wait")
