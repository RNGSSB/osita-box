extends Button

@export var action : String
@export var index = 0
var canPressSelf = true

func _init():
	toggle_mode = true

func _ready():
	set_process_unhandled_input(false)

func _physics_process(delta):
	if !owner.canPress and !canPressSelf:
		disabled = true
	else:
		canPressSelf = true
		disabled = false
	
	if button_pressed:
		if Input.is_action_just_pressed("DeleteInput"):
			print(name + " cancelled!!!")
			owner.setting = false
			update_text()
			owner.waitagoddamnsecond = 3
			canPressSelf = false
			owner.canPress = false
			button_pressed = false
	if !button_pressed and has_focus():
		if Input.is_action_just_pressed("DeleteInput") and canPressSelf:
			print(name + " deleted!!!")
			InputMap.action_erase_events(action)
			owner.keymaps[action] = null
			button_pressed = false
			grab_focus()
			update_text()
			owner.save_keymap()
			owner.waitagoddamnsecond = 3
			owner.canPress = false
			canPressSelf = false

func _toggled(button_pressed):
	set_process_unhandled_input(button_pressed)
	grab_focus()
	if button_pressed:
		grab_focus()
		owner.setting = true
		text = "...Waiting"
	else:
		owner.setting = false
		update_text()

func _unhandled_input(event):
	if event.is_pressed():
		if event is InputEventJoypadButton and event.button_index != 7 and event.button_index != 8 or event is InputEventJoypadMotion:
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
			button_pressed = false
			grab_focus()
			update_text()
			owner.keymaps[action] = event
			owner.save_keymap()
			owner.waitagoddamnsecond = 3
			owner.canPress = false
			canPressSelf = false

func update_text():
	if InputMap.action_get_events(action).size() >= 1:
		match InputMap.action_get_events(action)[0].as_text():
			"Joypad Button 11 (D-pad Up)":
				text = "D-Pad Up"
			"Joypad Button 13 (D-pad Left)":
				text = "D-Pad Left"
			"Joypad Button 14 (D-pad Right)":
				text = "D-Pad Right"
			"Joypad Button 12 (D-pad Down)":
				text = "D-Pad Down"
			"Joypad Button 2 (Left Action, Sony Square, Xbox X, Nintendo Y)":
				text = "X"
			"Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)":
				text = "A"
			"Joypad Button 3 (Top Action, Sony Triangle, Xbox Y, Nintendo X)":
				text = "Y"
			"Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)":
				text = "B"
			"Joypad Button 9 (Left Shoulder, Sony L1, Xbox LB)":
				text = "LB"
			"Joypad Button 10 (Right Shoulder, Sony R1, Xbox RB)":
				text = "RB"
			"Joypad Button 6 (Start, Xbox Menu, Nintendo +)":
				text = "Start"
			_:
				text = InputMap.action_get_events(action)[0].as_text()
		if InputMap.action_get_events(action)[0] is InputEventJoypadMotion:
			if InputMap.action_get_events(action)[0].axis == 1 and InputMap.action_get_events(action)[0].axis_value > 0:
				text = "L-Stick Down"
			elif InputMap.action_get_events(action)[0].axis == 1 and InputMap.action_get_events(action)[0].axis_value < 0:
				text = "L-Stick Up"
			elif InputMap.action_get_events(action)[0].axis == 0 and InputMap.action_get_events(action)[0].axis_value > 0:
				text = "L-Stick Right"
			elif InputMap.action_get_events(action)[0].axis == 0 and InputMap.action_get_events(action)[0].axis_value < 0:
				text = "L-Stick Left"
			elif InputMap.action_get_events(action)[0].axis == 2 and InputMap.action_get_events(action)[0].axis_value > 0:
				text = "R-Stick Right"
			elif  InputMap.action_get_events(action)[0].axis == 2 and InputMap.action_get_events(action)[0].axis_value < 0:
				text = "R-Stick Left"
			elif InputMap.action_get_events(action)[0].axis == 3 and InputMap.action_get_events(action)[0].axis_value > 0:
				text = "R-Stick Down"
			elif InputMap.action_get_events(action)[0].axis == 3 and InputMap.action_get_events(action)[0].axis_value < 0:
				text = "R-Stick Up"
			elif InputMap.action_get_events(action)[0].axis == 4 and InputMap.action_get_events(action)[0].axis_value > 0:
				text = "LT"
			elif InputMap.action_get_events(action)[0].axis == 5 and InputMap.action_get_events(action)[0].axis_value > 0:
				text = "RT"
		#print(text)
	else:
		text = "None"
