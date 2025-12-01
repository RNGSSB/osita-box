extends State

var idleLoop = 0

func Exit():
	idleLoop = 0

func Enter():
	owner.animSys.animPlay("BlockLw")
	owner.counterPunch = false
	owner.attackMiss = false
	owner.damaged = false
	idleLoop = 0
	owner.blockLeft = true
	owner.blockRight = true
	owner.blockUpLeft = false
	owner.blockUpRight = false

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(20):
		owner.guardAll = false
