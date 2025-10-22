extends State


func Exit():
	pass

func Enter():
	owner.animSys.animPlay("BlockHiDamage")
	owner.counterPunch = false
	owner.blockLeft = false
	owner.blockRight = false
	owner.blockUpLeft = true
	owner.blockUpRight = true

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.animSys.animEnd:
		Transitioned.emit(self, "blockhi")
