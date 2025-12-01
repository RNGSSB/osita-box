extends State


func Exit():
	owner.damaged = false

func Enter():
	owner.hitLeft = true
	owner.hitRight = true
	owner.hitUpLeft = true
	owner.hitUpRight = true
	owner.damaged = true
	if owner.flipDamageLw:
		owner.flip_h = false
		if owner.playerPunch == 0:
			owner.animSys.animPlay("DamageNL")
		if owner.playerPunch == 1:
			owner.animSys.animPlay("DamageN")
	else:
		owner.animSys.animPlay("DamageN")
		if owner.playerPunch == 0:
			owner.flip_h = true
		if owner.playerPunch == 1:
			owner.flip_h = false
	AudioManager.Stop("Dizzy")

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(30):
		if owner.stunned:
			AudioManager.Play("Dizzy", "SFX", 1.0, 1.0) 
	if owner.animSys.animEnd:
		if owner.stunned:
			Transitioned.emit(self, "dizzylw")
		else:
			Transitioned.emit(self, "wait")
