extends State


func Exit():
	owner.punchHit = false
	owner.isAttacking = false
	owner.attackMiss = false
	owner.counterPunch = false

func Enter():
	owner.animSys.animPlay("Attack1Start")
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
	owner.flip_h = true

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
	if owner.cFrame(40):
		owner.punchOpponent(0, 12.5, 10, true, 8, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200,  15, true, 4, 1, 6)
	if owner.punchHit:
		if owner.cFrame(42):
			owner.animSys.animPlay("Attack1Hit")
		if owner.animSys.animEnd:
			Transitioned.emit(self, "wait")
	else:
		if owner.cFrame(42):
			owner.animSys.animPlay("Attack1Miss")
			owner.stun()
		if owner.cFrame(42):
			owner.stun()
		if owner.animSys.animEnd:
			owner.stunned = false
			Transitioned.emit(self, "wait")
