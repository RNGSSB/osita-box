extends State


func Exit():
	owner.zoomCamera(0.2, 1.0)

func Enter():
	owner.animSys.animPlay("BlockLwDamage")
	owner.counterPunch = false
	owner.blockLeft = true
	owner.blockRight = true
	owner.blockUpLeft = false
	owner.blockUpRight = false
	owner.zoomCamera(0.6, 1.03)
	
	if owner.flipBlockLw:
		owner.flip_h = false
		if owner.playerPunch == 0:
			owner.animSys.animPlay("BlockLwDamageL")
		if owner.playerPunch == 1:
			owner.animSys.animPlay("BlockLwDamage")
	else:
		owner.animSys.animPlay("BlockLwDamage")
		if owner.playerPunch == 0:
			owner.flip_h = true
		if owner.playerPunch == 1:
			owner.flip_h = false

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(10):
		owner.zoomCamera(0.2, 1.0)
	if owner.animSys.animEnd:
		Transitioned.emit(self, "blocklw")
