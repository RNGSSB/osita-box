class_name Hit
extends Node

enum HITDIRECTIONS{LEFT, RIGHT, DOWN, ALL, HORIZONTAL} 
enum HITANIMATIONS{DamageN, DamageS, DamageHi}
enum AUDIOBUS{SFX,LEFT,RIGHT}

@export_group("Hit Properties")
@export var dodgeDirection : HITDIRECTIONS = HITDIRECTIONS.LEFT
@export var damage = 1.0
@export var meter = 1.0
@export var blockable = true
@export var hitlag = 3
@export var screenShake = 25.0
@export var guardMeter = -1.0
@export var blockStun = true
@export var dodgeCombo = 3
@export var blockCombo = 3
@export var perfectCombo = 5
@export_group("Damage Animation")
@export var damageAnim : HITANIMATIONS = HITANIMATIONS.DamageN
@export var playerX = 0.0 
@export var flip = false
@export_group("Hit Position")
@export var hitLeft = true
@export var hitNeutral = true
@export var hitRight = true
@export var hitDown = true
@export_group("Sound")
@export var sfx = "Hurt"
@export var volume = 1.0
@export var pitch = 1.0
@export var audioBus : AUDIOBUS = AUDIOBUS.SFX
@export_group("Effect")
@export var effect = "HIT"
@export var scaleX = 1.0
@export var scaleY = 1.0
@export var posX = 1.0
@export var posY = 1.0
@export var zIndex = 3

func _ready() -> void:
	pass
	#print(HITANIMATIONS.keys()[damageAnim])
