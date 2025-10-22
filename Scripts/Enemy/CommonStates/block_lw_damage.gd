extends State


func Exit():
	pass

func Enter():
	owner.animSys.animPlay("BlockLwDamage")
	owner.counterPunch = false
	owner.blockLeft = true
	owner.blockRight = true
	owner.blockUpLeft = false
	owner.blockUpRight = false

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.animSys.animEnd:
		Transitioned.emit(self, "blocklw")
