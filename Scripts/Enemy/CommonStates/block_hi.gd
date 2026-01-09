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
	
	if owner.flipBlockHi:
		owner.flip_h = false
		if owner.playerPunch == 2:
			owner.animSys.animPlay("BlockHiL")
		if owner.playerPunch == 3:
			owner.animSys.animPlay("BlockHi")
	else:
		owner.animSys.animPlay("BlockHi")
		if owner.playerPunch == 2:
			owner.flip_h = true
		if owner.playerPunch == 3:
			owner.flip_h = false

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(20):
		owner.guardAll = false
