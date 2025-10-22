extends State

var idleLoop = 0

func Exit():
	idleLoop = 0

func Enter():
	owner.animSys.animPlay("Wait")
	owner.flip_h = false
	owner.hitLeft = true
	owner.hitRight = true
	owner.hitUpLeft = true
	owner.hitUpRight = true
	owner.blockLeft = false
	owner.blockRight = false
	owner.blockUpLeft = false
	owner.blockUpRight = false
	owner.damaged = false
	owner.attackMiss = false
	owner.hitCount = 0
	owner.maxHitCount = owner.normalCombo
	idleLoop = 0

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	
	if owner.cFrame(20):
		owner.guardAll = false
