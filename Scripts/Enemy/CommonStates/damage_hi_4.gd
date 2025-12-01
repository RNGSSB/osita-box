extends State


func Exit():
	owner.damaged = false

func Enter():
	owner.hitLeft = false
	owner.hitRight = false
	owner.hitUpLeft = false
	owner.hitUpRight = false
	owner.counterPunch = false
	owner.guardAll = true
	owner.hitCount = 0
	owner.stunned = false
	owner.damaged = true
	AudioManager.Stop("Dizzy")
	if owner.flipDamageHi:
		owner.flip_h = false
		if owner.playerPunch == 2:
			owner.animSys.animPlay("DamageHi4L")
		if owner.playerPunch == 3:
			owner.animSys.animPlay("DamageHi4")
	else:
		owner.animSys.animPlay("DamageHi4")
		if owner.playerPunch == 2:
			owner.flip_h = true
		if owner.playerPunch == 3:
			owner.flip_h = false

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
