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
	
	if owner.flipBlockHi:
		owner.flip_h = false
		if owner.playerPunch == 2:
			owner.animSys.animPlay("BlockHiDamageL")
		if owner.playerPunch == 3:
			owner.animSys.animPlay("BlockHiDamage")
	else:
		owner.animSys.animPlay("BlockHiDamage")
		if owner.playerPunch == 2:
			owner.flip_h = true
		if owner.playerPunch == 3:
			owner.flip_h = false

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.animSys.animEnd:
		Transitioned.emit(self, "blockhi")
