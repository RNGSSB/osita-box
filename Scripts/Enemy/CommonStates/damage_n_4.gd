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
	owner.damaged = true
	owner.stunned = false
	if owner.health <= 0:
		owner.moveCamera(1, 60)
	if owner.flipDamageLw:
		owner.flip_h = false
		if owner.playerPunch == 0:
			owner.animSys.animPlay("DamageN4L")
		if owner.playerPunch == 1:
			owner.animSys.animPlay("DamageN4")
		if owner.playerPunch == 4:
			owner.animSys.animPlay("DamageN4")
	else:
		owner.animSys.animPlay("DamageN4")
		if owner.playerPunch == 0:
			owner.flip_h = true
		if owner.playerPunch == 1:
			owner.flip_h = false
	owner.hitCount = 0
	AudioManager.Stop("Dizzy")

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(2):
		if owner.health == 0:
			owner.flip_h = false
			Transitioned.emit(self, "dead")
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
