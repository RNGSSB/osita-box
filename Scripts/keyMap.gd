extends Button

@export var action : String
@onready var input_mapper = $".."
@export var index = 2

func _init():
	toggle_mode = true

func _ready():
	set_process_unhandled_input(false)

func _toggled(button_pressed):
	set_process_unhandled_input(button_pressed)
	grab_focus()
	if button_pressed:
		grab_focus()
		text = "...Waiting"
	else:
		owner.setting = false
		update_text()

func _unhandled_input(event):
	if event.is_pressed():
		if event is InputEventKey:
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
			button_pressed = false
			grab_focus()
			update_text()
			input_mapper.keymaps[action] = event
			input_mapper.save_keymap()

func update_text():
	if InputMap.action_get_events(action).size() >= index + 1:
		text = InputMap.action_get_events(action)[index].as_text()
	else:
		text = "None"
