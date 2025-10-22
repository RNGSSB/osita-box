extends State

var idleLoop = 0

func Exit():
	idleLoop = 0
	Gamemanager.destroyEffect("DIZZY")

func Enter():
	Gamemanager.createEffects("DIZZY", 1.0, 1.0, 0, -335)
	owner.animSys.animPlay("DizzyLw")
	owner.dizzy = owner.dizzyTime

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	owner.dizzy -= 1
	
	if owner.dizzy <= 0:
		owner.hitLeft = false
		owner.hitRight = false
		owner.hitUpLeft = false
		owner.hitUpRight = false
		owner.animSys.animPlay("DizzyLwEnd")
		Transitioned.emit(self, "dizzyend")
