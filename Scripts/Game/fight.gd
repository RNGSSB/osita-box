extends State


func Exit():
	pass

func Enter():
	owner.pauseTimer = false
	owner.readyText.text = "FIGHT!"

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.stateFrame < 30:
		owner.readyText.visible = true
	if owner.stateFrame == 30:
		owner.readyText.visible = false
	if owner.enemy.CURRSTATE == "Dead":
		Transitioned.emit(self, "KnockDown")
	if owner.player.CURRSTATE == "Dead":
		Transitioned.emit(self, "KnockDown")
	if owner.roundTimer <= 0:
		Transitioned.emit(self, "TimeOut")
