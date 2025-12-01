class_name Anim
extends Node

@export var loop = false
@export var reverse = false
@export var spriteSheet : CompressedTexture2D
@export var initialFrame : int = 1
@export var endFrame : int = -1
@export var frames : int = 1
@export var loopFrame : int = 1
@export var FAF : int = -1
@export var rows : int = 7
@export var columns : int = 1
@export var posX : float = 0.0
@export var posY : float = -1.0

@export var frameTimes : Array[int] = []


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
