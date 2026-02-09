extends State


func Exit():
	owner.punchHit = false
	owner.isAttacking = false
	owner.attackMiss = false
	owner.counterPunch = false

func Enter():
	owner.animSys.animPlay("Attack3Start")
	owner.isAttacking = true
	owner.stunned = false
	owner.hitCount = 0
	owner.counterPunch = false
	owner.guardAll = false
	owner.hitLeft = false
	owner.hitRight = false
	owner.hitUpLeft = false
	owner.hitUpRight = false
	owner.Guard(false,false,false,false)

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(5):
		AudioManager.Play("AttackSwoosh", "Left", 1.0, 1.0)
	if owner.cFrame(9):
		owner.hitLeft = true
	if owner.cFrame(17):
		owner.counterPunch = true
	if owner.cFrame(31):
		owner.counterPunch = false
	if owner.cFrame(39):
		pass
		owner.punchOpponent("Attack3")
	if owner.punchHit:
		if owner.cFrame(40):
			owner.animSys.animPlay("Attack3Hit")
		if owner.animSys.animEnd:
			Transitioned.emit(self, "wait")
	else:
		if owner.cFrame(40):
			owner.animSys.animPlay("Attack3Miss")
			owner.stun()
		if owner.cFrame(40):
			owner.stun()
		if owner.cFrame(94):
			owner.zoomCamera(0.2, 1.0)
		if owner.animSys.animEnd:
			owner.stunned = false
			owner.zoomCamera(0.2, 1.0)
			Transitioned.emit(self, "wait")
