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
	owner.Guard(true,true,true,true)
	owner.flip_h = false

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(7):
		owner.Guard(false,false,false,false)
		owner.hitUpRight = true
	if owner.cFrame(20):
		owner.counterPunch = true
	if owner.cFrame(33):
		owner.counterPunch = false
	if owner.cFrame(39):
		owner.punchOpponent("Attack4H1")
	if owner.cFrame(40):
		owner.punchOpponent("Attack4H2")
	if owner.cFrame(41):
		owner.punchOpponent("Attack4H3")
	if owner.cFrame(42):
		owner.punchOpponent("Attack4H4")
	if owner.cFrame(43):
		owner.punchOpponent("Attack4H5")
	if owner.cFrame(44):
		owner.punchOpponent("Attack4H6")
	if owner.punchHit:
		if owner.cFrame(45):
			owner.animSys.animPlay("Attack4Hit")
		if owner.animSys.animEnd: #7
			Transitioned.emit(self, "wait")
	else:
		if owner.cFrame(45):
			owner.animSys.animPlay("Attack4Miss")
			owner.stun()
		if owner.cFrame(102):
			owner.zoomCamera(0.2, 1.0)
		if owner.animSys.animEnd:
			owner.stunned = false
			owner.zoomCamera(0.2, 1.0)
			Transitioned.emit(self, "wait")
