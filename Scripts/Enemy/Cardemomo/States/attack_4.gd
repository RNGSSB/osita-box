extends State


func Exit():
	owner.punchHit = false
	owner.attackMiss = false
	owner.isAttacking = false
	owner.counterPunch = false

func Enter():
	owner.animSys.animPlay("Attack4Start")
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
	owner.flip_h = false

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(13):
		owner.hitRight = true
	if owner.cFrame(20):
		owner.counterPunch = true
	if owner.cFrame(33):
		owner.counterPunch = false
	if owner.cFrame(34):
		owner.punchOpponent(2, 20, 20, true, 12, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200, 34, true, 6, 1, 9, true, false, false, false)
	if owner.cFrame(35):
		owner.punchOpponent(2, 20, 20, true, 12, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200, 34, true, 6, 1, 9,  true, false, false, false)
	if owner.cFrame(36):
		owner.punchOpponent(2, 20, 20, true, 12, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200, 34, true, 6, 1, 9,  true, true, false, true)
	if owner.cFrame(37):
		owner.punchOpponent(2, 20, 20, true, 12, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200, 34, true, 6, 1, 9,  true, true, false, true)
	if owner.cFrame(38):
		owner.punchOpponent(2, 20, 20, true, 12, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200, 34, true, 6, 1, 9,  true, true, true, true, "DamageS", 250, true)
	if owner.cFrame(39):
		owner.punchOpponent(2, 20, 20, true, 12, 25, 
		"Hurt", 1.0, 1.0, "HIT", 3.0, 3.0, 200, 200, 34, true, 6, 1, 9, true, true, true, true, "DamageS", 250, true)
	if owner.punchHit:
		if owner.cFrame(45):
			owner.animSys.animPlay("Attack4Hit")
		if owner.animSys.animEnd: #7
			Transitioned.emit(self, "wait")
	else:
		if owner.cFrame(45):
			owner.animSys.animPlay("Attack4Miss")
			owner.stun()
		if owner.animSys.animEnd:
			owner.stunned = false
			Transitioned.emit(self, "wait")
