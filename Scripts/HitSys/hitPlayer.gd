class_name HitPlayer
extends Node

enum hitDirections{LEFT,RIGHT,UPLEFT,UPRIGHT}
enum AUDIOBUS{SFX,Left,Right}
enum ANIMDIR{L,R}

@export_group("Hit Properties")
@export var punchDirection : hitDirections = hitDirections.LEFT
@export var damage = 1.0
@export var meter = 1.0
@export var hitlagMul = 1.0
@export var shakeMul = 1.0
@export var upper = false
@export var flip = false
@export var endStun = false
@export_group("Block")
@export var blockHitlag = 5
@export var blockShake = 10
@export var blockEffectY = 60
@export_group("Animation")
@export var animDir : ANIMDIR = ANIMDIR.R
@export var hitAnim = "DamageLw"
@export var hitAnimBackup = "DamageLw"
@export var dizzyAnim = "None"
@export_group("Audio")
@export var audioBus : AUDIOBUS = AUDIOBUS.SFX
@export var sfx = "Damage3"
@export var volume = 1.0
@export var pitch = 1.0
@export var soundCombo = false
@export var randomPitch = false
@export var minPitch = 0.85
@export var maxPitch = 1.0
@export_group("Hit Spark")
@export var effect = "HIT"
@export var effectX = 0.0
@export var effectY = 0.0
@export var scaleX = 1.0
@export var scaleY = 1.0




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
