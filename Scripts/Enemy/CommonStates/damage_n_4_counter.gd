extends State


func Exit():
	owner.damaged = false

func Enter():
	owner.hitLeft = false
	owner.hitRight = false
	owner.hitUpLeft = false
	owner.hitUpRight = false
	owner.counterPunch = false
	owner.stunned = false
	owner.damaged = true
	owner.guardAll = true
	if owner.health <= 0:
		owner.moveCamera(0.5, 30)
	owner.hitCount = 0
	if owner.flipDamageCounterLw:
		owner.flip_h = false
		if owner.playerPunch == 0:
			owner.animSys.animPlay("DamageN4CounterL")
		if owner.playerPunch == 1:
			owner.animSys.animPlay("DamageN4Counter")
	else:
		owner.animSys.animPlay("DamageN4Counter")
		if owner.playerPunch == 0:
			owner.flip_h = true
		if owner.playerPunch == 1:
			owner.flip_h = false
	AudioManager.Stop("Dizzy")

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(2):
		if owner.health == 0:
			Transitioned.emit(self, "dead")
	if owner.animSys.animEnd:
		Transitioned.emit(self, "wait")
