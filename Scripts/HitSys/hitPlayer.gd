class_name HitPlayer
extends Node

enum hitDirections{LEFT,RIGHT,UPLEFT,UPRIGHT}
enum AUDIOBUS{SFX,LEFT,RIGHT}

@export var punchDirection : hitDirections = hitDirections.LEFT
@export var damage = 1.0
@export var meter = 1.0
@export var flip = false
@export var hitState = "DamageN"
@export var upper = false
@export var hitlagMul = 1.0
@export var shakeMul = 1.0
@export var audioBus : AUDIOBUS = AUDIOBUS.SFX
@export var sfx = "Damage3"
@export var volume = 1.0
@export var pitch = 1.0
@export var effect = "HIT"
@export var effectX = 0.0
@export var effectY = 0.0
@export var scaleX = 1.0
@export var scaleY = 1.0




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
