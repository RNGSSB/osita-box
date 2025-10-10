extends Button

@export var action : String
@export var index = 2
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
		if  Input.is_action_just_pressed("DeleteInput") and canPressSelf:
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
		if event is InputEventKey and event.keycode != KEY_BACKSPACE:
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
			button_pressed = false
			grab_focus()
			update_text()
			owner.keymaps[action] = event
			owner.save_keymap()
			owner.waitagoddamnsecond = 3
			canPressSelf = false
			owner.canPress = false

func update_text():
	if InputMap.action_get_events(action).size() >= 1:
		text = InputMap.action_get_events(action)[0].as_text()
	else:
		text = "None"
