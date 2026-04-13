extends Node

var animFrame = 0 #Current overall frame of animation we are on
var animWait = 0 #Frames to wait until next animation frame

var animLenght = 0 #Total animation lenght

var frozen = false #For hitlag 

var animations : Dictionary = {} #List of every animation the object has

var current_anim : Anim #Animation object

var animEnd = false #Becomes true when animation finishes, used for logic in States
#Doesn't trigger if animation loops, which is also useful for logic things :3

var CURRANIM : String = "IDK" #String name of current animation

var FSM : float = 1.0 #Frame Speed Multiplier, unused maybe

var endFrame = 0 #Used to end animation at an earlier point




# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Anim:
			animations[child.name.to_lower()] = child

#Returns true if animation is found in scene tree
func checkAnim(animName):
	var new_anim = animations.get(animName.to_lower())
	if !new_anim:
		return false
	else:
		return true

#Plays animation given by string
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
	
	#Move sprite horizontal offset if not -1, also considers flipping
	if !owner.flip_h:
		if current_anim.posX != -1:
			owner.position.x = current_anim.posX * -1
	else:
		if current_anim.posX != -1:
			owner.position.x = current_anim.posX 
	
	#Changes Sprite height if it is not equal to -1.0 (default)
	if current_anim.posY != -1.0:
		owner.position.y = current_anim.posY
	else:
		if owner.defaultPosY != -1.0:
			owner.position.y = owner.defaultPosY
	
	if current_anim.endFrame <= 1 or current_anim.endFrame > current_anim.frames:
		endFrame = current_anim.frames - 1
	else:
		endFrame = current_anim.endFrame - 1

#Returns animation lenght
func calculateAnimLenght():
	animLenght = 1
	for n in current_anim.frameTimes:
		animLenght += n

func _physics_process(_delta):
	if !frozen:
		animationProcess()

func onFrame(value):
	if animFrame == value - 1:
		return true
	else:
		return false

#Allows you to skip to a certain animation frame (not state frame), and also sets state and animation
#frames as if you had just reached that frame naturally.
#Used to skip startup of attacks, or maybe even restart attacks or states?

func setFrame(frame):
	var frameCount = 0
	for n in frame + 1:
		if n < frame:
			frameCount += current_anim.frameTimes[n]
			print(str(frameCount) + " " + str(current_anim.frameTimes[n])) 
		if n == frame:
			animWait = current_anim.frameTimes[n]
			frameCount += 1
	owner.frame = frame
	owner.stateFrame = frameCount
	animFrame = frameCount


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
						animEnd = true
					elif owner.frame == endFrame and current_anim.loop:
						owner.frame = current_anim.loopFrame - 1
						animFrame = 1
						animWait = current_anim.frameTimes[owner.frame] * FSM
					else:
						owner.frame += 1
						animFrame += 1
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

# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
