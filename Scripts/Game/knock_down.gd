extends State


func Exit():
	pass

func Enter():
	owner.pauseTimer = true

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	owner.readyText.visible = true
	if owner.stateFrame == 40:
		owner.readyText.text = "1"
	if owner.stateFrame == 80:
		owner.readyText.text = "2"
	if owner.stateFrame == 120:
		owner.readyText.text = "3"
	if owner.stateFrame == 160:
		owner.readyText.text = "4"
	if owner.stateFrame == 200:
		owner.readyText.text = "5"
	if owner.stateFrame == 240:
		owner.readyText.text = "6"
	if owner.stateFrame == 280:
		owner.readyText.text = "7"
	if owner.stateFrame == 320:
		owner.readyText.text = "8"
	if owner.stateFrame == 360:
		owner.readyText.text = "9"
	if owner.stateFrame == 400:
		owner.readyText.text = "10"
	if owner.stateFrame == 440:
		owner.readyText.text = "TKO!"
	if owner.stateFrame == 480:
		get_tree().reload_current_scene()
