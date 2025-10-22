extends State


func Exit():
	owner.position.x = 0

func Enter():
	owner.animSys.animPlay("Dead")
	owner.flip_h = false
	owner.hitLeft = false
	owner.hitRight = false
	owner.hitUpLeft = false
	owner.hitUpRight = false
	owner.blockLeft = false
	owner.blockRight = false
	owner.blockUpLeft = false
	owner.blockUpRight = false
	owner.guardAll = false

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	owner.guardAll = false
	if owner.cFrame(13):
		owner.moveCamera(0.2, 105)
