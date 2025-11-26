extends State


func Exit():
	owner.isAttacking = false
	owner.attackMiss = false
	owner.punchHit = false
	owner.counterPunch = false

func Enter():
	owner.animSys.animPlay("Attack2Start")
	owner.isAttacking = true
	owner.stunned = false
	owner.hitCount = 0
	owner.counterPunch = false
	owner.guardAll = false
	owner.hitLeft = false
	owner.hitRight = false
	owner.hitUpLeft = true
	owner.hitUpRight = false
	owner.Guard(true,true,true,true)
	owner.flip_h = false

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(7):
		owner.Guard(true,true,false,true)
	if owner.cFrame(21):
		owner.counterPunch = true
	if owner.cFrame(34):
		owner.counterPunch = false
	if owner.cFrame(39):
		owner.animSys.animPlay("Attack2Hit")
		owner.Guard(false,false,false,false)
	if owner.cFrame(39):
		#Hit
		owner.punchOpponent(3, 7.5, 6, true, 6, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 0, 190, 1, true, 2, 3, 4)
	if owner.punchHit:
		if owner.animSys.animEnd: #5
			Transitioned.emit(self, "wait")
	else:
		if owner.cFrame(39):
			owner.animSys.animPlay("Attack2Miss")
			owner.stun()
		if owner.animSys.animEnd:
			owner.stunned = false
			Transitioned.emit(self, "wait")
