extends State


func Exit():
	pass

func Enter():
	owner.round += 1

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	Transitioned.emit(self, "Intro")
