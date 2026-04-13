#Animation class used to play animations using AnimSys
class_name Anim
extends Node

@export var loop = false #Animation loops or not
@export var reverse = false  #Plays animation in reverse
@export var spriteSheet : CompressedTexture2D #Sprite Sheet Image
@export var initialFrame : int = 1 #What frame are we starting on (usually 1)
@export var endFrame : int = -1 #What frame we end on. If -1, does nothing
@export var frames : int = 1 #How many individual animation frames exist in sprite sheet 
#(useful for spritesheets that have empty spaces)
@export var loopFrame : int = 1 #Frame to start every time we loop (if we loop)
@export var FAF : int = -1 #First actionable frame, gives you ctrl = 1 state frame 
#reaches value (leftover from other game i don't care to remove) 
@export var rows : int = 7 #How many frames exist horizontally
@export var columns : int = 1 #How many frames exist vertically
@export var posX : float = 0.0 #Changes sprite position X
@export var posY : float = -1.0 #Changes sprite positon Y

@export var frameTimes : Array[int] = [] #How many frames do we stay on current animation frame


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func enter():
	owner.texture = spriteSheet
	#print(owner.name)
	owner.hframes = rows
	owner.vframes = columns
	#print(columns)
	#print(rows)


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
