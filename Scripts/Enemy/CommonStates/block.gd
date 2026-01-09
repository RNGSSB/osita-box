extends State

var idleLoop = 0

func Exit():
	idleLoop = 0

func Enter():
	owner.counterPunch = false
	owner.attackMiss = false
	owner.damaged = false
	idleLoop = 0
	owner.blockLeft = true
	owner.blockRight = true
	owner.blockUpLeft = false
	owner.blockUpRight = false
	
	if owner.flipBlockLw:
		owner.flip_h = false
		if owner.playerPunch == 0:
			owner.animSys.animPlay("BlockLwL")
		if owner.playerPunch == 1:
			owner.animSys.animPlay("BlockLw")
	else:
		owner.animSys.animPlay("BlockLw")
		if owner.playerPunch == 0:
			owner.flip_h = true
		if owner.playerPunch == 1:
			owner.flip_h = false

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(20):
		owner.guardAll = false
