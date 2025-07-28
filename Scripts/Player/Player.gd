extends Sprite2D

var frozen = false
var CURRSTATE = "Wait"
var PREVSTATE = "Wait"

var stateFrame = 0
var frameCounter = 0

var animSheets = [preload("res://Sprites/Characters/Canela/A00Wait1.png"),
preload("res://Sprites/Characters/Canela/A01AttackLw.png"),
preload("res://Sprites/Characters/Canela/A02AttackHi.png"),
preload("res://Sprites/Characters/Canela/A03AttackLw4.png"),
preload("res://Sprites/Characters/Canela/A04EscapeN.png"),
preload("res://Sprites/Characters/Canela/A05AttackHi4.png"),
preload("res://Sprites/Characters/Canela/A06EscapeS.png"),
preload("res://Sprites/Characters/Canela/A07DamageS.png"),]

var ctrl = 1 

func _ready():
	pass 

func _process(delta):
	pass

func _physics_process(delta):
	frameCounter += 1
