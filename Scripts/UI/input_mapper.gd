extends CanvasLayer


@export var controller : VBoxContainer
@export var keyboard : VBoxContainer
@export var controller2 : VBoxContainer
@export var keyboard2 : VBoxContainer

@onready var controllerUp = $PanelContainer/VBoxContainer/HBoxContainer2/Controller/Up
@onready var controllerDown = $PanelContainer/VBoxContainer/HBoxContainer2/Controller/Down
@onready var controllerLeft = $PanelContainer/VBoxContainer/HBoxContainer2/Controller/Left
@onready var controllerRight = $PanelContainer/VBoxContainer/HBoxContainer2/Controller/Right
@onready var controllerLP = $PanelContainer/VBoxContainer/HBoxContainer2/Controller/LeftPunch
@onready var controllerRP = $PanelContainer/VBoxContainer/HBoxContainer2/Controller/RightPunch
@onready var controllerSP = $PanelContainer/VBoxContainer/HBoxContainer2/Controller/SuperPunch
@onready var controllerPause = $PanelContainer/VBoxContainer/HBoxContainer2/Controller/Pause
@onready var controllerAccept = $PanelContainer/VBoxContainer/HBoxContainer2/Controller/Accept
@onready var controllerCancel = $PanelContainer/VBoxContainer/HBoxContainer2/Controller/Cancel

@onready var controllerUp2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Up2
@onready var controllerDown2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Down2
@onready var controllerLeft2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Left2
@onready var controllerRight2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Right2
@onready var controllerLP2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/LeftPunch2
@onready var controllerRP2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/RightPunch2
@onready var controllerSP2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/SuperPunch2
@onready var controllerPause2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Pause2
@onready var controllerAccept2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Accept2
@onready var controllerCancel2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Cancel2

@onready var keyboardUp = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/UpKey
@onready var keyboardDown = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/DownKey
@onready var keyboardLeft = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/LeftKey
@onready var keyboardRight = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/RightKey
@onready var keyboardLP = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/LeftPunchKey
@onready var keyboardRP = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/RightPunchKey
@onready var keyboardSP = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/SuperPunchKey
@onready var keyboardPause = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/PauseKey
@onready var keyboardAccept = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/AcceptKey
@onready var keyboardCancel = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/CancelKey

@onready var keyboardUp2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/UpKey2
@onready var keyboardDown2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/DownKey2
@onready var keyboardLeft2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/LeftKey2
@onready var keyboardRight2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/RightKey2
@onready var keyboardLP2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/LeftPunchKey2
@onready var keyboardRP2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/RightPunchKey2
@onready var keyboardSP2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/SuperPunchKey2
@onready var keyboardPause2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/PauseKey2
@onready var keyboardAccept2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/AcceptKey2
@onready var keyboardCancel2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/CancelKey2

@onready var resetButton = $PanelContainer/VBoxContainer/Reset
@onready var saveButton = $PanelContainer/VBoxContainer/Save
@onready var helpLabel = $PanelContainer/VBoxContainer/HeyYa

var focusX = 0
var focusY = 0
var menuLimitX = 3
var menuLimitY = 11
var selectX = 0
var selectY = 0
var canPress = false
var setting = false
var waitagoddamnsecond = 0

const keymaps_path = "user://inputmaps.dat"
var keymaps: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	for action in InputMap.get_actions():
		if InputMap.action_get_events(action).size() != 0:
			keymaps[action] = InputMap.action_get_events(action)[0]
		else:
			keymaps[action] = null
	load_keymap()
	updateTextPlease()

func updateTextPlease():
	for n in controller.get_children():
		n.update_text()
	for n in controller2.get_children():
		n.update_text()
	for n in keyboard.get_children():
		n.update_text()
	for n in keyboard2.get_children():
		n.update_text()

func reloadBind():
	for action in InputMap.get_actions():
		if InputMap.action_get_events(action).size() != 0:
			keymaps[action] = InputMap.action_get_events(action)[0]
	save_keymap()
	updateTextPlease()

func load_keymap():
	if not FileAccess.file_exists(keymaps_path):
		save_keymap()
		return
	var file = FileAccess.open(keymaps_path, FileAccess.READ)
	var temp_keymap = file.get_var(true) as Dictionary
	file.close()
	
	for action in keymaps.keys():
		if temp_keymap.has(action):
			keymaps[action] = temp_keymap[action]
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, keymaps[action])
	acceptCancelHack()

func save_keymap():
	var file = FileAccess.open(keymaps_path, FileAccess.WRITE)
	file.store_var(keymaps, true)
	file.close()
	acceptCancelHack()

func acceptCancelHack():
	InputMap.action_erase_events("ui_accept")
	InputMap.action_add_event("ui_accept", keymaps["Accept"])
	InputMap.action_add_event("ui_accept", keymaps["Accept2"])
	InputMap.action_add_event("ui_accept", keymaps["AcceptKey"])
	InputMap.action_add_event("ui_accept", keymaps["AcceptKey2"])
	InputMap.action_erase_events("ui_cancel")
	InputMap.action_add_event("ui_cancel", keymaps["Cancel"])
	InputMap.action_add_event("ui_cancel", keymaps["Cancel2"])
	InputMap.action_add_event("ui_cancel", keymaps["CancelKey"])
	InputMap.action_add_event("ui_cancel", keymaps["CancelKey2"])

func _physics_process(delta):
	if waitagoddamnsecond > 0:
		waitagoddamnsecond -= 1
	
	if waitagoddamnsecond == 0:
		canPress = true

func disableButtons():
	if setting:
		#print("Loner with a claustrophobic mind")
		for n in controller.get_children():
			if !n.button_pressed:
				n.disabled = true
				n.focus_mode = 0
		for n in controller2.get_children():
			if !n.button_pressed:
				n.disabled = true
				n.focus_mode = 0
		for n in keyboard.get_children():
			if !n.button_pressed:
				n.disabled = true
				n.focus_mode = 0
		for n in keyboard2.get_children():
			if !n.button_pressed:
				n.disabled = true
				n.focus_mode = 0
		saveButton.disabled = true
		saveButton.focus_mode = 0
		resetButton.disabled = true
		resetButton.focus_mode = 0
		helpLabel.text = "Press BACKSPACE or Select to cancel"
	else:
		if canPress:
			for n in controller.get_children():
				n.disabled = false
				n.focus_mode = 2
			for n in controller2.get_children():
				n.disabled = false
				n.focus_mode = 2
			for n in keyboard.get_children():
				n.disabled = false
				n.focus_mode = 2
			for n in keyboard2.get_children():
				n.disabled = false
				n.focus_mode = 2
			saveButton.disabled = false
			saveButton.focus_mode = 2
			resetButton.disabled = false
			resetButton.focus_mode = 2
			helpLabel.text = "Press BACKSPACE or Select to delete selected bind"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		disableButtons()
	
	if visible and !setting and canPress:
		if Gamemanager.checkInputJustPressed("Start"):
			visible = false
		
		if Gamemanager.checkInputJustPressed("ui_cancel"):
			visible = false
		
		#print(setting)
		if Gamemanager.checkInputJustPressed("Down"):
			selectY += 1
		if Gamemanager.checkInputJustPressed("Up"):
			selectY -= 1
			
		if selectY < 0:
			selectY = menuLimitY
		
		if selectY > menuLimitY:
			selectY = 0
		
		if Gamemanager.checkInputJustPressed("Left"):
			selectX -= 1
		if Gamemanager.checkInputJustPressed("Right"):
			selectX += 1
			
		if selectX < 0:
			selectX = menuLimitX
		
		if selectX > menuLimitX:
			selectX = 0
		
		#print(selectY)
		match selectY:
			0:
				match selectX:
					0:
						if !controllerUp.has_focus() and !setting:
							controllerUp.grab_focus()
					1:
						if !controllerUp2.has_focus() and !setting:
							controllerUp2.grab_focus()
					2:
						if !keyboardUp.has_focus() and !setting:
							keyboardUp.grab_focus()
					3:
						if !keyboardUp2.has_focus() and !setting:
							keyboardUp2.grab_focus()
			1:
				match selectX:
					0:
						if !controllerDown.has_focus() and !setting:
							controllerDown.grab_focus()
					1:
						if !controllerDown2.has_focus() and !setting:
							controllerDown2.grab_focus()
					2:
						if !keyboardDown.has_focus() and !setting:
							keyboardDown.grab_focus()
					3:
						if !keyboardDown2.has_focus() and !setting:
							keyboardDown2.grab_focus()
			2:
				match selectX:
					0:
						if !controllerLeft.has_focus() and !setting:
							controllerLeft.grab_focus()
					1:
						if !controllerLeft2.has_focus() and !setting:
							controllerLeft2.grab_focus()
					2:
						if !keyboardLeft.has_focus() and !setting:
							keyboardLeft.grab_focus()
					3:
						if !keyboardLeft2.has_focus() and !setting:
							keyboardLeft2.grab_focus()
			3:
				match selectX:
					0:
						if !controllerRight.has_focus() and !setting:
							controllerRight.grab_focus()
					1:
						if !controllerRight2.has_focus() and !setting:
							controllerRight2.grab_focus()
					2:
						if !keyboardRight.has_focus() and !setting:
							keyboardRight.grab_focus()
					3:
						if !keyboardRight2.has_focus() and !setting:
							keyboardRight2.grab_focus()
			4:
				match selectX:
					0:
						if !controllerLP.has_focus() and !setting:
							controllerLP.grab_focus()
					1:
						if !controllerLP2.has_focus() and !setting:
							controllerLP2.grab_focus()
					2:
						if !keyboardLP.has_focus() and !setting:
							keyboardLP.grab_focus()
					3:
						if !keyboardLP2.has_focus() and !setting:
							keyboardLP2.grab_focus()
			5:
				match selectX:
					0:
						if !controllerRP.has_focus() and !setting:
							controllerRP.grab_focus()
					1:
						if !controllerRP2.has_focus() and !setting:
							controllerRP2.grab_focus()
					2:
						if !keyboardRP.has_focus() and !setting:
							keyboardRP.grab_focus()
					3:
						if !keyboardRP2.has_focus() and !setting:
							keyboardRP2.grab_focus()
			6:
				match selectX:
					0:
						if !controllerSP.has_focus() and !setting:
							controllerSP.grab_focus()
					1:
						if !controllerSP2.has_focus() and !setting:
							controllerSP2.grab_focus()
					2:
						if !keyboardSP.has_focus() and !setting:
							keyboardSP.grab_focus()
					3:
						if !keyboardSP2.has_focus() and !setting:
							keyboardSP2.grab_focus()
			7:
				match selectX:
					0:
						if !controllerPause.has_focus() and !setting:
							controllerPause.grab_focus()
					1:
						if !controllerPause2.has_focus() and !setting:
							controllerPause2.grab_focus()
					2:
						if !keyboardPause.has_focus() and !setting:
							keyboardPause.grab_focus()
					3:
						if !keyboardPause2.has_focus() and !setting:
							keyboardPause2.grab_focus()
			8:
				match selectX:
					0:
						if !controllerAccept.has_focus() and !setting:
							controllerAccept.grab_focus()
					1:
						if !controllerAccept2.has_focus() and !setting:
							controllerAccept2.grab_focus()
					2:
						if !keyboardAccept.has_focus() and !setting:
							keyboardAccept.grab_focus()
					3:
						if !keyboardAccept2.has_focus() and !setting:
							keyboardAccept2.grab_focus()
			9:
				match selectX:
					0:
						if !controllerCancel.has_focus() and !setting:
							controllerCancel.grab_focus()
					1:
						if !controllerCancel2.has_focus() and !setting:
							controllerCancel2.grab_focus()
					2:
						if !keyboardCancel.has_focus() and !setting:
							keyboardCancel.grab_focus()
					3:
						if !keyboardCancel2.has_focus() and !setting:
							keyboardCancel2.grab_focus()
			10:
				if !resetButton.has_focus() and !setting:
					resetButton.grab_focus()
			11:
				if !saveButton.has_focus() and !setting:
					saveButton.grab_focus()


func _on_reset_pressed():
	InputMap.load_from_project_settings()
	reloadBind()


func _on_save_pressed():
	visible = false
	canPress = false
	Options.visible = true


func _on_up_mouse_entered():
	if !controllerUp.has_focus() and !setting:
		selectY = 0
		selectX = 0
		controllerUp.grab_focus()


func _on_down_mouse_entered():
	if !controllerDown.has_focus() and !setting:
		selectY = 1
		selectX = 0
		controllerDown.grab_focus()


func _on_left_mouse_entered():
	if !controllerLeft.has_focus() and !setting:
		selectY = 2
		selectX = 0
		controllerLeft.grab_focus()


func _on_right_mouse_entered():
	if !controllerRight.has_focus() and !setting:
		selectY = 3
		selectX = 0
		controllerRight.grab_focus()


func _on_left_punch_mouse_entered():
	if !controllerLP.has_focus() and !setting:
		selectY = 4
		selectX = 5
		controllerLP.grab_focus()


func _on_right_punch_mouse_entered():
	if !controllerRP.has_focus() and !setting:
		selectY = 5
		selectX = 0
		controllerRP.grab_focus()


func _on_super_punch_mouse_entered():
	if !controllerSP.has_focus() and !setting:
		selectY = 6
		selectX = 0
		controllerSP.grab_focus()


func _on_pause_mouse_entered():
	if !controllerPause.has_focus() and !setting:
		selectY = 7
		selectX = 0
		controllerPause.grab_focus()


func _on_accept_mouse_entered():
	if !controllerAccept.has_focus() and !setting:
		selectY = 8
		selectX = 0
		controllerAccept.grab_focus()


func _on_cancel_mouse_entered():
	if !controllerCancel.has_focus() and !setting:
		selectY = 9
		selectX = 0
		controllerCancel.grab_focus()


func _on_up_2_mouse_entered():
	if !controllerUp2.has_focus() and !setting:
		selectY = 0
		selectX = 1
		controllerUp2.grab_focus()


func _on_down_2_mouse_entered():
	if !controllerDown2.has_focus() and !setting:
		selectY = 1
		selectX = 1
		controllerDown2.grab_focus()


func _on_left_2_mouse_entered():
	if !controllerLeft2.has_focus() and !setting:
		selectY = 2
		selectX = 1
		controllerLeft2.grab_focus()


func _on_right_2_mouse_entered():
	if !controllerRight2.has_focus() and !setting:
		selectY = 3
		selectX = 1
		controllerRight2.grab_focus()


func _on_left_punch_2_mouse_entered():
	if !controllerLP2.has_focus() and !setting:
		selectY = 4
		selectX = 1
		controllerLP2.grab_focus()


func _on_right_punch_2_mouse_entered():
	if !controllerRP2.has_focus() and !setting:
		selectY = 5
		selectX = 1
		controllerRP2.grab_focus()


func _on_super_punch_2_mouse_entered():
	if !controllerSP2.has_focus() and !setting:
		selectY = 6
		selectX = 1
		controllerSP2.grab_focus()


func _on_pause_2_mouse_entered():
	if !controllerPause2.has_focus() and !setting:
		selectY = 7
		selectX = 1
		controllerPause2.grab_focus()


func _on_accept_2_mouse_entered():
	if !controllerAccept2.has_focus() and !setting:
		selectY = 8
		selectX = 1
		controllerAccept2.grab_focus()


func _on_cancel_2_mouse_entered():
	if !controllerCancel2.has_focus() and !setting:
		selectY = 9
		selectX = 1
		controllerCancel2.grab_focus()


func _on_up_key_mouse_entered():
	if !keyboardUp.has_focus() and !setting:
		selectY = 0
		selectX = 2
		keyboardUp.grab_focus()


func _on_down_key_mouse_entered():
	if !keyboardDown.has_focus() and !setting:
		selectY = 1
		selectX = 2
		keyboardDown.grab_focus()


func _on_left_key_mouse_entered():
	if !keyboardLeft.has_focus() and !setting:
		selectY = 2
		selectX = 2
		keyboardLeft.grab_focus()


func _on_right_key_mouse_entered():
	if !keyboardRight.has_focus() and !setting:
		selectY = 3
		selectX = 2
		keyboardRight.grab_focus()


func _on_left_punch_key_mouse_entered():
	if !keyboardLP.has_focus() and !setting:
		selectY = 4
		selectX = 2
		keyboardLP.grab_focus()


func _on_right_punch_key_mouse_entered():
	if !keyboardRP.has_focus() and !setting:
		selectY = 5
		selectX = 2
		keyboardRP.grab_focus()


func _on_super_punch_key_mouse_entered():
	if !keyboardSP.has_focus() and !setting:
		selectY = 6
		selectX = 2
		keyboardSP.grab_focus()


func _on_pause_key_mouse_entered():
	if !keyboardPause.has_focus() and !setting:
		selectY = 7
		selectX = 2
		keyboardPause.grab_focus()


func _on_accept_key_mouse_entered():
	if !keyboardAccept.has_focus() and !setting:
		selectY = 8
		selectX = 2
		keyboardAccept.grab_focus()


func _on_cancel_key_mouse_entered():
	if !keyboardCancel.has_focus() and !setting:
		selectY = 9
		selectX = 2
		keyboardCancel.grab_focus()


func _on_up_key_2_mouse_entered():
	if !keyboardUp2.has_focus() and !setting:
		selectY = 0
		selectX = 3
		keyboardUp2.grab_focus()


func _on_down_key_2_mouse_entered():
	if !keyboardDown2.has_focus() and !setting:
		selectY = 1
		selectX = 3
		keyboardDown2.grab_focus()


func _on_left_key_2_mouse_entered():
	if !keyboardLeft2.has_focus() and !setting:
		selectY = 2
		selectX = 3
		keyboardLeft2.grab_focus()


func _on_right_key_2_mouse_entered():
	if !keyboardRight2.has_focus() and !setting:
		selectY = 3
		selectX = 3
		keyboardRight2.grab_focus()


func _on_left_punch_key_2_mouse_entered():
	if !keyboardLP2.has_focus() and !setting:
		selectY = 4
		selectX = 3
		keyboardLP2.grab_focus()


func _on_right_punch_key_2_mouse_entered():
	if !keyboardRP2.has_focus() and !setting:
		selectY = 5
		selectX = 3
		keyboardRP2.grab_focus()


func _on_super_punch_key_2_mouse_entered():
	if !keyboardSP2.has_focus() and !setting:
		selectY = 6
		selectX = 3
		keyboardSP2.grab_focus()


func _on_pause_key_2_mouse_entered():
	if !keyboardPause2.has_focus() and !setting:
		selectY = 7
		selectX = 3
		keyboardPause2.grab_focus()


func _on_accept_key_2_mouse_entered():
	if !keyboardAccept2.has_focus() and !setting:
		selectY = 8
		selectX = 3
		keyboardAccept2.grab_focus()


func _on_cancel_key_2_mouse_entered():
	if !keyboardCancel2.has_focus() and !setting:
		selectY = 9
		selectX = 3
		keyboardCancel2.grab_focus()


func _on_reset_mouse_entered():
	if !setting and !resetButton.has_focus():
		selectY = 10
		resetButton.grab_focus()


func _on_save_mouse_entered():
	if !setting and !saveButton.has_focus():
		selectY = 11
		saveButton.grab_focus()
