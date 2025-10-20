extends State

func Exit():
	pass

func Enter():
	owner.ctrl = 1
	owner.animSys.animPlay("Wait")

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	pass
