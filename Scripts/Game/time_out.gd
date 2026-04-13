extends State


func Exit():
	pass

func Enter():
	owner.roundCount += 1

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	Transitioned.emit(self, "Intro")
