extends Node

var animFrame = 0
var animWait = 0

var animLenght = 0

var frozen = false

var animations : Dictionary = {}

var current_anim : Anim

var animEnd = false

var CURRANIM : String = "IDK"

var FSM : float = 1.0

var endFrame = 0




# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Anim:
			animations[child.name.to_lower()] = child

func animPlay(animName):
	FSM = 1.0
	animEnd = false
	animFrame = 1
	var new_anim = animations.get(animName.to_lower())
	if !new_anim:
		return
	current_anim = new_anim
	calculateAnimLenght()
	CURRANIM = current_anim.name
	current_anim.enter()
	if !current_anim.reverse:
		owner.frame = current_anim.initialFrame - 1
	else:
		owner.frame = current_anim.initialFrame - 1
	animWait = current_anim.frameTimes[owner.frame]
	if !owner.flip_h:
		owner.position.x = current_anim.posX * -1
	else:
		owner.position.x = current_anim.posX 
	
	if current_anim.endFrame <= 1 or current_anim.endFrame > current_anim.frames:
		endFrame = current_anim.frames - 1
	else:
		endFrame = current_anim.endFrame - 1

func calculateAnimLenght():
	animLenght = 1
	for n in current_anim.frameTimes:
		animLenght += n

func _physics_process(delta):
	if !frozen:
		animationProcess()

func waitFrames(value):
	pass

func onFrame(value):
	if animFrame == value - 1:
		return true
	else:
		return false


func animationProcess():
	if current_anim != null or animEnd:
		if !current_anim.reverse:
			if owner.frame <= endFrame:
				if animWait * FSM > 1:
					animFrame += 1
					animWait -= 1
				else:
					if owner.frame == endFrame and !current_anim.loop:
						animFrame += 1
						print("2")
						animEnd = true
					elif owner.frame == endFrame and current_anim.loop:
						owner.frame = current_anim.loopFrame - 1
						animFrame = 1
						animWait = current_anim.frameTimes[owner.frame] * FSM
					else:
						owner.frame += 1
						animFrame += 1
						print("3")
						animWait = current_anim.frameTimes[owner.frame] * FSM
			if !animEnd:
				if current_anim.FAF > 0:
					if owner.stateFrame >= current_anim.FAF:
						owner.ctrl = 1
		else:
			if owner.frame >= 0:
				if animWait * FSM > 1:
					animFrame += 1
					animWait -= 1
				else:
					if owner.frame == 0 and !current_anim.loop:
						animFrame += 1
						animEnd = true
					elif owner.frame == 0 and current_anim.loop:
						owner.frame = current_anim.frames - 1
						animWait = current_anim.frameTimes[owner.frame] * FSM
					else:
						owner.frame -= 1
						animFrame += 1
						animWait = current_anim.frameTimes[owner.frame] * FSM
			if !animEnd:
				if current_anim.FAF > 0:
					if owner.stateFrame >= current_anim.FAF:
						owner.ctrl = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
