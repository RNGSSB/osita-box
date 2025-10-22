extends State
var idleLoop = 0

func Exit():
	idleLoop = 0

func Enter():
	owner.animSys.animPlay("BlockHi")
	owner.counterPunch = false
	owner.attackMiss = false
	owner.damaged = false
	owner.blockLeft = false
	owner.blockRight = false
	owner.blockUpLeft = true
	owner.blockUpRight = true

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.cFrame(20):
		owner.guardAll = false
