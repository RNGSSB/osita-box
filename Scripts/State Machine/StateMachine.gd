#State Machine Script
extends Node

var current_state : State
var states : Dictionary = {}

@export var initial_state : State

func _ready():
	#Populates states dictionary with all States in the scene tree
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		#Initializes first state
		initial_state.Enter()
		current_state = initial_state
		owner.CURRSTATE = current_state.name

func _process(_delta):
	#State specific _process function. Cannot be frozen by hitstop, useful for
	#buffering things during hitstop
	if current_state:
		current_state.Update(_delta)

func _physics_process(_delta):
	#State specific physics_process. Main one used for game logic in order to keep things 
	#consistent between different frame rates
	#Will freeze during hitstop
	if current_state:
		if !owner.frozen: 
			owner.stateFrame += 1
			current_state.Physics_Update(_delta)

#Change State 1 - Like the transition signal but can be called whenever
func change_state(new_state_name):
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state == new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	owner.PREVSTATE = current_state.name
	owner.prevStateFrame = owner.stateFrame
	owner.stateFrame = 1
	new_state.Enter()
	current_state = new_state
	owner.CURRSTATE = new_state.name

#Change State 2 - CS1 prevents you from changing to the same state, this one doesn't
#Useful for states such as punches that can go back into themselves
func change_state2(new_state_name):
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	owner.PREVSTATE = current_state.name
	owner.prevStateFrame = owner.stateFrame
	owner.stateFrame = 1
	new_state.Enter()
	current_state = new_state
	owner.CURRSTATE = new_state.name

#This one is called when the transitioned signal is called
func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	
	if current_state:
		current_state.Exit()
	
	owner.PREVSTATE = current_state.name
	owner.prevStateFrame = owner.stateFrame
	owner.stateFrame = 1
	new_state.Enter()
	current_state = new_state
	owner.CURRSTATE = new_state.name
	#print(owner.CURRSTATE)
