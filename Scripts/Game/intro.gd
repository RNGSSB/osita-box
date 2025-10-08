extends State


func Exit():
	owner.player.ctrl = 1
	owner.enemy.aiActive = true

func Enter():
	owner.pauseTimer = true
	owner.roundTimer = 3600.0
	owner.secondTimer = 3600.0

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	owner.readyText.visible = true
	if owner.stateFrame == 2:
		owner.readyText.text = "3"
	if owner.stateFrame == 30:
		owner.readyText.text = "2"
	if owner.stateFrame == 60:
		owner.readyText.text = "1"
	owner.player.ctrl = 0
	owner.enemy.aiActive = false
	if owner.stateFrame == 90:
		Transitioned.emit(self, "fight")
