extends State


func Exit():
	owner.damaged = false

func Enter():
	owner.hitLeft = true
	owner.hitRight = true
	owner.hitUpLeft = true
	owner.hitUpRight = true
	owner.damaged = true
	
	AudioManager.Stop("Dizzy")

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.cFrame(25):
		if owner.stunned:
			AudioManager.Play("Dizzy", "SFX", 1.0, 1.0) 
	if owner.animSys.animEnd:
		if owner.stunned and owner.dizzyAnim != "None":
			Transitioned.emit(self, "dizzy")
		else:
			Transitioned.emit(self, "wait")
