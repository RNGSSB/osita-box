extends State


func Exit():
	owner.zoomCamera(0.2, 1.0)

func Enter():
	owner.counterPunch = false
	owner.zoomCamera(0.6, 1.03)

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(10):
		owner.zoomCamera(0.2, 1.0)
	if owner.animSys.animEnd:
		if owner.animSys.CURRANIM == "BlockLwDamageL":
			owner.animSys.animPlay("BlockLwL")
		elif owner.animSys.CURRANIM == "BlockLwDamage":
			owner.animSys.animPlay("BlockLw")
		elif owner.animSys.CURRANIM == "BlockHiDamageL":
			owner.animSys.animPlay("BlockHiL")
		elif owner.animSys.CURRANIM == "BlockHiDamage":
			owner.animSys.animPlay("BlockHi")
		Transitioned.emit(self, "block")
