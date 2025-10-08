extends CanvasLayer


@export var controller : VBoxContainer
@export var keyboard : VBoxContainer

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

@onready var controllerUp2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Up
@onready var controllerDown2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Down
@onready var controllerLeft2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Left
@onready var controllerRight2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Right
@onready var controllerLP2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/LeftPunch
@onready var controllerRP2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/RightPunch
@onready var controllerSP2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/SuperPunch
@onready var controllerPause2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Pause
@onready var controllerAccept2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Accept
@onready var controllerCancel2 = $PanelContainer/VBoxContainer/HBoxContainer2/Controller2/Cancel

@onready var keyboardUp = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/Up
@onready var keyboardDown = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/Down
@onready var keyboardLeft = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/Left
@onready var keyboardRight = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/Right
@onready var keyboardLP = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/LeftPunch
@onready var keyboardRP = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/RightPunch
@onready var keyboardSP = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/SuperPunch
@onready var keyboardPause = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/Pause
@onready var keyboardAccept = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/Accept
@onready var keyboardCancel = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard/Cancel

@onready var keyboardUp2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/Up
@onready var keyboardDown2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/Down
@onready var keyboardLeft2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/Left
@onready var keyboardRight2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/Right
@onready var keyboardLP2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/LeftPunch
@onready var keyboardRP2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/RightPunch
@onready var keyboardSP2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/SuperPunch
@onready var keyboardPause2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/Pause
@onready var keyboardAccept2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/Accept
@onready var keyboardCancel2 = $PanelContainer/VBoxContainer/HBoxContainer2/Keyboard2/Cancel

@onready var resetButton = $PanelContainer/VBoxContainer/Reset
@onready var saveButton = $PanelContainer/VBoxContainer/Save

var focusX = 0
var focusY = 0
var menuLimitX = 3
var menuLimitY = 11
var selectX = 0
var selectY = 0
var canPress = false
var setting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		if Input.is_action_just_pressed("Down") or Input.is_action_just_pressed("DownKey"):
			selectY += 1
		if Input.is_action_just_pressed("Up") or Input.is_action_just_pressed("UpKey"):
			selectY -= 1
			
		if selectY < 0:
			selectY = menuLimitY
		
		if selectY > menuLimitY:
			selectY = 0
		
		if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("LeftKey"):
			selectX -= 1
		if Input.is_action_just_pressed("Right") or Input.is_action_just_pressed("RightKey"):
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
						if !controllerUp.has_focus():
							controllerUp.grab_focus()
					1:
						if !controllerUp2.has_focus():
							controllerUp2.grab_focus()
					2:
						if !keyboardUp.has_focus():
							keyboardUp.grab_focus()
					3:
						if !keyboardUp2.has_focus():
							keyboardUp2.grab_focus()
			1:
				match selectX:
					0:
						if !controllerDown.has_focus():
							controllerDown.grab_focus()
					1:
						if !controllerDown2.has_focus():
							controllerDown2.grab_focus()
					2:
						if !keyboardDown.has_focus():
							keyboardDown.grab_focus()
					3:
						if !keyboardDown2.has_focus():
							keyboardDown2.grab_focus()
			2:
				match selectX:
					0:
						if !controllerLeft.has_focus():
							controllerLeft.grab_focus()
					1:
						if !controllerLeft2.has_focus():
							controllerLeft2.grab_focus()
					2:
						if !keyboardLeft.has_focus():
							keyboardLeft.grab_focus()
					3:
						if !keyboardLeft2.has_focus():
							keyboardLeft2.grab_focus()
			3:
				match selectX:
					0:
						if !controllerRight.has_focus():
							controllerRight.grab_focus()
					1:
						if !controllerRight2.has_focus():
							controllerRight2.grab_focus()
					2:
						if !keyboardRight.has_focus():
							keyboardRight.grab_focus()
					3:
						if !keyboardRight2.has_focus():
							keyboardRight2.grab_focus()
			4:
				match selectX:
					0:
						if !controllerLP.has_focus():
							controllerLP.grab_focus()
					1:
						if !controllerLP2.has_focus():
							controllerLP2.grab_focus()
					2:
						if !keyboardLP.has_focus():
							keyboardLP.grab_focus()
					3:
						if !keyboardLP2.has_focus():
							keyboardLP2.grab_focus()
			5:
				match selectX:
					0:
						if !controllerRP.has_focus():
							controllerRP.grab_focus()
					1:
						if !controllerRP2.has_focus():
							controllerRP2.grab_focus()
					2:
						if !keyboardRP.has_focus():
							keyboardRP.grab_focus()
					3:
						if !keyboardRP2.has_focus():
							keyboardRP2.grab_focus()
			6:
				match selectX:
					0:
						if !controllerSP.has_focus():
							controllerSP.grab_focus()
					1:
						if !controllerSP2.has_focus():
							controllerSP2.grab_focus()
					2:
						if !keyboardSP.has_focus():
							keyboardSP.grab_focus()
					3:
						if !keyboardSP2.has_focus():
							keyboardSP2.grab_focus()
			7:
				match selectX:
					0:
						if !controllerPause.has_focus():
							controllerPause.grab_focus()
					1:
						if !controllerPause2.has_focus():
							controllerPause2.grab_focus()
					2:
						if !keyboardPause.has_focus():
							keyboardPause.grab_focus()
					3:
						if !keyboardPause2.has_focus():
							keyboardPause2.grab_focus()
			8:
				match selectX:
					0:
						if !controllerAccept.has_focus():
							controllerAccept.grab_focus()
					1:
						if !controllerAccept2.has_focus():
							controllerAccept2.grab_focus()
					2:
						if !keyboardAccept.has_focus():
							keyboardAccept.grab_focus()
					3:
						if !keyboardAccept2.has_focus():
							keyboardAccept2.grab_focus()
			9:
				match selectX:
					0:
						if !controllerCancel.has_focus():
							controllerCancel.grab_focus()
					1:
						if !controllerCancel2.has_focus():
							controllerCancel2.grab_focus()
					2:
						if !keyboardCancel.has_focus():
							keyboardCancel.grab_focus()
					3:
						if !keyboardCancel2.has_focus():
							keyboardCancel2.grab_focus()
			10:
				if !resetButton.has_focus():
					resetButton.grab_focus()
			11:
				if !saveButton.has_focus():
					saveButton.grab_focus()


func _on_reset_pressed():
	InputMap.load_from_project_settings()
	controller.reloadBind()
	keyboard.reloadBind()


func _on_save_pressed():
	visible = false
	canPress = false
	Options.visible = true
